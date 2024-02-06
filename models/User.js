const mongoose = require('mongoose')

const userSchema = new mongoose.Schema({
  googleId: String,
  appleId: String,
  // 추가적인 필드
})

userSchema.statics.findOrCreate = function findOrCreate(profile, cb) {
  const userObj = new this()
  this.findOne({ googleId: profile.id }, function (err, result) {
    if (!result) {
      // Google 프로필에서 필요한 정보를 추출하여 저장
      userObj.googleId = profile.id
      // 다른 필드 설정
      userObj.save(cb)
    } else {
      cb(err, result)
    }
  })
}

const User = mongoose.model('User', userSchema)

module.exports = User
