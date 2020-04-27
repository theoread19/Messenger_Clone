const con = require("./models/connection.js");

exports.sessionCheck = (req, res) =>{
    con.query(
        `select * form sessions where sessionid = ?`,
        [req.sessionID],
        (error, results, fields) => {
            try {
                let data = JSON.parse(results[0].data);
                if (data.username !== req.session.username)
                    return false;
            } catch (e) {
                if (null === results){
                    return false;
                }
            }
        }
    );
    return true;
};