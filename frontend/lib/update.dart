import 'package:flutter/material.dart';
import 'package:frontend/home.dart';
import 'Control/service.dart';
import 'model/album.dart';

class updatePage extends StatefulWidget {
  Note note;

  updatePage(this.note);
  @override
  _updatePageState createState() => _updatePageState();
}

class _updatePageState extends State<updatePage> {
  Service httpService = new Service();

  @override
  Widget build(BuildContext context) {
    TextEditingController titleControl =
        TextEditingController(text: widget.note.title);
    TextEditingController noteControl =
        TextEditingController(text: widget.note.note);

    return Scaffold(
      backgroundColor: Colors.pink[200],
      floatingActionButton: FloatingActionButton.extended(
        icon: Icon(
          Icons.save,
          color: Colors.white,
        ),
        label: Text(
          'Save',
          style: TextStyle(
            color: Colors.white,
          ),
        ),
        onPressed: () async {
          final String title = titleControl.text;
          final String description = noteControl.text;
          var addnote = await httpService.updateData(widget.note.id,title, description);
          print(addnote);
          Navigator.push(
              context, MaterialPageRoute(builder: (context) => home()));
        },
      ),
      body: ListView(
        padding: EdgeInsets.only(top: 100, left: 20, right: 20),
        children: <Widget>[
          TextField(
            controller: titleControl,
            style: TextStyle(
              fontSize: 25.0,
              fontWeight: FontWeight.bold,
            ),
            decoration: InputDecoration(hintText: "Title"),
            maxLines: 1,
          ),
          SizedBox(height: 30),
          TextField(
            controller: noteControl,
            decoration: InputDecoration(hintText: "Description"),
          ),
        ],
      ),
    );
  }
}
