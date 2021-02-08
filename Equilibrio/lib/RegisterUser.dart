/*import 'package:flutter/material.dart';

class ResisterUser extends StatefulWidget {
  @override
  _MyStateRegisterUser createState() => _MyStateRegisterUser();
}

class _MyStateRegisterUser extends State<ResisterUser> {
  TextEditingController nameController = TextEditingController();
  String UserName = '';
  TextEditingController nameController2 = TextEditingController();
  String  = '';
  TextEditingController nameController3 = TextEditingController();
  String Password = '';
  

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: Scaffold(
          backgroundColor: Color(0xff1E1E1E),
          appBar: AppBar(
            title: Text(
              'Equilibrio',
              style: TextStyle(fontFamily: 'Raleway'),
            ),
            backgroundColor: Colors.black,
          ),
          body: SingleChildScrollView(
            child: Column(
              children: [
                Text('\n\n\n\n'),
                Image(
                  image: AssetImage('assets/TeacherLogin.png'),
                ),
                Center(
                    child: Column(children: <Widget>[
                  Container(
                      margin:
                          const EdgeInsets.only(right: 40, left: 40, top: 10),
                      decoration: BoxDecoration(
                        color: Color(0xff1E1E1E),
                        borderRadius: BorderRadius.only(
                          topLeft: Radius.circular(20),
                          topRight: Radius.circular(20),
                          bottomLeft: Radius.circular(20),
                          bottomRight: Radius.circular(20),
                        ),
                        boxShadow: [
                          BoxShadow(
                            color: Colors.black.withOpacity(1),
                            spreadRadius: 1,
                            blurRadius: 6,
                            offset: Offset(0, 8), // changes position of shadow
                          ),
                        ],
                      ),
                      child: new TextField(
                        controller: nameController,
                        decoration: new InputDecoration(
                          enabledBorder: OutlineInputBorder(
                              borderRadius: BorderRadius.circular(20),
                              borderSide:
                                  const BorderSide(color: Color(0xffFF5757))),
                          fillColor: Color(0xff3C3C3C),
                          prefixIcon: const Icon(
                            Icons.person,
                            color: Colors.white,
                          ),
                          labelText: 'Username',
                          labelStyle: TextStyle(color: Colors.white),
                        ),
                        onChanged: (usernametext) {
                          setState(() {
                            UserName = usernametext;
                          });
                        },
                        style: TextStyle(color: Colors.white),
                      )),
                  Container(
                      margin:
                          const EdgeInsets.only(right: 40, left: 40, top: 30),
                      decoration: BoxDecoration(
                        color: Color(0xff1E1E1E),
                        borderRadius: BorderRadius.only(
                          topLeft: Radius.circular(20),
                          topRight: Radius.circular(20),
                          bottomLeft: Radius.circular(20),
                          bottomRight: Radius.circular(20),
                        ),
                        boxShadow: [
                          BoxShadow(
                            color: Colors.black.withOpacity(1),
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
                          fillColor: Color(0xff3C3C3C),
                          prefixIcon: const Icon(
                            Icons.lock,
                            color: Colors.white,
                          ),
                          labelText: 'Password',
                          labelStyle: TextStyle(color: Colors.white),
                        ),
                        onChanged: (passwordtext) {
                          setState(() {
                            UserName = passwordtext;
                          });
                        },
                        style: TextStyle(color: Colors.white),
                      ))
                ])),
                Text('\n\n'),
                Container(
                    child: FloatingActionButton.extended(
                        icon: const Icon(Icons.login_rounded),
                        backgroundColor: Color(0xff3C3C3C),
                        onPressed: () {
                          Navigator.pushNamed(context, '/WelcomeScreen');
                        },
                        label: Text('Login')))
              ],
            ),
          )),
    );
  }
}*/
