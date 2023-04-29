const sequelize = require('../db')
const {DataTypes} = require('sequelize')


const User = sequelize.define('user', {
    id: {type: DataTypes.INTEGER, primaryKey: true, autoIncrement: true},
    email: {type: DataTypes.STRING, unique: true},
    password: {type: DataTypes.STRING},
})

const Product = sequelize.define('product', {
    id: {type: DataTypes.INTEGER, primaryKey: true, autoIncrement: true},
    name: {type: DataTypes.STRING},
    bestBeforeDate: {type: DataTypes.DATE},
    quantity: {type: DataTypes.INTEGER}
})

User.hasMany(Product, {onDelete: 'cascade'})
Product.belongsTo(User)

module.exports = {
    User, 
    Product
}