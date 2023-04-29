const Router = require('express')
const { getAllProducts, createProduct, updateProduct, deleteProduct } = require('../controllers/fridgeController')
const router = new Router()

router.get('/allProducts', getAllProducts)
router.put('/product', createProduct)
router.patch('/product/:productId', updateProduct)
router.delete('/product/:productId', deleteProduct)

module.exports = router