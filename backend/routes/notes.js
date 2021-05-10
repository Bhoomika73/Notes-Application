const express = require('express');

const bodyParser = require('body-parser');

const Note = require('../model/Note');

const router = express.Router();

router.use(bodyParser.json());

router.get('/', async (req, res)=> {
    try{
        const notes = await Note.find();
        res.status(200).json(notes);
        }
        catch(err) {
            res.json({message: err});
    
        }
});

router.post('/', async (req, res) => {

    const notes = new Note({
        title: req.body.title,
        note: req.body.note 
    });
    try{
    const savedNote = await notes.save();
    res.status(200).json(savedNote);
    }
    catch(err) {
        res.json({message: err});

    }
    
    
}) ;

router.delete('/:postId', async (req,res)=> {
    try{
        const removedNote = await Note.remove({_id: req.params.postId});
        res.json(removedNote);
    }
    catch (err){
        res.json({message:err});
    }
});

router.patch('/:postId', async (req,res)=>{
    try{
        const updatedNote = await Note.updateOne({_id: req.params.postId},
            {$set: {title: req.body.title,
                note: req.body.note}}, {multi: true });
        res.json(updatedNote);
    }
    catch (err){
        res.json({message:err});
    }
});


module.exports = router;
