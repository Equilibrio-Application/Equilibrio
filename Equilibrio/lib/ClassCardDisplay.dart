import 'package:flutter/material.dart';
import 'ClassCreation.dart';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';

final _firestore = Firestore.instance;
final _auth = FirebaseAuth.instance;
var currentUserEmail = ' ';

class ClassTeacher extends StatefulWidget {
  @override
  _ClassTeacherState createState() => _ClassTeacherState();
}

class _ClassTeacherState extends State<ClassTeacher> {
  void initState() {
    super.initState();
    list = [];
    getUser();
  }

  void getUser() async {
    FirebaseUser user = await _auth.currentUser();
    setState(() {
      currentUserEmail = user.email;
    });

    print(currentUserEmail);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      // backgroundColor: Color(0xff1E1E1E),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          Navigator.push(context,
              new MaterialPageRoute(builder: (context) => new ClassCreation()));
        },
        child: Icon(Icons.add),
        backgroundColor: Color(0xffFF5757),
      ),
      floatingActionButtonLocation: FloatingActionButtonLocation.endDocked,
      body: Column(
        children: [ClassStream()],
      ),
    );
  }
}

List<ClassCard> list = [];

class ClassStream extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return StreamBuilder<QuerySnapshot>(
      stream: _firestore
          .collection('Teacher')
          .document(currentUserEmail)
          .collection('Classes')
          .snapshots(),
      builder: (context, snapshot) {
        if (snapshot.hasData) {
          final classes = snapshot.data.documents;
          for (var a in classes) {
            final classname = a.data['Classname'];
            final subjectname = a.data['Subjectname'];
            print(classname);
            print(subjectname);
            final card = ClassCard(
              className: classname,
              subjectname: subjectname,
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

class ClassCard extends StatelessWidget {
  final String subjectname, className, path;
  ClassCard({this.className, this.subjectname, this.path});

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      child: Padding(
        padding: const EdgeInsets.only(right: 30, left: 30, top: 15.0),
        child: Container(
          height: 80,
          child: Card(
            // color: Color(0xff3C3C3C),
            elevation: 3.0,
            shape: ContinuousRectangleBorder(side: BorderSide.none),
            child: Row(
              children: [
                Padding(
                  padding: const EdgeInsets.only(left: 12.0),
                  child: Icon(
                    Icons.assignment_rounded,
                    size: 30,
                    color: Colors.grey,
                  ),
                ),
                SizedBox(
                  width: 30,
                ),
                Container(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    mainAxisAlignment: MainAxisAlignment.start,
                    children: [
                      Padding(
                        padding: const EdgeInsets.only(top: 8),
                        child: Text(
                          'Class Name : ',
                          style: TextStyle(
                            fontSize: 16.0,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                      ),
                      Padding(
                        padding: const EdgeInsets.only(top: 8),
                        child: Text(
                          'Subject Name : ',
                          style: TextStyle(
                            fontSize: 16.0,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
                SizedBox(
                  width: 30,
                ),
                Container(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    mainAxisAlignment: MainAxisAlignment.start,
                    children: [
                      Padding(
                        padding: const EdgeInsets.only(top: 8),
                        child: Text(
                          className,
                          style: TextStyle(
                            fontSize: 16.0,
                          ),
                        ),
                      ),
                      Padding(
                        padding: const EdgeInsets.only(top: 8),
                        child: Text(
                          subjectname,
                          style: TextStyle(
                            fontSize: 16.0,
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
      onTap: () {
        // Navigator.push(
        //     context,
        //     MaterialPageRoute(
        //         builder: (context) => GenreBooks(
        //               genre: cardName,
        //               path: path,
        //             )));
      },
    );
  }
}
