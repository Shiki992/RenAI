import 'package:cloud_firestore/cloud_firestore.dart';

class Readings {
   final num ketone;
   final num glucose;
  String time;


  Readings(this.ketone,this.glucose, this.time);

  Readings.fromMap(Map<String, dynamic> map)
      : assert(map['ketone'] != null),
        assert(map['glucose'] != null),
        assert(map['test date'] != null),
        ketone = map['ketone'],
        glucose = map['glucose'],
        time = ((map['test date'].toDate().day)).toString();


  @override
  String toString()=> "Records<${(time)}:${ketone}>";
}
