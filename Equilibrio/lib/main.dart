import 'package:flutter/material.dart';

import 'ChooseProfile.dart';

void main() {
  runApp(MaterialApp(
    theme: ThemeData(
      fontFamily: 'Roboto',
      brightness: Brightness.light,
      primaryColor: Color(0xffff5757),
      accentColor: Color(0xffff5757),
    ),

    title: 'Equilibrio',
    initialRoute: '/WelcomeScreen',
    routes: {
      '/WelcomeScreen': (context) => WelcomeToEquilibrio(),
      '/ChooseProfileScreen': (context) => ChooseProfile(),
    },
    //home: WelcomeToEquilibrio(),
  ));
}

class WelcomeToEquilibrio extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: Center(
            child: Text(
              'Equilibrio',
              style: TextStyle(fontFamily: 'Roboto'),
            ),
          ),
        ),
        body: Container(
          width: double.infinity,
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            //crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              Image(
                image: AssetImage(
                  'assets/Equilibrio.png',
                ),
                height: 200,
                width: 200,
              ),
              Padding(
                padding: const EdgeInsets.only(bottom: 35),
                child: Text(
                  'WELCOME TO EQUILIBRIO',
                  style: TextStyle(
                      fontSize: 20,
                      fontFamily: 'Roboto',
                      fontWeight: FontWeight.bold),
                  textAlign: TextAlign.center,
                ),
              ),
              FloatingActionButton.extended(
                  icon: const Icon(Icons.arrow_forward_rounded),
                  onPressed: () {
                    Navigator.push(
                        context,
                        new MaterialPageRoute(
                            builder: (context) => new ChooseProfile()));
                  },
                  label: Text('CONTINUE')),
              Text('\n'),

              /*FloatingActionButton(
                onPressed: () {
                  Navigator.push(
                      context,
                      new MaterialPageRoute(
                          builder: (context) => new ChooseProfile()));
                },
                child: Icon(Icons.arrow_forward_rounded),
                backgroundColor: Color(0xff3C3C3C),
              ),*/
              /*ElevatedButton(
              style: ButtonStyle(
                backgroundColor:
                  MaterialStateProperty.all<Color>(Color(0xff3C3C3C))),
              child: Text('CONTINUE'),
              onPressed: () {
              Navigator.pushNamed(context, '/ProfileScreen');
              },
              ),*/
            ],
          ),
        ));
  }
}
