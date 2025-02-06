const {DataTypes} = require('sequelize')
const db = require('../config/Database')
const Users = require('./UserModel')

const Laporan = db.define('laporan',{
    tgl_pembuatan:{
        type: DataTypes.DATEONLY,
        allowNull: false
    },
    foto_laporan:{
        type: DataTypes.STRING,
        allowNull: true
    },
    keterangan:{
        type: DataTypes.STRING,
        allowNull: false
    }

})
Laporan.belongsTo(Users, {foreignKey:'userId'})
module.exports = Laporan