#!/usr/bin/env node

const express = require('express');
const app = express();
const fs = require("fs");

const socketPath = "/tmp/scam2.socket";

app.set("view engine","pug");
app.set("views","./views");

app.use('/static', express.static('public'))

app.get('/', function (req, res) {
  res.render('index',{message: "there World"});
});

app.use("/motion",require("./routes/motion"));

app.use("/dvr",require("./routes/dvr"));

app.use(express.static('public'))

// app.use("/bigbutts/still",require("./routes/still"));

// TODO Add 404

function chmodSocket() {
    fs.chmod(socketPath,"777",function(err){
    });
}

function startServer(){
    app.listen(socketPath, function () {
        console.log('DogCamera is running and listening on port 8080');
        chmodSocket();
    });
}

fs.access(socketPath,fs.constants.F_OK,function(err){
    if(!err){
        fs.unlink(socketPath,function(err){
            startServer();
        });
    }else {
        startServer();
    }
});

