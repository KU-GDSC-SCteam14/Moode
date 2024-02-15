from timer import timer

from keybert import KeyBERT
from kiwipiepy import Kiwi
from transformers import BertModel
import langid
from nltk import sent_tokenize

import warnings
warnings.filterwarnings("ignore", category=UserWarning)

    

@timer
def keyword_extraction(input_text=' '):
    sentences = sent_tokenize(input_text) # 텍스트 문장 단위로 분리
    bert_model = BertModel.from_pretrained('skt/kobert-base-v1')
    kw_model = KeyBERT(bert_model)

    
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


    # 한국어 키어드 추출
    keywords = kw_model.extract_keywords(text_noun, keyphrase_ngram_range=(1, 1), stop_words=stop_words, top_n=20)
    for word in keywords :
        if langid.classify(word[0])[0] == 'ko' :
            res_keywords.append(word)


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




if __name__ == '__main__': # 스크립트 파일이 실행되면

    while(True) :
        text = input("텍스트를 입력하세요: ")
        top_4 = keyword_extraction(text)
        # top_4: 리스트 형식의 4개 이하 키워드
        # ex) ['해리포터', '유니버셜 스튜디오', '일본', '오사카']





