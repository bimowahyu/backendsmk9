const { Sequelize } = require('sequelize')

const db = new Sequelize('absensimagang','root','',{
    host: "localhost",
    dialect: "mysql",
    timezone: "+07:00"
})

module.exports = db

// Hostname:
// localhost
// Database:
// brabsenm_absensimagang
// Username:
// brabsenm_absensimagang
// Password:
// bdDqWuBnkjPv7JNdVmBs