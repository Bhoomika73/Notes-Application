import 'package:flutter/material.dart';
import 'package:frontend/Control/service.dart';
import 'package:frontend/update.dart';
import 'page.dart';

class home extends StatefulWidget {
  @override
  _homeState createState() => _homeState();
}

class _homeState extends State<home> {
  Service httpService = new Service();

  @override
  Widget build(BuildContext context) {
    return Container(
      child: Scaffold(
        backgroundColor: Colors.pink[200],
        floatingActionButton: FloatingActionButton.extended(
            icon: Icon(Icons.add),
            onPressed: () {
              Navigator.push(
                context,
                MaterialPageRoute(builder: (context) => page(null)),
              );
            },
            label: Text('New')),
        body: Container(
          child: SafeArea(
            child: Column(
              children: <Widget>[
                Padding(
                  padding: const EdgeInsets.only(top: 30),
                  child: Text(
                    'Notes Application',
                    style: TextStyle(
                      fontSize: 30,
                      fontWeight: FontWeight.bold,
                      letterSpacing: 3,
                      color: Colors.red[900],
                      fontFamily: 'Xanh',
                    ),
                  ),
                ),
                Note(context),
              ],
            ),
          ),
        ),
      ),
    );
  }

  Widget Note(context) {
    return FutureBuilder(
      future: httpService.loadData(),
      builder: (context, snapshot) {
        if (snapshot.hasData) {
          return Flexible(
            child: Container(
              child: ListView.builder(
                shrinkWrap: true,
                itemCount: snapshot.data.length,
                itemBuilder: (BuildContext context, int index) {
                  return Padding(
                    padding:
                        const EdgeInsets.only(left: 40, right: 40, top: 35),
                    child: Container(
                      child: Card(
                        shape: RoundedRectangleBorder(
                          side: BorderSide(
                            color: Colors.black,
                            width: 2,
                          ),
                          borderRadius: BorderRadius.circular(20.0),
                        ),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.center,
                          children: <Widget>[
                            Padding(
                              padding: const EdgeInsets.all(16.0),
                              child: Text(
                                snapshot.data[index].title,
                                style: TextStyle(
                                  fontSize: 20.0,
                                  fontWeight: FontWeight.bold,
                                ),
                              ),
                            ),
                            Padding(
                              padding:
                                  const EdgeInsets.only(left: 30, right: 30),
                              child: Align(
                                alignment: Alignment.center,
                                child: Text(
                                  snapshot.data[index].note,
                                  style: TextStyle(
                                    fontSize: 15.0,
                                  ),
                                ),
                              ),
                            ),
                            Padding(
                              padding: const EdgeInsets.all(8.0),
                              child: Row(
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceAround,
                                children: <Widget>[
                                  RaisedButton(
                                    onPressed: () async {
                                      Navigator.push(
                                        context,
                                        MaterialPageRoute(
                                          builder: (context) => 
                                              updatePage(snapshot.data[index]),
                                        ),
                                      );
                                    },
                                    child: Text('Edit'),
                                    textColor: Colors.black,
                                    color: Color(0xfff2af29),
                                  ),
                                  SizedBox(
                                    width: 20.0,
                                  ),
                                  IconButton(
                                    icon: Icon(Icons.delete),
                                    onPressed: () async {
                                      await httpService
                                          .deletePost(snapshot.data[index].id);
                                      setState(() {});
                                    },
                                  ),
                                ],
                              ),
                            )
                          ],
                        ),
                      ),
                    ),
                  );
                },
              ),
            ),
          );
        } else {
          return CircularProgressIndicator();
        }
      },
    );
  }
}
