const express = require('express')
const cors = require('cors') // CORS 미들웨어를 위한 require
const morgan = require('morgan') // morgan 미들웨어를 위한 require
const { initializeApp } = require('firebase-admin/app')
const passport = require('passport')
const jwt = require('jsonwebtoken')
const helmet = require('helmet')
const cookieParser = require('cookie-parser') // cookie-parser 불러오기
require('dotenv').config() // 환경 변수를 로드하기 위해 dotenv.config() 호출
require('./config/passport')(passport)
const db = require('./db')
const axios = require('axios')
const admin = require('firebase-admin')
const cron = require('node-cron')

const serviceAccount = require('/home/junh1101/Mindfulness-app/BE/gdsc-solutionchallenge-team14-firebase-adminsdk-4gvqq-2f3b84a318.json')
initializeApp({
  credential: admin.credential.cert(serviceAccount),
})

const app = express()

app.use(
  cors({
    origin: process.env.CORS_ORIGIN, // .env 파일에서 클라이언트 도메인을 설정할 수 있습니다.
    credentials: true, // 쿠키를 전달하도록 설정
  }),
)
app.use(express.json())
app.use(morgan('dev')) // 개발용 로그 포맷 사용
app.use(passport.initialize())
app.use(helmet())
app.use(cookieParser()) // cookie-parser사용

async function testDBConnection() {
  try {
    await db.query('SELECT 1') // 간단한 쿼리를 실행하여 DB 연결을 테스트합니다.
    console.log('Database connection successful')
  } catch (error) {
    console.error('Unable to connect to the database:', error)
  }
}

// 앱 시작 시 DB 연결을 테스트합니다.
testDBConnection()

/*
// 알림 테스트
cron.schedule('* * * * *', async () => {
  console.log('알림을 처리합니다.');

  try {
    // Messaging 테이블에서 모든 알림 예약 정보 조회
    const notifications = await db.query('SELECT * FROM Messaging');

    // 조회된 모든 알림 예약 정보에 따라 FCM 메시지 전송
    notifications.forEach(async (notification) => {
      const { FCM_Token } = notification;

      // FCM 메시지 구성
      const message = {
        notification: {
          title: '주간 긍정일기 알림',
          body: '주간 긍정일기를 확인해보세요!',
        },
        token: FCM_Token,
      };

      // FCM 메시지 전송
      try {
        const response = await admin.messaging().send(message);
        console.log('성공적으로 메시지를 보냈습니다:', response);
      } catch (error) {
        console.log('메시지 전송 실패:', error);
      }
    });
  } catch (error) {
    console.error('알림 처리 중 오류 발생:', error);
  }
});
*/


// 매일 23:59에 알림 예약
cron.schedule('* * * * *', async () => {
  console.log('Scheduling notifications for 23:59.');

  function getTomorrow() {
    const days = ['일요일', '월요일', '화요일', '수요일', '목요일', '금요일', '토요일'];
    const todayIndex = new Date().getDay() + 1;
    const tomorrowIndex = (todayIndex + 0) % 7;
    console.log('Notification sending state : day');
    console.log(days[tomorrowIndex]);
    return days[tomorrowIndex];
  }

  try {
    const tomorrow = getTomorrow();
    const notifications = await db.query('SELECT * FROM Messaging WHERE Notifyday = ?', [tomorrow]);


    for (const notification of notifications) {
      const { User_ID, NotifyTime, FCM_Token } = notification;
      // NotifyTime을 문자열로 취급하여 split 함수를 사용합니다.
      const [dateString, timeString] = NotifyTime.toString().split('T');
      const [hours, minutes] = timeString.split(':');

      const hoursInt = parseInt(hours, 10);
      const minutesInt = parseInt(minutes, 10);
      console.log(hours);
      console.log(minutes);
      console.log(hoursInt);
      console.log(minutesInt);
      const scheduleTime = new Date();
      scheduleTime.setDate(scheduleTime.getDate() + 0); // Set to tomorrow
      scheduleTime.setHours(hoursInt, minutesInt, 0); // Set to specific time
      console.log('Notification sending state : time');
      console.log(scheduleTime);

      const now = new Date();
      console.log(now);
      if (now == scheduleTime) {
        console.log('Notification sending state : 1');
        const delay = scheduleTime.getTime() - now.getTime();
        console.log('Notification sending state : 2');
        setTimeout(async () => {
          console.log('Notification sending state : 3');
          const message = {
            notification: {
              title: '주간 긍정일기 알림',
              body: '주간 긍정일기를 확인해보세요!',
            },
            token: FCM_Token,
          };
          try {
            console.log('Notification sending state : 4');
            const response = await admin.messaging().send(message);
            console.log('Notification sent successfully:', response);
          } catch (error) {
            console.log('Failed to send notification:', error);
          }
        }, delay);
      }
    }
  } catch (error) {
    console.error('Error scheduling notifications:', error);
  }
});



// Google OAuth
app.get(
  '/auth/google',
  passport.authenticate('google', { scope: ['profile', 'email'] }),
)

app.get(
  '/auth/google/callback',
  passport.authenticate('google', { failureRedirect: '/login' }),
  (req, res) => {
    const token = jwt.sign({ id: req.user.id }, process.env.JWT_SECRET_KEY, {
      expiresIn: '1h',
    })
    // 쿠키에 JWT 저장 및 클라이언트로 전송
    res.cookie('jwt', token, { httpOnly: true, secure: true }) // secure: true는 HTTPS 환경에서만 쿠키를 전송
    res.redirect('/')
  },
)

// Apple OAuth
app.get(
  '/auth/apple',
  passport.authenticate('apple', { scope: ['name', 'email'] }),
)

app.get(
  '/auth/apple/callback',
  passport.authenticate('apple', { failureRedirect: '/login' }),
  (req, res) => {
    const token = jwt.sign({ id: req.user.id }, process.env.JWT_SECRET_KEY, {
      expiresIn: '1h',
    })
    // 쿠키에 JWT 저장 및 클라이언트로 전송
    res.cookie('jwt', token, { httpOnly: true, secure: true })
    res.redirect('/')
  },
)

// 유저 저장 API
app.post('/User', async (req, res) => {
  console.log('User 저장 처리 시작')
  const {
    Name,
    email,
    Signup_date,
    is_Google,
    is_Apple,
    Provider_ID,
    Access_Token,
    Refresh_Token,
    Token_Expiry_Date,
    FCM_Token,
    Profile_Picture_URL,
  } = req.body

  try {
    console.log('User 저장 진입')
    const result = await db.query(
      `INSERT INTO User (Name, email, Signup_date, is_Google, is_Apple, Provider_ID, Access_Token, Refresh_Token, Token_Expiry_Date, FCM_Token, Profile_Picture_URL) VALUES (?, ?, ?, ?, ?, ?, ?, ?, ?, ?, ?)`,
      [
        Name,
        email,
        Signup_date,
        is_Google,
        is_Apple,
        Provider_ID,
        Access_Token,
        Refresh_Token,
        Token_Expiry_Date,
        FCM_Token,
        Profile_Picture_URL,
      ],
    )
    console.log('User 저장 성공')
    console.log(result)
    res.status(201).json({ success: true, userid: result.insertId })
  } catch (error) {
    console.error(error)
    res.status(500).json({ success: false, message: 'Internal Server Error' })
  }
})

// 유저 삭제 API
app.delete('/User/:id', async (req, res) => {
  const userId = req.params.id
  try {
    await db.query(`DELETE FROM User WHERE User_ID = ?`, [userId])
    res.json({
      success: true,
      message: `User with ID ${userId} has been deleted`,
    })
  } catch (error) {
    console.error(error)
    res.status(500).json({ success: false, message: 'Internal Server Error' })
  }
})

// 일기 저장 API
app.post('/diary', async (req, res) => {
  console.log('Diary 저장 처리 시작')
  const {
    User_ID,
    Title,
    Content_1,
    Content_2,
    Content_3,
    Content_4,
    Date,
    Mood_ID,
  } = req.body

  try {
    console.log('Diary 저장 진입')
    const result = await db.query(
      `INSERT INTO Diary (User_ID, Title, Content_1, Content_2, Content_3, Content_4, Date, Mood_ID) VALUES (?, ?, ?, ?, ?, ?, ?, ?)`,
      [
        User_ID,
        Title,
        Content_1,
        Content_2,
        Content_3,
        Content_4,
        Date,
        Mood_ID,
      ],
    )
    console.log('Diary 저장 성공')
    console.log(result)
    res.status(201).json({ success: true, diaryId: result.insertId })
  } catch (error) {
    console.error(error)
    res.status(500).json({ success: false, message: 'Internal Server Error' })
  }
})

// 일기 목록 조회 API
app.get('/diaries/:id', async (req, res) => {
  const userId = req.params.id
  try {
    const diaries = await db.query(`SELECT * FROM Diary WHERE User_ID = ?`, [
      userId,
    ])
    res.json({ success: true, diaries })
  } catch (error) {
    console.error(error)
    res.status(500).json({ success: false, message: 'Internal Server Error' })
  }
})

// 일기 삭제 API
app.delete('/user/:userId/diary/:diaryId', async (req, res) => {
  const { userId, diaryId } = req.params // URL에서 userId와 diaryId 파라미터를 추출

  try {
    // 특정 사용자의 특정 일기를 삭제
    const result = await db.query(
      `DELETE FROM Diary WHERE User_ID = ? AND Diary_ID = ?`,
      [userId, diaryId],
    )

    // 삭제된 행이 없는 경우, 존재하지 않는 일기 ID이거나 사용자 ID에 해당하는 일기가 아님
    if (result.affectedRows === 0) {
      return res.status(404).json({
        success: false,
        message: 'Diary not found or not authorized to delete this diary',
      })
    }

    res.json({
      success: true,
      message: `Diary with ID ${diaryId} for user ${userId} has been deleted`,
    })
  } catch (error) {
    console.error(error)
    res.status(500).json({ success: false, message: 'Internal Server Error' })
  }
})

// 감정일기 작성 및 키워드 추출, 감정 분석
app.get('/AIkeyword', (req, res) => {
  // Flask 서버의 URL을 변수로 설정
  const flaskServerUrl = 'http://localhost:5000/post'
  console.log(flaskServerUrl)

  // 요청 본문에 들어갈 데이터. req.query를 직접 사용
  const requestData = req.query
  console.log(requestData)

  axios
    .post(flaskServerUrl, requestData)
    .then((response) => {
      // Flask에서 받은 응답을 그대로 클라이언트에게 전달
      console.log('전송완료')
      // 응답이 이미 전송되었는지 확인
      if (!res.headersSent) {
        res.json(response.data)
        console.log(response.data)
      }
    })
    .catch((error) => {
      console.log('전송실패')
      console.error('Error:', error)
      if (!res.headersSent) {
        res.status(500).json({ success: false, message: 'An error occurred' })
      }
    })
})

app.get('/AImood', (req, res) => {
  // Flask 서버의 URL을 변수로 설정
  const flaskServerUrl = 'http://localhost:5001/post'
  console.log(flaskServerUrl)

  // 요청 본문에 들어갈 데이터. req.query를 직접 사용
  const requestData = req.query
  console.log(requestData)

  axios
    .post(flaskServerUrl, requestData)
    .then((response) => {
      // Flask에서 받은 응답을 그대로 클라이언트에게 전달
      console.log('전송완료')
      // 응답이 이미 전송되었는지 확인
      if (!res.headersSent) {
        res.json(response.data)
        console.log(response.data)
      }
    })
    .catch((error) => {
      console.log('전송실패')
      console.error('Error:', error)
      if (!res.headersSent) {
        res.status(500).json({ success: false, message: 'An error occurred' })
      }
    })
})

app.post('/schedule-notification', async (req, res) => {
  const { User_ID, Notifyday, NotifyTime } = req.body;

  try {
    // User 테이블에서 해당 User_ID의 FCM_Token 조회
    const userResult = await db.query(
      'SELECT FCM_Token FROM User WHERE User_ID = ?',
      [User_ID]
    );

    if (userResult.length === 0) {
      return res.status(404).json({
        success: false,
        message: '해당 사용자의 토큰을 찾을 수 없습니다.'
      });
    }

    const FCM_Token = userResult[0].FCM_Token;

    // Messaging 테이블에 User_ID가 이미 존재하는지 확인
    const existingNotification = await db.query(
      'SELECT * FROM Messaging WHERE User_ID = ?',
      [User_ID]
    );

    if (existingNotification.length > 0) {
      // 기존 데이터가 있으면 시간, NotifyDay, FCM_Token 업데이트
      await db.query(
        'UPDATE Messaging SET Notifyday = ?, NotifyTime = ?, FCM_Token = ? WHERE User_ID = ?',
        [Notifyday, NotifyTime, FCM_Token, User_ID]
      );
    } else {
      // 새로운 데이터 삽입
      await db.query(
        'INSERT INTO Messaging (User_ID, Notifyday, NotifyTime, FCM_Token) VALUES (?, ?, ?, ?)',
        [User_ID, Notifyday, NotifyTime, FCM_Token]
      );
    }

    console.log('알림 예약 정보가 성공적으로 저장되었습니다.');

    res.status(201).json({
      success: true,
      message: '알림 예약이 성공적으로 저장되었습니다.'
    });
  } catch (error) {
    console.error('알림 예약 정보 저장 중 오류 발생:', error);
    res.status(500).json({
      success: false,
      message: '알림 예약 정보를 저장하는 동안 오류가 발생했습니다.'
    });
  }
});

app.post('/delete-notification', async (req, res) => {
  const { User_ID } = req.body;

  try {
    await db.query('DELETE FROM Messaging WHERE User_ID = ?', [User_ID]);
    console.log('Notification settings were successfully deleted.');
    res.status(200).json({
      success: true,
      message: 'Notification settings were successfully deleted.'
    });
  } catch (error) {
    console.error('Failed to delete notification settings:', error);
    res.status(500).json({
      success: false,
      message: 'Failed to delete notification settings.'
    });
  }
});



/*

// 전체 일기 데이터 백업
app.post('/backup', (req, res) => {
  // 사용자의 전체 일기 데이터 백업 로직
  res.json({
    success: true,
    message: 'Backup completed successfully',
  });
});

// 백업 데이터 복원
app.post('/restore', (req, res) => {
  // 백업 데이터 복원 로직
  // 복원 후 백업된 데이터는 파기

  res.json({
    success: true,
    message: 'Data restored successfully',
  });
});

*/

// 에러 핸들링 미들웨어
app.use((err, req, res) => {
  console.error(err.stack) // 에러 로그 출력

  const statusCode = err.statusCode || 500
  const message = err.message || 'Internal Server Error'

  res.status(statusCode).send(message)
})

// 서버 시작
const PORT = process.env.PORT || 3000 // .env 파일에서 포트 번호를 설정합니다.
app.listen(PORT, () => {
  console.log(`Server is running on port ${PORT}`)
})
