## Google Cloud Translation API 사용법

1. Google Cloud 가입(로그인) 후 Translation API 검색해서 프로젝트에 추가
2. https://cloud.google.com/sdk/docs/install?hl=ko 에서 gcloud CLI 설치
3. PowerShell 등 명령어 창에 명령어 입력 후 프로젝트 선택, 로그인
```powershell
gcloud init
```
4. 오류 뜨면 명령어 입력해서 다시 로그인
```powershell
gcloud auth application-default print-access-token
```
(더 자세한 설명은 https://cloud.google.com/translate/docs/setup?hl=ko&_ga=2.194036137.-522249066.1705043250#python 참고)
