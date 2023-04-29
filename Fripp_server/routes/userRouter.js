const Router = require('express')
const authMiddleware = require('../middleware/authMiddleware')
const { registration, authorization, check } = require('../controllers/userController')
const router = new Router()

router.put('/signUp', registration)
router.post('/signIn', authorization)
router.get('/auth', authMiddleware, check)

module.exports = router