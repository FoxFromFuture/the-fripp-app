require('dotenv').config()
const express = require('express')
const sequelize = require('./db')
const cors = require('cors')
const PORT = process.env.PORT || 3001;
const app = express()
const router = require('./routes/index')

app.use(cors())
app.use(express.json())
app.use('/api', router)

const start = async () => {
    try{
        await sequelize.authenticate()
        await sequelize.sync()
        app.listen(PORT, () => console.log(`App is running on port ${PORT}`))
    }
    catch(e){
        console.log(e);
    }
}

start()