const {User, Product} = require('../models/models')
const { where } = require('sequelize')

class FridgeController{

    async createProduct(req, res, next){

        const {name, bestBeforeDate, quantity} = req.body

        try{

            if(!name || !bestBeforeDate || !quantity){
                return res.status(400).json({name: "", bestBeforeDate: new Date(), quantity: 0})
            }

            const newProduct = await Product.create({name, bestBeforeDate, quantity, userId: req.user.id})

            return res.status(201).json(newProduct)

        }
        catch(e){
            return res.status(500).json({name: "", bestBeforeDate: new Date(), quantity: 0})
        }
    }

    async updateProduct(req, res, next){
        
        const {name, bestBeforeDate, quantity} = req.body
        const id = req.params.productId

        try{

            if(!id){
                return res.status(400).json({name: "", bestBeforeDate: new Date(), quantity: 0})
            }

            const product = await Product.findOne({where: {id}})

            if(!product || product.userId != req.user.id){
                return res.status(400).json({name: "", bestBeforeDate: new Date(), quantity: 0})
            }

            if(name){
                product.name = name;
            }

            if(bestBeforeDate && !isNaN(new Date(bestBeforeDate))){
                product.bestBeforeDate = bestBeforeDate
            }

            if(quantity){
                product.quantity = quantity;
            }

            product.save()

            return res.status(200).json({product: product})

        }
        catch(e){
            console.log(e);
            return res.status(500).json({name: "", bestBeforeDate: new Date(), quantity: 0})
        }
    }

    async deleteProduct(req, res, next){

        const id = req.params.productId

        try{

            const product = await Product.findOne({where: {id}})

            if(!product || product.userId != req.user.id){
                return res.status(400).json()
            }

            product.destroy()

            return res.status(200).json()

        }
        catch(e){
            return res.status(500).json()
        }
    }

    async getAllProducts(req, res, next){

        const userId = req.user.id;

        try{

            const products = await Product.findAll({
                where: {userId}, 
                attributes: {
                    exclude: ['createdAt', 'updatedAt']
                }})

            return res.status(200).json({products})

        }
        catch(e){
            return res.status(500).json()
        }
    }

}

module.exports = new FridgeController();