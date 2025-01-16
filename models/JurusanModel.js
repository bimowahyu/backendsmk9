const { DataTypes } = require('sequelize')
const db = require('../config/Database')

const Jurusan = db.define('jurusan',{
    namaJurusan:{
        type: DataTypes.STRING,
        allowNull: false
    }
    
})

module.exports = Jurusan