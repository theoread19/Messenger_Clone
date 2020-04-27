const express = require('express');
const app = express();
const con = require("./models/connection.js");
const servers = require('./server.js');
const pagerouter = require('./router/router.js');
const session = require('express-session');
const cookieparser = require("cookie-parser");
const mySqlStore = require('express-mysql-session')(session);
const mysql = require('mysql');

const option = {
    host: process.env.MYSQL_URL, 
    user: process.env.MYSQL_USERNAME,
    password: process.env.MYSQL_PASSWORD,
    database: process.env.MYSQL_DATABASE,


    clearExpired: true,
    checkExpirationInterval: 900000,
    expiration: 1000*60*30,
    createDatabaseTable: true,
    connectionLimit: 1,
    endConnectionOnClose: true,
    charset: "utf8mb4_bin",

    schema: {
        tableName: "sessions",
        columnNames: {
            session_id: "session_id",
            expires:"expires",
            data: "data"
        }
    }
};

const sessionStore = new mySqlStore(option, con);

app.use(express.urlencoded({ extended: true}));
app.use(
    session({
        secret: "FMS",
        resave: false,
        store: sessionStore,
        saveUninitialized: false,
        cookie: {
            maxAge: 1000*60*60*24,
            secure: false
        }
    })
);

app.use(express.static(`${__dirname}/views`));
app.use('/', pagerouter);

module.exports = app;