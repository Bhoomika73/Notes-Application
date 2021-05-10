import 'package:flutter/material.dart';
import 'package:frontend/home.dart';
import 'Control/service.dart';
import 'model/album.dart';

class page extends StatefulWidget {
  Note note;

  page(this.note);
  @override
  _pageState createState() => _pageState();
}

class _pageState extends State<page> {
  TextEditingController titleControl = TextEditingController();
  TextEditingController noteControl = TextEditingController();
  Service httpService = new Service();

  @override
  Widget build(BuildContext context) {
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
          var addnote = await httpService.postData(title, description);
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
