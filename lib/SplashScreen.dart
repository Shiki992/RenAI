import 'dart:async';

import 'package:connectivity/connectivity.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';

import 'Utils/Navigator.dart';

class SplashScreen extends StatefulWidget {
  @override
  _SplashScreenState createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> {
  void initState() {

    super.initState();
    final FirebaseAuth _auth = FirebaseAuth.instance;
    var subscription = Connectivity().onConnectivityChanged.listen((ConnectivityResult result) {
      if (result == ConnectivityResult.mobile) {
        dispose();
        Timer(Duration(seconds: 5), () => MyNavigator.goToLogin(context));
      } else if (result == ConnectivityResult.wifi) {
        dispose();
        Timer(Duration(seconds: 5), () => MyNavigator.goToLogin(context));
      }
      else{
        _showDialog1();
      }
    });


  }


  void _showDialog1() {
    // flutter defined function
    showDialog(
      context: context,
      builder: (BuildContext context) {
        // return object of type Dialog
        return AlertDialog(
          title: new Text("Error"),
          content: new Text("Please Connect to the internet"),
          actions: <Widget>[
            // usually buttons at the bottom of the dialog
            new FlatButton(
              child: new Text("Close"),
              onPressed: () {
                Navigator.of(context).pop();
              },
            ),
          ],
        );
      },
    );
  }
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: Stack(
        fit: StackFit.expand,
        children: <Widget>[
          Container(
            decoration: BoxDecoration(color: Colors.white),
          ),
          Column(
            mainAxisAlignment: MainAxisAlignment.start,
            children: <Widget>[
              Expanded(
                flex: 2,
                child: Container(
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: <Widget>[
                      Center(
                          child: Hero(
                              tag: 'Logo',
                              child: Container(
                                width: 300,
                                height: 300,
                                /*backgroundColor: Colors.white, radius: 150.0child: Image.asset('Images/pp.jpeg')*/
                                decoration: BoxDecoration(
                                    shape: BoxShape.circle,
                                    color: Colors.white,
                                    image: DecorationImage(image: AssetImage('Images/pp.jpg'))),
                              ))),

                      Padding(
                        padding: EdgeInsets.only(top: 10.0),
                      ),
//                      Text(
//                        "Ren AI",
//                        style: TextStyle(
//                            color: Colors.red[800],
//                            fontWeight: FontWeight.bold,
//                            fontSize: 24.0),
//                      )
                    ],
                  ),
                ),
              ),

            ],
          )
        ],
      ),
    );
  }
}



