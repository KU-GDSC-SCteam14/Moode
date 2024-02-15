from __future__ import absolute_import, division, print_function, unicode_literals
from flask import Flask, render_template, request
from keyword_extraction import DecoderFromNamedEntitySequence, main, keyword_extraction
import json
import argparse
import pickle
import torch
from gluonnlp.data import SentencepieceTokenizer
from model.net import KobertCRF
from data_utils.utils import Config
from data_utils.vocab_tokenizer import Tokenizer
from data_utils.pad_sequence import keras_pad_fn
from pathlib import Path
from estimate_time import timer
from keyword_extraction import keyword_extraction

from keybert import KeyBERT
from kiwipiepy import Kiwi
from transformers import BertModel
import langid
from collections import defaultdict
from nltk import sent_tokenize
app = Flask(__name__)


@app.route('/')
def hello_world():
    return 'Hello World!'

@app.route('/test')
def test():
    return render_template('post.html')

@app.route('/post', methods=['POST'])
def post():
    value = request.form['input']
#-------------------------------------------------------------------------------------------- 모델 로딩
    model_dir = Path('./experiments/base_model_with_crf_val')
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
#----------------------------------------------------------------------------------------------- 모델 로딩

#----------------------------------------------------------------------------------------------- 모델 출력
    while(True) : # 모델 출력 반복
        text = input("텍스트를 입력하세요: ")
        top_4 = keyword_extraction(bert_model, kw_model, model, tokenizer, decoder_from_res, text)
        # top_4: 리스트 형식의 4개 이하 키워드
        # ex) ['해리포터', '유니버셜 스튜디오', '일본', '오사카']
    

if __name__ == '__main__':
    # app.debug = True
    app.run(host='0.0.0.0')



    # model_dir = Path('./experiments/base_model_with_crf_val')
    # model_config = Config(json_path=model_dir / 'config.json')
    # # load vocab & tokenizer
    # tok_path = "ptr_lm_model/tokenizer_78b3253a26.model"
    # ptr_tokenizer = SentencepieceTokenizer(tok_path)

    # with open(model_dir / "vocab.pkl", 'rb') as f:
    #     vocab = pickle.load(f)
    # tokenizer = Tokenizer(vocab=vocab, split_fn=ptr_tokenizer, pad_fn=keras_pad_fn, maxlen=model_config.maxlen)

    # # load ner_to_index.json
    # with open(model_dir / "ner_to_index.json", 'rb') as f:
    #     ner_to_index = json.load(f)
    #     index_to_ner = {v: k for k, v in ner_to_index.items()}

    # # model
    # model = KobertCRFViz(config=model_config, num_classes=len(ner_to_index), vocab=vocab)

    # # load
    # model_dict = model.state_dict()
    # checkpoint = torch.load("./experiments/base_model_with_crf_val/best-epoch-16-step-1500-acc-0.993.bin",
    #                         map_location=torch.device('cpu'))
    # convert_keys = {}
    # for k, v in checkpoint['model_state_dict'].items():
    #     new_key_name = k.replace("module.", '')
    #     if new_key_name not in model_dict:
    #         print("{} is not int model_dict".format(new_key_name))
    #         continue
    #     convert_keys[new_key_name] = v

    # model.load_state_dict(convert_keys)
    # model.eval()
    # device = torch.device('cuda') if torch.cuda.is_available() else torch.device('cpu')
    # model.to(device)
    # decoder_from_res = DecoderFromNamedEntitySequence(tokenizer=tokenizer, index_to_ner=index_to_ner)

    # input_text = value
    # list_of_input_ids = tokenizer.list_of_string_to_list_of_cls_sep_token_ids([input_text])
    # x_input = torch.tensor(list_of_input_ids).long()
    # list_of_pred_ids, _ = model(x_input)
    # list_of_ner_word, decoding_ner_sentence = decoder_from_res(list_of_input_ids=list_of_input_ids,
    #                                                            list_of_pred_ids=list_of_pred_ids)
    # return {'word': list_of_ner_word, 'decoding': decoding_ner_sentence}