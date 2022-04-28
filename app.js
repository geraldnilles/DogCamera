#!/usr/bin/env node

const express = require('express');
const app = express();


app.set("view engine","pug");
app.set("views","./views");

app.use('/static', express.static('public'))

app.get('/', function (req, res) {
  res.render('index',{message: "there World"});
});

app.use("/motion",require("./routes/motion"));

app.use(express.static('public'))

// app.use("/bigbutts/still",require("./routes/still"));

// TODO Add 404

function startServer(){
    app.listen(8080, function () {
        console.log('DogCamera is running and listening on port 8080');
    });
}

startServer();

