const { DataTypes } = require('sequelize')
const db = require('../config/Database')
const Jurusan = require('./JurusanModel')


const Users = db.define('user',{
    name:{
        type: DataTypes.STRING,
        allowNull: false,
        validate: {
            notEmpty: true
        }

    },
    username:{
        type: DataTypes.STRING,
        allowNull: false,
        validate: {
            notEmpty: true
        }
    },
    password:{
        type: DataTypes.STRING,
        allowNull: false,
        validate: {
            notEmpty: true
        }
    },
    role:{
    type: DataTypes.ENUM('superadmin','admin','siswa'),
        allowNull: false,
        validate: {
            notEmpty: true
        }
    
    },
    jurusanId: {
        type: DataTypes.INTEGER,
        allowNull: true,
      }
   
})

Users.belongsTo(Jurusan, { foreignKey: 'jurusanId' });

module.exports = Users