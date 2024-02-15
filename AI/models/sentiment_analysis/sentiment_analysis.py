import nltk
from estimate_time import timer
from vaderSentiment.vaderSentiment import SentimentIntensityAnalyzer
from nltk import sent_tokenize
from translate import translate_text


@timer
def sentiment_analysis(text=' '):

  translated_text = translate_text(text, "gdsc-solutionchallenge-team14")
  text = translated_text.translations[0].translated_text

  sentences = sent_tokenize(text) # 텍스트 문장 단위로 분리



  res_compound = []
  analyzer = SentimentIntensityAnalyzer()
  for sentence in sentences:
#    translated_text = translate_text(sentence, "gdsc-solutionchallenge-team14") # 번역
    vs = analyzer.polarity_scores(sentence)
    print("{:-<65} {}".format(sentence, str(vs))) # neg: 부정, neu: 중립, pos: 긍정, compound: 통합(+:긍정 -:부정 -> 1 ~ -1)

    if vs['compound'] < 0.1 and vs['compound'] > -0.1 : # 감정이 중립인 문장은 평균계산에서 제외
          continue
    compound = vs['compound'] ** 2 * 2
    if vs['compound'] < 0:
      compound = compound * -1
    res_compound.append(compound)
    print("compound 계산 후:", compound,"\n")

  avg_compound = 0
  if sum(res_compound) != 0:
    avg_compound = sum(res_compound) / len(res_compound) # 전체 텍스트 감정 평균


  print("전체 평균 =", avg_compound)

  if avg_compound >= 0.7 :
     sentiment = 'very happy'
  elif avg_compound >= -0.2 :
     sentiment = 'happy'
  elif avg_compound >= -0.7 :
     sentiment = 'sad'
  else :
     sentiment = 'very sad'

  return sentiment # 'very happy' 'happy' 'sad' 'very sad' 중 하나



while(True) :
  text = input("텍스트 입력: ")
  sentiment = sentiment_analysis(text) # 'very happy' 'happy' 'sad' 'very sad' 중 하나