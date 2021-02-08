import 'package:flutter/material.dart';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';

// import 'AppHomeScreen.dart';

final _firestore = Firestore.instance;
final _auth = FirebaseAuth.instance;

class ClassCreation extends StatefulWidget {
  @override
  _ClassCreationState createState() => _ClassCreationState();
}

class _ClassCreationState extends State<ClassCreation> {
  TextEditingController classnameController = TextEditingController();
  String className = '';
  TextEditingController subjectnameController = TextEditingController();
  String subjectName = '';
  var currentUserEmail;

  @override
  void initState() {
    super.initState();
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
      appBar: AppBar(
        automaticallyImplyLeading: false,
        title: Center(
          child: Text(
            'Equilibrio',
            style: TextStyle(fontFamily: 'Raleway'),
          ),
        ),
        backgroundColor: Color(0xffff5757),
      ),
      body: SingleChildScrollView(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Text(
              'CREATE CLASSROOM',
              style: TextStyle(fontFamily: 'Roboto', fontSize: 20),
            ),
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: Image(
                image: AssetImage('assets/ClassroomLogo.png'),
              ),
            ),
            Container(
                margin: const EdgeInsets.only(right: 40, left: 40, top: 15),
                decoration: BoxDecoration(
                  // color: Color(0xff1E1E1E),
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
                      offset: Offset(0, 8), // changes position of shadow
                    ),
                  ],
                ),
                child: new TextField(
                  controller: classnameController,
                  decoration: new InputDecoration(
                    enabledBorder: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(20),
                        borderSide: const BorderSide(color: Color(0xffFF5757))),
                    // fillColor: Color(0xff3C3C3C),
                    prefixIcon: const Icon(
                      Icons.edit,
                      // color: Colors.white,
                    ),
                    labelText: 'Class Name',
                    // labelStyle: TextStyle(color: Colors.white),
                  ),
                  onChanged: (classnametext) {
                    setState(() {
                      className = classnametext;
                    });
                  },
                  // style: TextStyle(color: Colors.white),
                )),
            Container(
                margin: const EdgeInsets.only(right: 40, left: 40, top: 30),
                decoration: BoxDecoration(
                  // color: Color(0xff1E1E1E),
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
                      offset: Offset(0, 8), // changes position of shadow
                    ),
                  ],
                ),
                child: new TextField(
                  controller: subjectnameController,
                  decoration: new InputDecoration(
                    enabledBorder: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(20),
                        borderSide: const BorderSide(color: Color(0xffFF5757))),
                    // fillColor: Color(0xff3C3C3C),
                    prefixIcon: const Icon(
                      Icons.book_rounded,
                      // color: Colors.white,
                    ),
                    labelText: 'Subject Name',
                    // labelStyle: TextStyle(color: Colors.white),
                  ),
                  onChanged: (subjectnametext) {
                    setState(() {
                      subjectName = subjectnametext;
                    });
                  },
                  // style: TextStyle(color: Colors.white),
                )),
            Padding(
              padding: const EdgeInsets.only(top: 30),
              child: FloatingActionButton.extended(
                  icon: const Icon(Icons.add_box),
                  backgroundColor: Color(0xffff5757),
                  onPressed: () async {
                    if (classnameController.text != '' &&
                        subjectnameController.text != '') {
                      await _firestore
                          .collection('Teacher')
                          .document(currentUserEmail)
                          .collection('Classes')
                          .document(classnameController.text)
                          .setData({
                        'Classname': classnameController.text,
                        'Subjectname': subjectnameController.text
                      });
                      return showDialog(
                          context: context,
                          builder: (ctx) => AlertDialog(
                                title: Text(
                                  "Class Created",
                                  style: TextStyle(fontWeight: FontWeight.bold),
                                ),
                                content: Text(
                                  'Your class has been created successfully',
                                  textAlign: TextAlign.justify,
                                ),
                                actions: <Widget>[
                                  FlatButton(
                                    onPressed: () {
                                      Navigator.of(ctx).pop();
                                      Navigator.pop(context);
                                      // Navigator.pushAndRemoveUntil(
                                      //     context,
                                      //     MaterialPageRoute(
                                      //         builder: (context) =>
                                      //             ClassTeacher()),
                                      //     (Route<dynamic> route) => false);
                                    },
                                    child: Text("CONTINUE"),
                                  ),
                                ],
                              ));
                    } else {
                      return showDialog(
                          context: context,
                          builder: (ctx) => AlertDialog(
                                title: Text(
                                  "Class Not Created",
                                  style: TextStyle(fontWeight: FontWeight.bold),
                                ),
                                content: Text(
                                  'The given details are invalid. Please check your details and try again',
                                  textAlign: TextAlign.justify,
                                ),
                                actions: <Widget>[
                                  FlatButton(
                                    onPressed: () {
                                      Navigator.of(ctx).pop();
                                      classnameController.clear();
                                      subjectnameController.clear();
                                    },
                                    child: Text("RETRY"),
                                  ),
                                ],
                              ));
                    }
                  },
                  label: Text('Create')),
            ),
          ],
        ),
      ),
    );
  }
}
