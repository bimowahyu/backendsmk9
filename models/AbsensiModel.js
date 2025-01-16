const {DataTypes} = require('sequelize')
const db = require('../config/Database')
const Users = require('./UserModel')


const Absensi = db.define('absensi',{
    tgl_absensi: {
        type: DataTypes.DATEONLY,
        allowNull: true
    },
    jam_masuk: {
        type: DataTypes.TIME,
        allowNull: true
    },
    jam_keluar: {
        type: DataTypes.TIME,
        allowNull: true
    },
    foto_masuk: {
        type: DataTypes.TEXT,
        allowNull: true
    },
    foto_keluar: {
        type: DataTypes.TEXT,
        allowNull: true
    }
})

Absensi.belongsTo(Users, { foreignKey: 'userId' })
Users.hasMany(Absensi, { foreignKey: 'userId' })

module.exports = Absensi