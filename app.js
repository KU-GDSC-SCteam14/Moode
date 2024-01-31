const express = require('express')
const app = express()

app.use(express.json())

// 사용자 인증 로그인
app.post('/auth/login', (req, res) => {
  // 실제 구현에서는 제공된 토큰으로 사용자 인증을 처리해야 합니다.
  res.json({
    success: true,
    token: 'app_generated_token',
    isNewUser: false, // 예시 값
  })
})

// 프로필 정보 조회
app.get('/user/profile', (req, res) => {
  // 인증된 토큰을 확인하고 사용자 프로필 정보를 반환해야 합니다.
  res.json({
    username: 'John Doe',
    profileImage: 'url_to_image',
    loginStatus: 'logged_in',
  })
})

// 일기 작성
app.post('/diary', (req, res) => {
  // 여기에서 실제 데이터베이스에 일기를 저장하는 로직을 구현해야 합니다.
  res.status(201).json({
    success: true,
    message: 'Diary created successfully',
  })
})

// 일기 목록 조회
app.get('/diaries', (req, res) => {
  // 실제 구현에서는 데이터베이스에서 일기 목록을 조회하여 반환합니다.
  res.json({
    diaries: [
      {
        date: 'YYYY-MM-DD',
        content: 'Diary content',
        emotion: 'Happy',
        keywords: ['keyword1', 'keyword2'],
      },
    ],
  })
})

// 키워드 조회
app.get('/keywords', (req, res) => {
  // 데이터베이스에서 키워드를 조회하여 반환합니다.
  res.json({
    keywords: ['keyword1', 'keyword2', 'keyword3'],
  })
})

// 키워드 수정/병합
app.put('/keywords', (req, res) => {
  // 키워드 수정 또는 병합 처리 로직 구현
  res.json({
    success: true,
    message: 'Keyword updated successfully',
  })
})

// 서버 시작
const PORT = process.env.PORT || 3000
app.listen(PORT, () => {
  console.log(`Server is running on port ${PORT}`)
})
