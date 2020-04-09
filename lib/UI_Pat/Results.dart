import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:charts_flutter/flutter.dart' as charts;
import 'package:flutter/painting.dart';
import 'package:renai/Utils/Readings.dart';

class Results extends StatefulWidget {
  @override
  _ResultsState createState() => _ResultsState();
}

class _ResultsState extends State<Results> {
  List<charts.Series<Readings, String>> _series=[],_sor=[];

  List<Readings> mydata,mydat;

  _gendat(List<Readings> mydata) {
    _series.add(charts.Series<Readings, String>(
        domainFn: (Readings red, _) => red.time,
        measureFn: (Readings red, _) => red.ketone,
        id: 'Ketone trends',
        data: mydata));
  }
  _gendat1(List<Readings> mydat) {
    _sor.add(charts.Series<Readings, String>(
        domainFn: (Readings red, _) => red.time,
        measureFn: (Readings red, _) => red.glucose,
        id: 'Glucose trends',
        data: mydat));
  }

  @override
  Widget build(BuildContext context) {
    return ListView(
      shrinkWrap: true,
      children: <Widget>[
        Text(
          'Latest Result',
          style: TextStyle(color: Colors.red[800], fontWeight: FontWeight.bold, fontSize: 30),
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
        StreamBuilder(
            stream: Firestore.instance.collection("Patient")
                .document('hWWvyUDvDnAp0tzgSEAU')
                .collection('Readings')
                .orderBy('test date', descending: true)
                .getDocuments().asStream(),
            builder: (context, snapshot) {
              if (!snapshot.hasData) return const Text("Loading");
              else
              {List<Readings> reed =
              snapshot.data.documents.map<Readings>((documentSnapshot) => Readings.fromMap(documentSnapshot.data)).toList();
              debugPrint(reed.toString());
              return _buildChart1(context, reed);}
            }),
        StreamBuilder(
            stream: Firestore.instance.collection("Patient")
                .document('hWWvyUDvDnAp0tzgSEAU')
                .collection('Readings')
                .orderBy('test date', descending: true)
                .getDocuments().asStream(),
            builder: (context, snapshot) {
              if (!snapshot.hasData) return const Text("Loading");
              else
              {List<Readings> roed =
              snapshot.data.documents.map<Readings>((documentSnapshot) => Readings.fromMap(documentSnapshot.data)).toList();
              debugPrint(roed.toString());
              return _buildChart2(context, roed);}
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
                  'Last Taken: ${document['test date'].toDate()}',
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

  Widget _buildChart1(BuildContext context, List<Readings> reed) {
    _gendat(reed);
    return Padding(
      padding: EdgeInsets.all(10),
      child: Container(
        width: 500,
        height: 300,
        child: Center(child: Column(
          mainAxisSize: MainAxisSize.min,
          children: <Widget>[
            Text('Ketone Trends',style: TextStyle(fontSize: 20,fontWeight: FontWeight.bold,color: Colors.red[800]),),
            SizedBox(height: 10),
            Expanded(flex: 2,child: charts.BarChart(_series,animate: true,animationDuration: Duration(seconds: 5)),)
          ],
        ),),
      ),
    );
  }
  Widget _buildChart2(BuildContext context, List<Readings> roed) {
    _gendat1(roed);
    return Padding(
      padding: EdgeInsets.all(10),
      child: Container(
        width: 500,
        height: 300,
        child: Center(child: Column(
          mainAxisSize: MainAxisSize.min,
          children: <Widget>[
            Text('Glucose Trends',style: TextStyle(fontSize: 20,fontWeight: FontWeight.bold,color: Colors.red[800]),),
            SizedBox(height: 10),
            Expanded(flex: 2,child: charts.BarChart(_sor,animate: true,animationDuration: Duration(seconds: 5)),)
          ],
        ),),
      ),
    );
  }
}
