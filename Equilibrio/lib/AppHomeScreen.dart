import 'package:flutter/material.dart';

import 'ClassCardDisplay.dart';
import 'ChatTeacher.dart';
import 'StatusTeacher.dart';
import 'TodoTeacher.dart';
// import 'package:cloud_firestore/cloud_firestore.dart';
// import 'package:firebase_auth/firebase_auth.dart';

// import 'ClassCreation.dart';

// final _firestore = Firestore.instance;
// final _auth = FirebaseAuth.instance;
// var currentUserEmail = ' ';

class HomePage extends StatefulWidget {
  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> with TickerProviderStateMixin {
  TabController tabController;
  @override
  void initState() {
    super.initState();
    tabController = new TabController(length: 4, vsync: this);
  }

  @override
  Widget build(BuildContext context) {
    double screenHeight = MediaQuery.of(context).size.height;
    return MaterialApp(
      home: Scaffold(
          // backgroundColor: Color(0xff1E1E1E),
          appBar: AppBar(
            title: Center(
              child: Text(
                'Equilibrio',
                // style: TextStyle(fontFamily: 'Raleway'),
              ),
            ),
            backgroundColor: Color(0xffff5757),
          ),
          body: SingleChildScrollView(
            child: Column(
              children: [
                Container(
                  width: double.infinity,
                  child: Material(
                    // color: Color(0xff3C3C3C),
                    child: Center(
                      child: TabBar(
                        controller: tabController,
                        indicatorColor: Color(0xffff5757),
                        labelColor: Color(0xffff5757),
                        unselectedLabelColor: Colors.grey,
                        isScrollable: true,
                        tabs: [
                          Tab(
                            child: Padding(
                              padding:
                                  const EdgeInsets.only(left: 10, right: 10),
                              child: Row(
                                children: [Text('CHATS')],
                              ),
                            ),
                          ),
                          Tab(
                            child: Padding(
                              padding:
                                  const EdgeInsets.only(left: 10, right: 10),
                              child: Row(
                                children: [Text('CLASS')],
                              ),
                            ),
                          ),
                          Tab(
                            child: Padding(
                              padding:
                                  const EdgeInsets.only(left: 10, right: 10),
                              child: Row(
                                children: [Text('TODO')],
                              ),
                            ),
                          ),
                          Tab(
                            child: Padding(
                              padding:
                                  const EdgeInsets.only(left: 10, right: 10),
                              child: Row(
                                children: [Text('STATUS')],
                              ),
                            ),
                          )
                        ],
                      ),
                    ),
                  ),
                ),
                Container(
                  height: screenHeight * 0.78,
                  child: TabBarView(
                    controller: tabController,
                    children: [
                      ChatTeacher(),
                      ClassTeacher(),
                      TodoTeacher(),
                      StatusTeacher()
                    ],
                  ),
                )
              ],
            ),
          )),
    );
  }
}

// class ClassTeacher extends StatefulWidget {
//   @override
//   _ClassTeacherState createState() => _ClassTeacherState();
// }

// class _ClassTeacherState extends State<ClassTeacher> {
//   void initState() {
//     super.initState();
//     list = [];
//     getUser();
//   }

//   void getUser() async {
//     FirebaseUser user = await _auth.currentUser();
//     setState(() {
//       currentUserEmail = user.email;
//     });

//     print(currentUserEmail);
//   }

//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       backgroundColor: Color(0xff1E1E1E),
//       floatingActionButton: FloatingActionButton(
//         onPressed: () {
//           Navigator.push(context,
//               new MaterialPageRoute(builder: (context) => new ClassCreation()));
//         },
//         child: Icon(Icons.add),
//         backgroundColor: Color(0xff3C3C3C),
//       ),
//       floatingActionButtonLocation: FloatingActionButtonLocation.endDocked,
//       body: Column(
//         children: [ClassStream()],
//       ),
//     );
//   }
// }

// List<ClassCard> list = [];

// class ClassStream extends StatelessWidget {
//   @override
//   Widget build(BuildContext context) {
//     return StreamBuilder<QuerySnapshot>(
//       stream: _firestore
//           .collection('Teacher')
//           .document(currentUserEmail)
//           .collection('Classes')
//           .snapshots(),
//       builder: (context, snapshot) {
//         if (snapshot.hasData) {
//           final classes = snapshot.data.documents;
//           for (var a in classes) {
//             final classname = a.data['Classname'];
//             final subjectname = a.data['Subjectname'];
//             print(classname);
//             print(subjectname);
//             final card = ClassCard(
//               className: classname,
//               subjectname: subjectname,
//             );
//             list.add(card);
//           }
//           return Expanded(
//             child: ListView(
//               children: list,
//             ),
//           );
//         } else {
//           return Center(
//             child: CircularProgressIndicator(
//               backgroundColor: Color(0xFF02340F),
//             ),
//           );
//         }
//       },
//     );
//   }
// }

// class ClassCard extends StatelessWidget {
//   final String subjectname, className, path;
//   ClassCard({this.className, this.subjectname, this.path});

//   @override
//   Widget build(BuildContext context) {
//     return GestureDetector(
//       child: Padding(
//         padding: const EdgeInsets.only(right: 20, left: 20, top: 15.0),
//         child: Container(
//           height: 80,
//           child: Card(
//             color: Color(0xff3C3C3C),
//             elevation: 3.0,
//             shape: ContinuousRectangleBorder(side: BorderSide.none),
//             child: Row(
//               children: [
//                 Padding(
//                   padding: const EdgeInsets.only(left: 12.0),
//                   child: Icon(
//                     Icons.class_,
//                     size: 40,
//                     color: Colors.white,
//                   ),
//                 ),
//                 SizedBox(
//                   width: 50,
//                 ),
//                 Column(
//                   crossAxisAlignment: CrossAxisAlignment.center,
//                   mainAxisAlignment: MainAxisAlignment.start,
//                   children: [
//                     Padding(
//                       padding: const EdgeInsets.only(top: 8),
//                       child: Text(
//                         'Class Name : $className',
//                         style: TextStyle(
//                             fontSize: 16.0,
//                             fontWeight: FontWeight.bold,
//                             color: Colors.white),
//                       ),
//                     ),
//                     Padding(
//                       padding: const EdgeInsets.only(top: 8),
//                       child: Text(
//                         'Subject Name : $subjectname',
//                         style: TextStyle(
//                             fontSize: 16.0,
//                             fontWeight: FontWeight.bold,
//                             color: Colors.white),
//                       ),
//                     ),
//                   ],
//                 ),
//               ],
//             ),
//           ),
//         ),
//       ),
//       onTap: () {
//         // Navigator.push(
//         //     context,
//         //     MaterialPageRoute(
//         //         builder: (context) => GenreBooks(
//         //               genre: cardName,
//         //               path: path,
//         //             )));
//       },
//     );
//   }
// }
