from __future__ import absolute_import, division, print_function, unicode_literals
import json
import pickle
import argparse
import torch
from kobert.pytorch_kobert import get_pytorch_kobert_model
from kobert.utils import get_tokenizer
from model.net import KobertSequenceFeatureExtractor, KobertCRF, KobertBiLSTMCRF, KobertBiGRUCRF
from gluonnlp.data import SentencepieceTokenizer
from data_utils.utils import Config
from data_utils.vocab_tokenizer import Tokenizer
from data_utils.pad_sequence import keras_pad_fn
from pathlib import Path
from estimate_time import timer

from keybert import KeyBERT
from kiwipiepy import Kiwi
from transformers import BertModel
import langid
from collections import defaultdict
from nltk import sent_tokenize

import warnings
warnings.filterwarnings("ignore", category=UserWarning)

@timer
def main(parser):

    args = parser.parse_args()
    model_dir = Path(args.model_dir)
    model_config = Config(json_path=model_dir / 'config.json')

    # Vocab & Tokenizer
    # tok_path = get_tokenizer() # ./tokenizer_78b3253a26.model
    tok_path = "./ptr_lm_model/tokenizer_78b3253a26.model"
    ptr_tokenizer = SentencepieceTokenizer(tok_path)

    # load vocab & tokenizer
    with open(model_dir / "vocab.pkl", 'rb') as f:
        vocab = pickle.load(f)

    tokenizer = Tokenizer(vocab=vocab, split_fn=ptr_tokenizer, pad_fn=keras_pad_fn, maxlen=model_config.maxlen)

    # load ner_to_index.json
    with open(model_dir / "ner_to_index.json", 'rb') as f:
        ner_to_index = json.load(f)
        index_to_ner = {v: k for k, v in ner_to_index.items()}

    # Model
    model = KobertCRF(config=model_config, num_classes=len(ner_to_index), vocab=vocab)

    # load
    model_dict = model.state_dict()

    checkpoint = torch.load("./experiments/base_model_with_crf_val/best-epoch-16-step-1500-acc-0.993.bin", map_location=torch.device('cpu'))


    convert_keys = {}
    for k, v in checkpoint['model_state_dict'].items():
        new_key_name = k.replace("module.", '')
        if new_key_name not in model_dict:
            print("{} is not int model_dict".format(new_key_name))
            continue
        convert_keys[new_key_name] = v

    model.load_state_dict(convert_keys, strict=False)
    model.eval()
    device = torch.device('cuda') if torch.cuda.is_available() else torch.device('cpu')

    # n_gpu = torch.cuda.device_count()
    # if n_gpu > 1:
    #     model = torch.nn.DataParallel(model)
    model.to(device)

    decoder_from_res = DecoderFromNamedEntitySequence(tokenizer=tokenizer, index_to_ner=index_to_ner)


    bert_model = BertModel.from_pretrained('skt/kobert-base-v1')
    kw_model = KeyBERT(bert_model)


    return bert_model, kw_model, model, tokenizer, decoder_from_res
    

@timer
def keyword_extraction(bert_model, kw_model, model, tokenizer, decoder_from_res, input_text=' '):
    list_of_ner_words = []
    sentences = sent_tokenize(input_text) # 텍스트 문장 단위로 분리
    

    for sentence in sentences :
        if langid.classify(sentence)[0] != 'ko' :
            print(sentence,":",langid.classify(sentence))
            continue
        list_of_input_ids = tokenizer.list_of_string_to_list_of_cls_sep_token_ids([sentence])
        x_input = torch.tensor(list_of_input_ids).long().to(torch.device('cpu'))

        list_of_pred_ids = model(x_input)

        list_of_ner_word, decoding_ner_sentence = decoder_from_res(list_of_input_ids=list_of_input_ids, list_of_pred_ids=list_of_pred_ids)
        print("list_of_ner_word:", list_of_ner_word)
        for ner_word in list_of_ner_word:
            list_of_ner_words.append(ner_word)

    for ner_word in list_of_ner_words:
        ner_word['word'] = ner_word['word'].strip()

    
    res_keywords = []



    with open('stopwords.txt', 'r', encoding='utf-8') as f:
        stop_words = [line.strip() for line in f]

    # 영어 키워드 추출
    keywords = kw_model.extract_keywords(input_text, keyphrase_ngram_range=(1, 1), stop_words=None, top_n=20)
    for word in keywords :
        if langid.classify(word[0])[0] != 'ko' :
            res_keywords.append(word)


    kiwi = Kiwi()
    # 명사 추출 함수(한국어)
    def noun_extractor(text):
        results = []
        result = kiwi.analyze(input_text)
        for token, pos, _, _ in result[0][0]:
            if len(token) != 1 and pos.startswith('N') or pos.startswith('SL'):
                results.append(token)
        return results
    nouns = noun_extractor(input_text)
    text_noun = ' '.join(nouns)
    noun_list = nouns
#        print(nouns)

#        word_positions = []
#        word_positions = {noun:[] for noun in noun_list}

    # for noun in noun_list:
    #     start = 0
    #     while start < len(input_text):
    #         start = input_text.find(noun, start)
    #         if start == -1: break
    #         word_positions[noun].append(start)
    #         start += len(noun)


    # 한국어 키어드 추출
    keywords = kw_model.extract_keywords(text_noun, keyphrase_ngram_range=(1, 1), stop_words=stop_words, top_n=20)
    for word in keywords :
        if langid.classify(word[0])[0] == 'ko' :
            res_keywords.append(word)

    res_keywords = [list(l) for l in res_keywords]

    # res_keywords를 딕셔너리로 변환
    res_keywords_dict = {k_word[0].strip(): k_word for k_word in res_keywords}

    # 중복되는 ner_word['word'] 제거
    list_of_ner_words = list({ner_word['word'].strip(): ner_word for ner_word in list_of_ner_words}.values())

    for ner_word in list_of_ner_words:
        words = ner_word['word'].split()

        for word in words:
            k_word = res_keywords_dict.get(word)
            if k_word:
                print("개체명이 있는 키워드:",k_word, ", 개체명:",ner_word['tag'],"['"+k_word[0]+"'""  --> ", "'"+ner_word['word']+"'","로 전환]")
                # 키워드 업데이트
                k_word[0] = ner_word['word']
                # 업데이트된 키워드를 res_keywords_dict에 추가
                res_keywords_dict[ner_word['word']] = k_word
                #print(ner_word['word'],":",k_word)
                if ner_word['tag'] in ['ORG', 'LOC']:
                    k_word[1] *= 1.4
                elif ner_word['tag'] == 'PER':
                    k_word[1] *= 1.2
                elif ner_word['tag'] == 'POH':
                    k_word[1] *= 1.2
                else:
                    k_word[1] *= 0.5
                break

    # 불필요한 키워드 제거
    for ner_word in list_of_ner_words:
        words = ner_word['word'].split()
        for word in words:
            if word in res_keywords_dict and word != ner_word['word']:
                del res_keywords_dict[word]


    # res_keywords에 res_keywords_dict의 값들을 옮김
    res_keywords = list(res_keywords_dict.values())

    # res_keywords의 각 리스트를 두 번째 인덱스(가중치)에 따라 내림차순 정렬
    res_keywords.sort(key=lambda x: x[1], reverse=True)


    # 결과
    print(res_keywords)
    # for w in res_keywords :
    #     print(w[0])
    top_4 = []

    print("\n상위 4개의 키워드: ")
    unique_keywords = set()
    for w in res_keywords:
        if w[0].strip() not in unique_keywords:
            unique_keywords.add(w[0].strip())
            print(w[0].strip())
            top_4.append(w[0].strip())
        if len(unique_keywords) >= 4:
            break
    print(top_4)
    return top_4
    # top_4: 리스트 형식의 4개 이하 키워드
    # ex) ['해리포터', '유니버셜 스튜디오', '일본', '오사카']


class DecoderFromNamedEntitySequence():
    def __init__(self, tokenizer, index_to_ner):
        self.tokenizer = tokenizer
        self.index_to_ner = index_to_ner

    def __call__(self, list_of_input_ids, list_of_pred_ids):
        input_token = self.tokenizer.decode_token_ids(list_of_input_ids)[0]
        pred_ner_tag = [self.index_to_ner[pred_id] for pred_id in list_of_pred_ids[0]]

        #print("len: {}, input_token:{}".format(len(input_token), input_token))
        #print("len: {}, pred_ner_tag:{}".format(len(pred_ner_tag), pred_ner_tag))

        # ----------------------------- parsing list_of_ner_word ----------------------------- #
        list_of_ner_word = []
        entity_word, entity_tag, prev_entity_tag = "", "", ""
        for i, pred_ner_tag_str in enumerate(pred_ner_tag):
            if "B-" in pred_ner_tag_str:
                entity_tag = pred_ner_tag_str[-3:]

                if prev_entity_tag != entity_tag and prev_entity_tag != "":
                    list_of_ner_word.append({"word": entity_word.replace("▁", " "), "tag": prev_entity_tag, "prob": None})

                entity_word = input_token[i]
                prev_entity_tag = entity_tag
            elif "I-"+entity_tag in pred_ner_tag_str:
                entity_word += input_token[i]
            else:
                if entity_word != "" and entity_tag != "":
                    list_of_ner_word.append({"word":entity_word.replace("▁", " "), "tag":entity_tag, "prob":None})
                entity_word, entity_tag, prev_entity_tag = "", "", ""


        # ----------------------------- parsing decoding_ner_sentence ----------------------------- #
        decoding_ner_sentence = ""
        is_prev_entity = False
        prev_entity_tag = ""
        is_there_B_before_I = False

        for token_str, pred_ner_tag_str in zip(input_token, pred_ner_tag):
            token_str = token_str.replace('▁', ' ')  # '▁' 토큰을 띄어쓰기로 교체

            if 'B-' in pred_ner_tag_str:
                if is_prev_entity is True:
                    decoding_ner_sentence += ':' + prev_entity_tag+ '>'

                if token_str[0] == ' ':
                    token_str = list(token_str)
                    token_str[0] = ' <'
                    token_str = ''.join(token_str)
                    decoding_ner_sentence += token_str
                else:
                    decoding_ner_sentence += '<' + token_str
                is_prev_entity = True
                prev_entity_tag = pred_ner_tag_str[-3:] # 첫번째 예측을 기준으로 하겠음
                is_there_B_before_I = True

            elif 'I-' in pred_ner_tag_str:
                decoding_ner_sentence += token_str

                if is_there_B_before_I is True: # I가 나오기전에 B가 있어야하도록 체크
                    is_prev_entity = True
            else:
                if is_prev_entity is True:
                    decoding_ner_sentence += ':' + prev_entity_tag+ '>' + token_str
                    is_prev_entity = False
                    is_there_B_before_I = False
                else:
                    decoding_ner_sentence += token_str

        return list_of_ner_word, decoding_ner_sentence


if __name__ == '__main__': # 스크립트 파일이 실행되면

    parser = argparse.ArgumentParser()
    parser.add_argument('--data_dir', default='./data_in', help="Directory containing config.json of data")
    # parser.add_argument('--model_dir', default='./experiments/base_model', help="Directory containing config.json of model")
    parser.add_argument('--model_dir', default='./experiments/base_model_with_crf_val', help="Directory containing config.json of model")
    # parser.add_argument('--model_dir', default='./experiments/base_model_with_crf', help="Directory containing config.json of model")
    # parser.add_argument('--model_dir', default='./experiments/base_model_with_bilstm_crf', help="Directory containing config.json of model")
    # parser.add_argument('--model_dir', default='./experiments/base_model_with_bigru_crf', help="Directory containing config.json of model")

    bert_model, kw_model, model, tokenizer, decoder_from_res = main(parser)
    while(True) :
        text = input("텍스트를 입력하세요: ")
        # text_encoded = text.encode('utf-8', errors='replace')
        top_4 = keyword_extraction(bert_model, kw_model, model, tokenizer, decoder_from_res, text_encoded)
        # top_4: 리스트 형식의 4개 이하 키워드
        # ex) ['해리포터', '유니버셜 스튜디오', '일본', '오사카']





