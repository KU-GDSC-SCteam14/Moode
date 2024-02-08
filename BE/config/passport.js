const passport = require('passport')
const GoogleStrategy = require('passport-google-oauth20').Strategy
const AppleStrategy = require('passport-apple')
const User = require('./models/User') // User 모델 가져오기

// Google 전략 설정
passport.use(
  new GoogleStrategy(
    {
      clientID: process.env.GOOGLE_CLIENT_ID,
      clientSecret: process.env.GOOGLE_CLIENT_SECRET,
      callbackURL: '/auth/google/callback',
    },
    (accessToken, refreshToken, profile, done) => {
      // 사용자 프로필을 사용하여 사용자 찾기 또는 생성
      User.findOrCreate({ googleId: profile.id }, function (err, user) {
        return done(err, user)
      })
    },
  ),
)

// Apple 전략 설정 (기존 코드)
passport.use(
  new AppleStrategy(
    {
      clientID: process.env.APPLE_CLIENT_ID,
      teamID: process.env.APPLE_TEAM_ID,
      keyID: process.env.APPLE_KEY_ID,
      privateKeyLocation: process.env.APPLE_PRIVATE_KEY_PATH,
      callbackURL: '/auth/apple/callback',
    },
    (accessToken, refreshToken, profile, done) => {
      // 사용자 프로필을 사용하여 사용자 찾기 또는 생성
      User.findOrCreate({ appleId: profile.id }, function (err, user) {
        return done(err, user)
      })
    },
  ),
)

module.exports = passport
