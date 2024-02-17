import os
from openai import OpenAI
import openai

openai.api_key = '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'



client = OpenAI(api_key=openai.api_key)

response = client.chat.completions.create(
    messages=[
        {"role": "system", "content": "You are a helpful assistant that empathizes with the user's feelings."},
        {"role": "user", "content": "재수하고 있던 어느날이었다. 오늘 아침에 씻고 밥먹고 공부하는 곳으로가서 공부하고 오늘도 반복되는 생활을 하였다. 오늘은 사설 모의고사 있는닐이었다. 모의고사를 치고 오답을 하며 오늘하루도 지나갔다."}
    ],
    model="ft:gpt-3.5-turbo-1106:personal::8s8AiNQE"
)

print(response.choices[0].message.content)
