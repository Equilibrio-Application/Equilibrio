import 'package:flutter/material.dart';
import 'StudentLogin.dart';
import 'TeacherLoginScreen.dart';

class ChooseProfile extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        // backgroundColor: Color(0xff1E1E1E),
        appBar: AppBar(
          automaticallyImplyLeading: false,
          title: Center(
            child: Text(
              'Equilibrio',
              style: TextStyle(fontFamily: 'Roboto'),
            ),
          ),
          // backgroundColor: Colors.black,
        ),
        body: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: Text(
                'CHOOSE PROFILE',
                style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
              ),
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Column(
                  children: [
                    GestureDetector(
                      onTap: () {
                        Navigator.push(
                            context,
                            new MaterialPageRoute(
                                builder: (context) => new LoginAsTeacher()));
                      },
                      child: Image(
                        image: AssetImage('assets/TeacherLogin.png'),
                      ),
                    ),
                    Text(
                      'TEACHER',
                      style: TextStyle(
                          fontSize: 18,
                          // color: Colors.white,
                          fontFamily: 'Roboto',
                          fontWeight: FontWeight.bold),
                      textAlign: TextAlign.center,
                    ),
                  ],
                ),
                Column(
                  children: [
                    GestureDetector(
                      onTap: () {
                        Navigator.push(
                            context,
                            new MaterialPageRoute(
                                builder: (context) => new LoginAsStudent()));
                      },
                      child: Image(
                        image: AssetImage('assets/StudentLogin.png'),
                      ),
                    ),
                    Text(
                      'STUDENT',
                      style: TextStyle(
                          fontSize: 18,
                          // color: Colors.white,
                          fontFamily: 'Roboto',
                          fontWeight: FontWeight.bold),
                      textAlign: TextAlign.center,
                    ),
                  ],
                )
              ],
            )
          ],
        ));
  }
}
