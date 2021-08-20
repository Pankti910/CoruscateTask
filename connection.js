var mysql=require('mysql');


//change username and password 
var connection=mysql.createConnection({
    host:'localhost',
    user:'root',
    password:'',
    database:'placement_db'
});
connection.connect((err)=>{
    if(err)
    {
        console.log("Error while connecting to database :"+err.message);
    }
    else{
        console.log("Connect to database successfully");
    }

});

module.exports=connection;