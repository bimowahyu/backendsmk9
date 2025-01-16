const express = require('express')
const cors = require("cors");
const path = require("path");
const db = require('./config/Database')
const moment = require('moment-timezone');
const fileUpload = require("express-fileupload");
const bodyParser = require('body-parser');
const SequelizeStore = require("connect-session-sequelize");
const session = require("express-session");
const AbsenRoute = require('./routes/AbsenRoutes')
const JurusanRoute = require('./routes/JurusanRoutes')
const LaporanRoutes = require('./routes/LaporanRoutes')
const UserRoutes = require('./routes/UserRoutes')
const AuthRoute = require('./routes/AuthRoutes')
const fs = require('fs').promises;


const app = express()
const SequelizeStoreSession = SequelizeStore(session.Store);
const SESS_SECRET = "qwertysaqdunasndjwnqnkndklawkdwk";
const TIMEZONE = "Asia/Jakarta";

const store = new SequelizeStoreSession({
    db: db
});
// (async() => {
//    await db.sync();
// })();
app.use(cors({
    origin: true,//'http://localhost:3000',
    methods: ['GET', 'POST', 'PUT', 'DELETE'],
    allowedHeaders: ['Content-Type', 'Authorization'],
    credentials: true
}));

app.use(session({
    secret: SESS_SECRET,
    resave: false,
    saveUninitialized: true,
    store: store,
    cookie: {
        secure: 'auto'
    }
}));
app.use(fileUpload({
    createParentPath: true,
    limits: { fileSize: 5 * 1024 * 1024 }, //  5 MB
}));
app.use((req, res, next) => {
    req.session._garbage = Date();
    req.session.touch();
    next();
});

app.use((req, res, next) => {
    res.setHeader('Date', moment().tz(TIMEZONE).format('ddd, DD MMM YYYY HH:mm:ss [GMT+0700]'));
    next();
});

app.use(bodyParser.json({ limit: '50mb' }));
app.use(bodyParser.urlencoded({ limit: '50mb', extended: true }));
app.use(express.json({ limit: '10mb' }));
app.use(express.urlencoded({ extended: true, limit: '10mb' }));
app.use('/uploads', express.static('public/uploads'));


//---------------------ROUTERMIDDLEWARE-----------------------
app.use(AbsenRoute)
app.use(JurusanRoute)
app.use(LaporanRoutes)
app.use(UserRoutes)
app.use(AuthRoute)

app.get('/', (req, res) => {
    res.send('berhasil');
});

// store.sync();

const PORT = 2000



app.listen(PORT, ()=>{
    console.log(`Server is running on port ${PORT}`)
})