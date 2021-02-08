import 'package:flutter/material.dart';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:fluttertoast/fluttertoast.dart';

final _firestore = Firestore.instance;
final _auth = FirebaseAuth.instance;
var currentUserEmail = ' ';

class TodoStudent extends StatefulWidget {
  @override
  _TodoStudentState createState() => _TodoStudentState();
}

class _TodoStudentState extends State<TodoStudent> {
  TextEditingController todoController = TextEditingController();
  String toDo = '';
  @override
  void initState() {
    super.initState();
    list = [];
    getUser();
  }

  void getUser() async {
    FirebaseUser user = await _auth.currentUser();
    currentUserEmail = user.email;
    print(currentUserEmail);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        // backgroundColor: Color(0xff1E1E1E),
        floatingActionButton: FloatingActionButton(
          onPressed: () {
            return showDialog(
                context: context,
                builder: (ctx) => AlertDialog(
                      // backgroundColor: Color(0xff3C3C3C),
                      content: Container(
                        height: 180,
                        child: Column(
                          children: [
                            Padding(
                              padding: const EdgeInsets.all(8.0),
                              child: Text(
                                'Plan Your Day',
                                textAlign: TextAlign.justify,
                                style: TextStyle(
                                  fontFamily: 'Roboto',
                                  fontWeight: FontWeight.bold,
                                  fontSize: 18,
                                ),
                              ),
                            ),
                            Padding(
                              padding: const EdgeInsets.all(8.0),
                              child: Container(
                                decoration: BoxDecoration(
                                  // color: Color(0xff3C3C3C),
                                  borderRadius: BorderRadius.only(
                                    topLeft: Radius.circular(20),
                                    topRight: Radius.circular(20),
                                    bottomLeft: Radius.circular(20),
                                    bottomRight: Radius.circular(20),
                                  ),
                                  boxShadow: [
                                    BoxShadow(
                                      color: Colors.white.withOpacity(1),
                                      spreadRadius: 1,
                                      blurRadius: 6,
                                      offset: Offset(
                                          0, 8), // changes position of shadow
                                    ),
                                  ],
                                ),
                                child: new TextField(
                                  controller: todoController,
                                  decoration: new InputDecoration(
                                    enabledBorder: OutlineInputBorder(
                                        borderRadius: BorderRadius.circular(20),
                                        borderSide: const BorderSide(
                                            color: Color(0xffFF5757))),
                                    // fillColor: Color(0xff3C3C3C),
                                    prefixIcon: const Icon(
                                      Icons.schedule,
                                      // color: Colors.white,
                                    ),
                                    labelText: 'Schedule Item',
                                    // labelStyle: TextStyle(color: Colors.white),
                                  ),
                                  onChanged: (todotext) {
                                    setState(() {
                                      toDo = todotext;
                                    });
                                  },
                                  // style: TextStyle(color: Colors.white),
                                ),
                              ),
                            ),
                            Padding(
                              padding: const EdgeInsets.only(top: 8),
                              child: FlatButton(
                                  color: Color(0xffFF5757),
                                  shape: RoundedRectangleBorder(
                                      borderRadius:
                                          new BorderRadius.circular(30.0)),
                                  onPressed: () async {
                                    if (todoController.text != '') {
                                      await _firestore
                                          .collection('Student')
                                          .document(currentUserEmail)
                                          .collection('ToDoStudent')
                                          .document(todoController.text)
                                          .setData({
                                        'ToDo': todoController.text,
                                      });
                                      print(todoController);
                                      Fluttertoast.showToast(
                                          msg: "Item Added",
                                          toastLength: Toast.LENGTH_SHORT,
                                          gravity: ToastGravity.BOTTOM,
                                          timeInSecForIosWeb: 1,
                                          backgroundColor: Color(0xffFF5757),
                                          // textColor: Colors.white,
                                          fontSize: 16.0);
                                      todoController.clear();
                                    } else {
                                      Fluttertoast.showToast(
                                          msg: "Invalid Input",
                                          toastLength: Toast.LENGTH_SHORT,
                                          gravity: ToastGravity.BOTTOM,
                                          timeInSecForIosWeb: 1,
                                          backgroundColor: Color(0xffFF5757),
                                          // textColor: Colors.white,
                                          fontSize: 16.0);
                                    }
                                  },
                                  child: Text(
                                    'ADD',
                                    // style: TextStyle(color: Colors.white),
                                  )),
                            )
                          ],
                        ),
                      ),
                    ));
          },
          child: Icon(Icons.add),
          backgroundColor: Color(0xffFF5757),
        ),
        floatingActionButtonLocation: FloatingActionButtonLocation.endDocked,
        body: Column(
          children: [ToDoStream()],
        ));
  }
}

List<ToDoCard> list = [];

class ToDoStream extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return StreamBuilder<QuerySnapshot>(
      stream: _firestore
          .collection('Student')
          .document(currentUserEmail)
          .collection('ToDoStudent')
          .snapshots(),
      builder: (context, snapshot) {
        if (snapshot.hasData) {
          final todos = snapshot.data.documents;
          for (var a in todos) {
            final todoitem = a.data['ToDo'];
            print(todoitem);
            final card = ToDoCard(
              itemName: todoitem,
            );
            list.add(card);
          }
          return Expanded(
            child: ListView(
              children: list,
            ),
          );
        } else {
          return Center(
            child: CircularProgressIndicator(
              backgroundColor: Color(0xFFff5757),
            ),
          );
        }
      },
    );
  }
}

class ToDoCard extends StatefulWidget {
  final String itemName, path;
  ToDoCard({this.itemName, this.path});

  @override
  _ToDoCardState createState() => _ToDoCardState();
}

class _ToDoCardState extends State<ToDoCard> {
  Color iconcolor = Colors.grey;
  bool isVisible = true;

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      child: Padding(
        padding: const EdgeInsets.only(right: 30, left: 30, top: 15.0),
        child: Visibility(
          visible: isVisible,
          child: Container(
            height: 60,
            child: Card(
              // color: Color(0xff3C3C3C),
              elevation: 3.0,
              shape: ContinuousRectangleBorder(side: BorderSide.none),
              child: ListTile(
                trailing: Padding(
                  padding: const EdgeInsets.only(left: 12.0),
                  child: GestureDetector(
                    child: Icon(
                      Icons.assignment_turned_in_outlined,
                      color: iconcolor,
                    ),
                    onTap: () {
                      setState(() {
                        if (iconcolor == Colors.grey) {
                          iconcolor = Colors.green;
                          Fluttertoast.showToast(
                              msg: "Task Completed",
                              toastLength: Toast.LENGTH_SHORT,
                              gravity: ToastGravity.BOTTOM,
                              timeInSecForIosWeb: 1,
                              backgroundColor: Color(0xffFF5757),
                              // textColor: Colors.white,
                              fontSize: 16.0);
                        } else
                          iconcolor = Colors.grey;
                      });
                    },
                  ),
                ),
                title: Container(
                  child: Text(
                    widget.itemName,
                    style: TextStyle(
                      fontSize: 16.0,
                    ),
                  ),
                ),
              ),
            ),
          ),
        ),
      ),
      onDoubleTap: () {
        print(widget.itemName);

        DocumentReference documentReference = _firestore
            .collection('Student')
            .document(currentUserEmail)
            .collection('ToDoStudent')
            .document(widget.itemName);
        documentReference.delete().whenComplete(() {
          Fluttertoast.showToast(
              msg: "Task Completed",
              toastLength: Toast.LENGTH_SHORT,
              gravity: ToastGravity.BOTTOM,
              timeInSecForIosWeb: 1,
              backgroundColor: Color(0xffFF5757),
              // textColor: Colors.white,
              fontSize: 16.0);
        });
        setState(() {
          isVisible = false;
        });
      },
    );
  }
}
