const con = require('../models/connection.js');
const bcrypt = require('bcrypt');
const fs = require('fs');
const register = fs.readFileSync(`${__dirname}/../views/register-page.html`);
const User = require('../controllers/class/user.js');

exports.getMethod = (req, res) => {
    res.end(register);
}

exports.postMethod = (req, res) =>{
    const User = ({
        username:req.body.inputEmail,
        password:req.body.inputPassword,
        email:req.body.inputEmail,
        fullName:" ",
        birthday:" ",
        address:" ",
        phoneNumber:" ",
        isActive: false
    });

    con.query(
        `insert into users values (?,?,?,?,?,?,?,?)`,
        User.send(),
        (error, results, fields)=>{
            if(error){
                //phan error dua len trang web
                //chua co template
                console.log('loi');
            }
            else {
                res.redirect("/login");
            }
        }
    );
};
