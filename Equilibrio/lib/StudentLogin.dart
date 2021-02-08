import 'package:flutter/material.dart';

import 'AppHomeScreenStudent.dart';

import 'package:firebase_auth/firebase_auth.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

final _auth = FirebaseAuth.instance;

class LoginAsStudent extends StatefulWidget {
  @override
  _MyStateStudent createState() => _MyStateStudent();
}

class _MyStateStudent extends State<LoginAsStudent> {
  TextEditingController nameController = TextEditingController();
  String userName = '';
  TextEditingController nameController2 = TextEditingController();
  String password = '';

  bool emailValidate = true;
  void validateEmail(String email) {
    final emailRegex =
        RegExp(r'^[a-z0-9]+[\._]?[a-z0-9]+[@]\w+([\.-]?\w+)*(\.\w{2,3})+$');
    if (email.isNotEmpty) {
      if (emailRegex.hasMatch(email))
        setState(() {
          emailValidate = true;
        });
      else
        setState(() {
          emailValidate = false;
        });
    } else
      setState(() {
        emailValidate = false;
      });
  }

  static Future<bool> checkExist(String docID) async {
    bool exists = false;
    try {
      await Firestore.instance.document("Student/$docID").get().then((doc) {
        if (doc.exists)
          exists = true;
        else
          exists = false;
      });
      return exists;
    } catch (e) {
      return false;
    }
  }

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: Scaffold(
          // backgroundColor: Color(0xff1E1E1E),
          appBar: AppBar(
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
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                Padding(
                  padding: const EdgeInsets.only(top: 50),
                  child: Image(
                    image: AssetImage('assets/StudentLogin.png'),
                  ),
                ),
                Center(
                    child: Column(children: <Widget>[
                  Container(
                      margin:
                          const EdgeInsets.only(right: 40, left: 40, top: 10),
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
                        controller: nameController,
                        decoration: new InputDecoration(
                          errorText:
                              emailValidate ? null : 'Incorrect Email ID',
                          enabledBorder: OutlineInputBorder(
                              borderRadius: BorderRadius.circular(20),
                              borderSide:
                                  const BorderSide(color: Color(0xffFF5757))),
                          // fillColor: Color(0xff3C3C3C),
                          prefixIcon: const Icon(
                            Icons.person,
                            // color: Colors.white,
                          ),
                          labelText: 'Username',
                          // labelStyle: TextStyle(color: Colors.white),
                        ),
                        onChanged: (usernametext) {
                          setState(() {
                            userName = usernametext;
                          });
                        },
                        // style: TextStyle(color: Colors.white),
                      )),
                  Container(
                      margin:
                          const EdgeInsets.only(right: 40, left: 40, top: 30),
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
                        controller: nameController2,
                        obscureText: true,
                        decoration: new InputDecoration(
                          enabledBorder: OutlineInputBorder(
                              borderRadius: BorderRadius.circular(20),
                              borderSide:
                                  const BorderSide(color: Color(0xffFF5757))),
                          // fillColor: Color(0xff3C3C3C),
                          prefixIcon: const Icon(
                            Icons.lock,
                            // color: Colors.white,
                          ),
                          labelText: 'Password',
                          // labelStyle: TextStyle(color: Colors.white),
                        ),
                        onChanged: (passwordtext) {
                          setState(() {
                            userName = passwordtext;
                          });
                        },
                        // style: TextStyle(color: Colors.white),
                      ))
                ])),
                Text('\n\n'),
                Container(
                    child: FloatingActionButton.extended(
                        icon: const Icon(Icons.login_rounded),
                        backgroundColor: Color(0xffff5757),
                        onPressed: () async {
                          validateEmail(nameController.text);
                          bool check = await checkExist(nameController.text);
                          if (emailValidate == true && check == true) {
                            try {
                              final user =
                                  await _auth.signInWithEmailAndPassword(
                                      email: nameController.text,
                                      password: nameController2.text);
                              if (user != null) {
                                Navigator.push(
                                    context,
                                    MaterialPageRoute(
                                        builder: (context) =>
                                            HomePageStudent()));
                              } else
                                print('Null user');
                            } catch (e) {
                              print(e);
                              return showDialog(
                                  context: context,
                                  builder: (ctx) => AlertDialog(
                                        title: Text(
                                          "Login Error",
                                          style: TextStyle(
                                              fontWeight: FontWeight.bold),
                                        ),
                                        content: Text(
                                          'The email you entered doesn’t appear to belong to an account. Please check your email and try again',
                                          textAlign: TextAlign.justify,
                                        ),
                                        actions: <Widget>[
                                          FlatButton(
                                            onPressed: () {
                                              Navigator.of(ctx).pop();
                                              Navigator.pushAndRemoveUntil(
                                                  context,
                                                  MaterialPageRoute(
                                                      builder: (context) =>
                                                          LoginAsStudent()),
                                                  (Route<dynamic> route) =>
                                                      false);
                                            },
                                            child: Text("RETRY"),
                                          ),
                                        ],
                                      ));
                            }
                          } else {
                            return showDialog(
                                context: context,
                                builder: (ctx) => AlertDialog(
                                      title: Text(
                                        "Login Error",
                                        style: TextStyle(
                                            fontWeight: FontWeight.bold),
                                      ),
                                      content: Text(
                                        'The email you entered doesn’t appear to belong to an account. Please check your email and try again',
                                        textAlign: TextAlign.justify,
                                      ),
                                      actions: <Widget>[
                                        FlatButton(
                                          onPressed: () {
                                            Navigator.of(ctx).pop();
                                            Navigator.pushAndRemoveUntil(
                                                context,
                                                MaterialPageRoute(
                                                    builder: (context) =>
                                                        LoginAsStudent()),
                                                (Route<dynamic> route) =>
                                                    false);
                                          },
                                          child: Text("RETRY"),
                                        ),
                                      ],
                                    ));
                          }
                        },
                        label: Text('Login')))
              ],
            ),
          )),
    );
  }
}
