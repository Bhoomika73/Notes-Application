const express = require('express');

const app = express();

const mongoose = require('mongoose');

const bodyParser = require('body-parser');

require('dotenv/config');

app.use(bodyParser.json());
//Middleware - Function that executes when routes are being hit
const notesRoute = require('./routes/notes')

app.use('/notes', notesRoute);


//ROUTES
app.get('/', (req, res)=> {
    res.send('We are on home');
});


//Connect to database
const uri = process.env.dbconnection;
mongoose.connect(uri,
{ useNewUrlParser: true, useUnifiedTopology: true } ,() => {
    console.log('Connected to DB')
});



app.listen(process.env.PORT || 2000);