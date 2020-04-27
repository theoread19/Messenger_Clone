const bcrypt = require("bcrypt");

class User{
    constructor({
        username,
        password,
        fullName,
        birthday,
        address,
        phoneNumber,
        email,
        isActive
    }){
        this.__username = username;
        this.__password = bcrypt.hashSync(password, 10);
        this.__fullname = fullName;
        this.__birthday = birthday;
        this.__address = address;
        this.__phoneNumber = phoneNumber;
        this.__email = email;
        this.__isActive = false;
    }

    get username(){
        return this.__username;
    }

    get password(){
        return this.__password;
    }

    get fullName(){
        return this.__fullname;
    }

    get birthday(){
        return this.__birthday;
    }

    get address(){
        return this.__address;
    }

    get phoneNumber(){
        return this.__phoneNumber;
    }

    get email(){
        return this.__email;
    }

    get isActive(){
        return this.__isActive;
    }


    send(){
        return[
            this.__username,
            this.__address,
            this.__birthday,
            this.__email,
            this.__fullname,
            this.__isActive,
            this.password,
            this.__phoneNumber,
        ];
    }
}

module.exports = User;