import 'package:cloud_firestore/cloud_firestore.dart';

class Events {
  String? title;
  String? date;
  String? imgURL;
  String? detail;
  // String? eventID;

  Events(DocumentSnapshot doc) {
    title = doc['title'];
    date = doc['date'];
    imgURL = doc['imgURL'];
    detail = doc['detail'];
    // eventID = doc['eventID'];
  }
}

class HostEntryList {
  String? uid;
  String? title;
  String? date;
  String? imgURL;
  String? detail;

  HostEntryList(DocumentSnapshot doc) {
    uid = doc['uid'];
    title = doc['title'];
    date = doc['date'];
    imgURL = doc['imgURL'];
    detail = doc['detail'];
  }
}

class Entry {
  String? user;
  String? rep;
  // String? eventID;

  Entry(DocumentSnapshot doc) {
    user = doc['user'];
    rep = doc['rep'];
    // eventID = doc['eventID'];
  }
}
