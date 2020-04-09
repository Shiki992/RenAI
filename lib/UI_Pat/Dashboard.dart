import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:flutter_icons/flutter_icons.dart';
import 'package:curved_navigation_bar/curved_navigation_bar.dart';
import 'package:charts_flutter/flutter.dart' as charts;
import 'package:renai/UI_Pat/Results.dart';
import 'package:renai/Utils/Navigator.dart';

class PatDashboard extends StatefulWidget {
  @override
  _PatDashboardState createState() => _PatDashboardState();
}

class _PatDashboardState extends State<PatDashboard> {
  int _currentindex = 0;

  @override
  Widget build(BuildContext context) {
    final tab = <Widget>[
      Dash(),
      Results(),
      Container(child: Center(child:Text('Under Development',textAlign: TextAlign.center,))),
      Container(child: Center(child:Text('Under Development',textAlign: TextAlign.center,)))
    ];
    return Scaffold(
      bottomNavigationBar: CurvedNavigationBar(
        index: _currentindex,
        animationCurve: Curves.easeInOutSine,
        animationDuration: Duration(milliseconds: 550),
        onTap: (value) {
          setState(() {
            _currentindex = value;
            debugPrint(_currentindex.toString());
          });
        },
        items: <Widget>[
          Icon(
            Octicons.dashboard,
            color: Colors.white,
          ),
          Icon(
            Foundation.results,
            color: Colors.white,
          ),
          Icon(
            Ionicons.ios_chatboxes,
            color: Colors.white,
          ),
          Icon(
            Feather.home,
            color: Colors.white,
          )
        ],
        backgroundColor: Colors.white,
        color: Colors.red[800],
        buttonBackgroundColor: Colors.red[800],
      ),
      appBar: AppBar(
        title: Text(
          'RenAI',
          style: TextStyle(color: Colors.white),
        ),
        backgroundColor: Colors.red[800],
        actions: <Widget>[
          IconButton(
              icon: Icon(
                Ionicons.ios_log_out,
                color: Colors.white,
                size: 30,
              ),
              onPressed: () {
                MyNavigator.goToLogin(context);
              })
        ],
        centerTitle: true,
      ),
      body: tab[_currentindex],
    );
  }
}

class Dash extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return ListView(
      children: <Widget>[
        Text(
          'Welcome Back Shiki!',
          style: TextStyle(color: Colors.red[800], fontWeight: FontWeight.bold, fontSize: 30),
          textAlign: TextAlign.center,
        ),
        Padding(padding: EdgeInsets.all(15)),
        Text(
          'Latest Result',
          style: TextStyle(color: Colors.red[800], fontWeight: FontWeight.bold, fontSize: 15),
          textAlign: TextAlign.center,
        ),
        StreamBuilder(
            stream: Firestore.instance
                .collection("Patient")
                .document('hWWvyUDvDnAp0tzgSEAU')
                .collection('Readings')
                .orderBy('test date', descending: true)
                .snapshots(),
            builder: (context, snapshot) {
              debugPrint('reached stream');
              if (!snapshot.hasData) return const Text("Loading");
              return ListView.builder(
                  scrollDirection: Axis.vertical,
                  shrinkWrap: true,
                  itemExtent: 100,
                  itemCount: 1,
                  itemBuilder: (context, index) {
                    debugPrint('${snapshot.data}');
                    return _buildstate(context, snapshot.data.documents[index]);
                  });
            }),
        Text(
          'Next Test Scedule',
          style: TextStyle(color: Colors.red[800], fontWeight: FontWeight.bold, fontSize: 15),
          textAlign: TextAlign.center,
        ),
        StreamBuilder(
            stream: Firestore.instance
                .collection("Patient")
                .document('hWWvyUDvDnAp0tzgSEAU')
                .collection('Readings')
                .orderBy('test date', descending: true)
                .snapshots(),
            builder: (context, snapshot) {
              debugPrint('reached stream');
              if (!snapshot.hasData) return const Text("Loading");
              return ListView.builder(
                  scrollDirection: Axis.vertical,
                  shrinkWrap: true,
                  itemExtent: 65,
                  itemCount: 1,
                  itemBuilder: (context, index) {
                    debugPrint('${snapshot.data}');
                    return _buildstate1(context, snapshot.data.documents[index]);
                  });
            })
      ],
    );
  }

  Widget _buildstate(BuildContext context, DocumentSnapshot document) {
    return ListTile(
        onTap: () {},
        title: Card(
          elevation: 5,
          shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(40)),
          child: Container(
              child: Column(
            children: <Widget>[
              Padding(
                padding: EdgeInsets.fromLTRB(10, 5, 0, 0),
              ),
              Expanded(
                child: Text(
                  'Ketone: ${document['ketone']}',
                  style: TextStyle(fontWeight: FontWeight.bold, fontSize: 15),
                ),
                flex: 5,
              ),
              Expanded(
                child: Text(
                  'Glucose: ${document['glucose']}',
                  style: TextStyle(fontWeight: FontWeight.bold, fontSize: 15),
                ),
                flex: 5,
              ),
              Expanded(
                child: Text(
                  'Last Test Taken: ${document['test date'].toDate()}',
                  style: TextStyle(fontWeight: FontWeight.bold, fontSize: 15),
                ),
                flex: 5,
              ),
              Column(
                children: <Widget>[
                  Padding(
                    padding: EdgeInsets.fromLTRB(0, 10, 66, 0),
                  ),
                ],
              )
            ],
          )),
        ));

  }
  Widget _buildstate1(BuildContext context, DocumentSnapshot document) {
    return ListTile(
        onTap: () {},
        title: Card(
          elevation: 5,
          shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(40)),
          child: Container(
              child: Column(
                children: <Widget>[
                  Padding(
                    padding: EdgeInsets.all(10),
                  ),

                  Expanded(
                    child: Text(
                      'Next Test Scheduled for: ${(document['test date'].toDate()).add(Duration(days:5,hours: 7))}',
                      style: TextStyle(fontWeight: FontWeight.bold, fontSize: 15),
                    ),
                    flex: 5,
                  ),
                  Column(
                    children: <Widget>[
                      Padding(
                        padding: EdgeInsets.fromLTRB(0, 10, 66, 0),
                      ),
                    ],
                  )
                ],
              )),
        ));
  }
}
