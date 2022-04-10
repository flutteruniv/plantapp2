import 'package:cloud_firestore/cloud_firestore.dart';

class Events {
  String? title;
  String? date;
  String? imgURL;
  Events(DocumentSnapshot doc) {
    title = doc['title'];
    date = doc['date'];
    imgURL = doc['imgURL'];
  }
}
