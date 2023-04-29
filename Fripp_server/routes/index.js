const Router = require('express')
const router = new Router()

const userRouter = require('./userRouter')
const fridgeRouter = require('./fridgeRouter')
const authMiddleware = require('../middleware/authMiddleware')

router.use('/user', userRouter)
router.use('/fridge', authMiddleware, fridgeRouter)

module.exports = router