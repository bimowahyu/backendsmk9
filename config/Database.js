const { Sequelize } = require('sequelize')

const db = new Sequelize('absensimagang','root','',{
    host: "localhost",
    dialect: "mysql",
    timezone: "+07:00"
})

module.exports = db