import os
from openai import OpenAI
import openai
from dotenv import load_dotenv

load_dotenv()
openai.api_key = os.getenv('OPENAI_API_KEY')





while(True): 
    text = input("텍스트 입력: ")
    client = OpenAI(api_key=openai.api_key)
    response = client.chat.completions.create(
        messages=[
            {"role": "system", "content": "You are a helpful assistant that empathizes with the user's feelings."},
            {"role": "user", "content": text}
        ],
        model="ft:gpt-3.5-turbo-1106:personal::8tMKeom4"
    )
    print("chat gpt의 응답: ")
    print(response.choices[0].message.content)
