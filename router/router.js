const express = require('express');
const router = express.Router();
const fs = require('fs');

const dashboard = fs.readFileSync('./views/dashboard.html');
const login = fs.readFileSync('./views/login-page.html');
const recoveracc = fs.readFileSync('./views/recover-acc.html');
 const register = fs.readFileSync('./views/register-page.html');

const registerRouter = require('./routerRegister');

router.get('/', (req, res)=>{
    res.end(login);
});

router.get('/recover-acc', (req, res)=>{
    res.end(recoveracc);
});

router
    .route("/register")
    .get((req, res) => registerRouter.getMethod(req, res))
    .post((req, res) => registerRouter.postMethod(req, res));

    
router.get('/dashboard', (req, res)=>{
    res.end(dashboard);
});


router.route("/notfound").get((req, res) => {
    res.end(notfound);
  });

module.exports = router;