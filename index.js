const db=require('./connection');


const express=require('express');
const sessions = require('express-session');
const cookieParser = require("cookie-parser");


const app=express();

app.set('view engine', 'ejs');
app.set('views','./views');
app.use(express.urlencoded({ extended: false }));
app.use(sessions({
    secret:'secret-key',
    saveUninitialized:true,
    //session expire in 1 hour
    cookie:{maxAge:60*60*1000},
    resave:false
}));

app.use(cookieParser());


//index page
app.get('/',(req,res)=>{
   res.render('index',{msg:null});
});

//login perform
app.post('/',(req,res)=>{
    //fetch login data from index.ejs
    var username=req.body.username;
    var password=req.body.password;

    //query for login
    let query=`SELECT * FROM userlogin u,role r  WHERE u.username='${req.body.username}' AND u.password='${req.body.password}' AND r.roleId=u.roleId`;
    let execute_query=db.query(query,(err,result)=>{
        if(err) throw err;
        if(result.length==0)
        {
            //return to index page in case of invalid login credentials
            res.render('index',{msg:"Invalid Credentials"});
        }
        else{

         //valid login credentials

        
        var role=result[0].rolename;
        var userId=result[0].userId;


        //set session for user
        session=req.session;
        session.userId=userId;
        session.role=role;

        console.log(req.session);

        //check if user is Recruiter 
        if(role=='Recruiter')
        {
            res.redirect('/recruiter/slots');
            //res.render('recruiter',{userId:result[0].userId,user:result[0].username});
        }
        //check if user is Student
        else if(role=='Student')
        {
            
            let query1=`SELECT * FROM slot_book  WHERE userId=${result[0].userId}`;
            let execute_query1=db.query(query1,(err,result1)=>{
                //appoinment is not book yet
                if(result1.length==0)
                {
                    res.render('student',{msg:null,userId:result[0].userId,user:result[0].username});
    
                }
                //already book appointment
                else
                {

                    //convert to yyyy-mm-dd
                    var year=new Date(result1[0].date).getFullYear();
                    var month=new Date(result1[0].date).getMonth()+1;
                    if(month<10)
                    {
                        month='0'+month;
                    }
                    var date=new Date(result1[0].date).getDate();
                    if(date<10)
                    {
                        date="0"+date;
                    }
                    var fulldate=year+"-"+month+"-"+date;
                    var status=result1[0].status==0?"not accepted":"accepted"
                    //sent them message
                    res.render('student',{msg:`${result[0].username},Your slot is booked ${fulldate} and it is ${status} `,userId:result[0].userId,user:result[0].username});
    
                }
            }); 

        }
      }
    });

});

//logout
app.get('/logout',(req,res)=>{
    req.session.destroy();
    res.redirect('/');
})



//book slot by student side
app.post('/student/bookslot',(req,res)=>{


   
    session=req.session;
    //check if user is student role and session of user is set 
    if(session.role=='Student')
    { 
    //data to store in database
    var slot={userId:req.body.userId,date:req.body.slotdate,status:0};
    //query
    let query="INSERT INTO slot_book SET ?";
    var execute_query=db.query(query,slot,(err,result)=>{
        if(err) throw err;
        res.render('student',{msg:"your slot booking request in process",userId:req.body.userId,user:req.body.user});

     });
    }
    else
    {
       res.render('accessdenied');
    }
});


//show to recrutiers
app.get('/recruiter/slots',(req,res)=>{

    session=req.session;
    //check role base on that getting page access
    if(session.role=='Recruiter')
    { 
    let query=`SELECT * FROM slot_book s,userlogin u WHERE s.userId=u.userId`;
    let execute_query=db.query(query,(err,results)=>{
        if(err) throw err;
        res.render('recruiter',{list:results});
    });
    }
    else{

        res.render('accessdenied');
    }

});

app.get('/recruiter/changestatus',(req,res)=>{
     var userId=req.query.userId;
     var status=req.query.status;
     if(userId!=undefined && status!=undefined)
     { 
     let query=`UPDATE slot_book SET status=${status} WHERE userId=${userId}`;
     let execute_query=db.query(query,(err,result)=>{
       if(err) throw err;
       res.redirect('/recruiter/slots');
     });
    }
});

//listen application on port 3000
app.listen('3000',()=>{
    console.log('Run on port 3000')
});
