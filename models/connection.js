const mysql = require('mysql');

const con = mysql.createConnection({
    host: process.env.MYSQL_URL,
    user: process.env.MYSQL_USERNAME,
    password: process.env.MYSQL_PASSWORD,
    database: process.env.MYSQL_DATABASE
});

//này nè
// à
//==
module.exports = con;
// để mỏw mấy cái kia luôn