import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'Utils/Navigator.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter_icons/flutter_icons.dart';

final FirebaseAuth _auth = FirebaseAuth.instance;

class Login extends StatefulWidget {
  @override
  _LoginState createState() => _LoginState();
}

class _LoginState extends State<Login> {
  final _formkey = GlobalKey<FormState>();
  var userid, password;
  var radval = "";
  var type,aut;
  @override
  void initState() {
    super.initState();
    aut = Firestore.instance
        .collectionGroup(radval)
        .where('UserID', isEqualTo: userid)
        .snapshots();
  }

  void _showDialog() {
    // flutter defined function
    showDialog(
      context: context,
      builder: (BuildContext context) {
        // return object of type Dialog
        return AlertDialog(
          title: new Text("Error"),
          content: new Text("Invalid Userid or Password"),
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

  void _showDialog1() {
    // flutter defined function
    showDialog(
      context: context,
      builder: (BuildContext context) {
        // return object of type Dialog
        return AlertDialog(
          title: new Text("Error"),
          content: new Text("Please Enter Userid"),
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

  void _showDialog2() {
    // flutter defined function
    showDialog(
      context: context,
      builder: (BuildContext context) {
        // return object of type Dialog
        return AlertDialog(
          title: new Text("Success"),
          content: new Text("Please Check your email for further instructions"),
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

  Future<String> signIn(String email, String password) async {
    AuthResult result = await _auth.signInWithEmailAndPassword(email: email, password: password);
    FirebaseUser user = result.user;
    return user.uid;
  }

  Future<String> resetPassword(String email) async {
    await _auth.sendPasswordResetEmail(email: email);

    return 'Please Check your email';
  }

  void Handler(String val) {
    setState(() {
      radval = val;
      switch (radval) {
        case "Patient":
          {
            type = 'Patient';
            break;
          }
        case "Doctor":
          {
            type = 'Doctor';
            break;
          }
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: ListView(
        children: <Widget>[
          Form(
              key: _formkey,
              child: Column(
                children: <Widget>[
                  Padding(
                    padding: EdgeInsets.all(10),
                  ),
                  Center(
                      child: Hero(
                          tag: 'Logo',
                          child: Container(
                            width: 255,
                            height: 255,
                            /*backgroundColor: Colors.white, radius: 150.0child: Image.asset('Images/pp.jpeg')*/
                            decoration: BoxDecoration(
                                shape: BoxShape.circle,
                                color: Colors.white,
                                image: DecorationImage(image: AssetImage('Images/pp.jpg'))),
                          ))),
                  Padding(
                    padding: EdgeInsets.all(10),
                  ),
                  Center(
                      child: Container(
                          width: 350,
                          height: 380,
                          child: Card(
                            color: Colors.white,
                            elevation: 10,
                            child: Column(
                              children: <Widget>[
                                Padding(
                                  padding: EdgeInsets.all(10),
                                ),
                                Text('Login',
                                    textAlign: TextAlign.center,
                                    style:
                                        TextStyle(color: Colors.red[900], fontSize: 30, fontWeight: FontWeight.bold)),
                                Padding(
                                  padding: EdgeInsets.all(10),
                                ),
                                Container(
                                  height: 50,
                                  width: 300,
                                  decoration:
                                      BoxDecoration(color: Colors.red[200], borderRadius: BorderRadius.circular(40)),
//                                  color: Colors.red[200],
//                                  shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(40),side: BorderSide(color: Colors.red[800])),
                                  child: Row(
                                    children: <Widget>[
                                      Padding(
                                        padding: EdgeInsets.only(left: 15),
                                      ),
                                      Container(
                                        width: 265,
                                        child: TextFormField(
                                          decoration: InputDecoration(
                                              labelText: 'User Id',
                                              labelStyle: TextStyle(color: Colors.red[800]),
                                              icon: Icon(
                                                Icons.person_outline,
                                                color: Colors.black,
                                              )),
                                          validator: (value) {
                                            if (value.isEmpty) {
                                              return 'Please enter the User ID.';
                                            } else if (!value.contains("@")) {
                                              return 'Please enter a valid User ID';
                                            } else {
                                              userid = value;
                                            }
                                          },
                                        ),
                                      ),

//                                      Container(height: 50,decoration: BoxDecoration(), child: TextFormField())
                                    ],
                                  ),
                                ),
                                Padding(
                                  padding: EdgeInsets.all(10),
                                ),
                                Container(
                                  height: 50,
                                  width: 300,
                                  decoration:
                                      BoxDecoration(color: Colors.red[200], borderRadius: BorderRadius.circular(40)),
//                                  color: Colors.red[200],
//                                  shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(40),side: BorderSide(color: Colors.red[800])),
                                  child: Row(
                                    children: <Widget>[
                                      Padding(
                                        padding: EdgeInsets.only(left: 15),
                                      ),
                                      Container(
                                        width: 265,
                                        child: TextFormField(
                                          obscureText: true,
                                          decoration: InputDecoration(
                                              labelText: 'Password',
                                              labelStyle: TextStyle(color: Colors.red[800]),
                                              icon: Icon(
                                                Foundation.key,
                                                color: Colors.black,
                                              )),
                                          validator: (value) {
                                            if (value.isEmpty) {
                                              return 'Please enter the Password.';
                                            } else if (value.length < 6 ||
                                                (!value.contains("0") &&
                                                    !value.contains("1") &&
                                                    !value.contains("2") &&
                                                    !value.contains("3") &&
                                                    !value.contains("4") &&
                                                    !value.contains("5") &&
                                                    !value.contains("6") &&
                                                    !value.contains("7") &&
                                                    !value.contains("8") &&
                                                    !value.contains("9"))) {
                                              return 'please enter a valid password with at least one number and greater than 6 characters';
                                            } else {
                                              password = value;
                                            }
                                          },
                                        ),

//                                      Container(height: 50,decoration: BoxDecoration(), child: TextFormField())
                                      )
                                    ],
                                  ),
                                ),
                                Padding(
                                  padding: EdgeInsets.all(0),
                                ),
                                Container(
                                  height: 50,
                                  width: 300,
                                  decoration: BoxDecoration(borderRadius: BorderRadius.circular(40)),
//                                  color: Colors.red[200],
//                                  shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(40),side: BorderSide(color: Colors.red[800])),
                                  child: Row(
                                    children: <Widget>[
                                      Padding(
                                        padding: EdgeInsets.only(left: 20),
                                      ),
                                      new Radio<String>(value: "Patient", groupValue: radval, onChanged: Handler),
                                      new Text("Patient",
                                          style: new TextStyle(
                                            color: Colors.red[900],
                                            fontWeight: FontWeight.bold,
                                          )),
                                      Padding(
                                        padding: EdgeInsets.only(left: 40),
                                      ),
                                      new Radio<String>(value: "Doctor", groupValue: radval, onChanged: Handler),
                                      new Text("Doctor",
                                          style: new TextStyle(color: Colors.red[900], fontWeight: FontWeight.bold)),

//                                      Container(height: 50,decoration: BoxDecoration(), child: TextFormField())
                                    ],
                                  ),
                                ),
                                Padding(
                                  padding: EdgeInsets.all(0),
                                ),
                                RaisedButton(
                                  shape: RoundedRectangleBorder(
                                      side: BorderSide(width: 2, color: Colors.white, style: BorderStyle.solid),
                                      borderRadius: BorderRadius.circular(70)),
                                  color: Colors.red[800],
                                  child: Container(
                                    width: 50,
                                    child: Text(
                                      "Submit",
                                      style: TextStyle(color: Colors.white),
                                    ),
                                  ),
                                  onPressed: () async {
                                    MyNavigator.goToPatient(context);
//
//                                        _auth = await signIn(userid, password);
//                                    if (_auth == null || aut.isEmpty == true) {
//                                      _showDialog();
//                                    } else {}
                                  },
                                ),
                                Padding(
                                  padding: EdgeInsets.all(0),
                                ),
                                Container(
                                  height: 50,
                                  width: 300,
                                  decoration: BoxDecoration(borderRadius: BorderRadius.circular(40)),
//                                  color: Colors.red[200],
//                                  shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(40),side: BorderSide(color: Colors.red[800])),
                                  child: Row(
                                    children: <Widget>[
                                      Padding(
                                        padding: EdgeInsets.only(left: 10),
                                      ),
                                      Card(
                                          elevation: 4,
                                          child: FlatButton(
                                              onPressed: () async {
                                                if (userid.isEmpty) {
                                                  _showDialog1();
                                                } else {
                                                  resetPassword(userid);

                                                  _showDialog2();
                                                }
                                              },
                                              child: new Text(
                                                "Reset Password",
                                                style:
                                                    new TextStyle(color: Colors.red[900], fontWeight: FontWeight.bold),
                                              ))),

                                      Padding(
                                        padding: EdgeInsets.only(left: 20),
                                      ),
                                      Card(elevation: 4, child: FlatButton(
                                          onPressed: () {},
                                          child: new Text(
                                            "Register",
                                            style: new TextStyle(color: Colors.red[900], fontWeight: FontWeight.bold),
                                          )),)

//                                      Container(height: 50,decoration: BoxDecoration(), child: TextFormField())
                                    ],
                                  ),
                                ),
                              ],
                            ),
                          )))
                ],
              ))
        ],
      ),
    );
  }
}
