import 'package:flutter/material.dart';
import 'ChatStudent.dart';
import 'ClassStudent.dart';
import 'TodoStudent.dart';
import 'StatusStudent.dart';

class HomePageStudent extends StatefulWidget {
  @override
  _HomePageStudentState createState() => _HomePageStudentState();
}

class _HomePageStudentState extends State<HomePageStudent>
    with TickerProviderStateMixin {
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
                    // color: Colors.black,
                    child: Center(
                      child: TabBar(
                        controller: tabController,
                        indicatorColor: Color(0xffff5757),
                        labelColor: Color(0xffff5757),
                        unselectedLabelColor: Colors.grey,
                        isScrollable: true,
                        tabs: [
                          Tab(
                            text: 'CHATS',
                          ),
                          Tab(
                            text: 'CLASS',
                          ),
                          Tab(
                            text: 'TODO',
                          ),
                          Tab(
                            text: 'STATUS',
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
                      ChatStudent(),
                      ClassStudent(),
                      TodoStudent(),
                      StatusStudent()
                    ],
                  ),
                )
              ],
            ),
          )),
    );
  }
}
