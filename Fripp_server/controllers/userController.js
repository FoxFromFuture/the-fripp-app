const {User} = require('../models/models')
const { where } = require('sequelize')
const jwt = require('jsonwebtoken')

const generateJWT = (id) => {
    return jwt.sign({id}, process.env.JWT_SECRET_KEY, {expiresIn: "30d"})
}

class UserController {

    async registration(req, res, next){
        const {email, password} = req.body
        try{

            if(!email || !password){
                return res.status(400).json({token: ""})
            }

            const candidate = await User.findOne({where: {email}})
            if(candidate){
                return res.status(400).json({token: ""})
            }

            const user = await User.create({email, password})

            return res.status(201).json({token: generateJWT(user.id)})
        } catch(e){
            console.log(e);
            return res.status(500).json({token: ""})
        }
        
    }

    async authorization(req, res, next){
        const {email, password} = req.body
        try{

            if(!email || !password){
                return res.status(400).json({token: ""})
            }

            const user = await User.findOne({where: {email}})
            if(!user){
                return res.status(400).json({token: ""})
            }

            if(password != user.password){
                return res.status(400).json({token: ""})
            }

            return res.json({token: generateJWT(user.id)})
        } catch(e){
            console.log(e);
            return res.status(500).json({token: ""})
        }
    }

    async check(req, res, next){
        return res.json({token: generateJWT(req.user.id)})
    }
}

module.exports = new UserController()