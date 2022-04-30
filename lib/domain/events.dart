import 'package:cloud_firestore/cloud_firestore.dart';

class Events {
  String? eventId;
  String? title;
  String? date;
  String? imgURL;
  String? detail;
  // String? eventID;

  Events(DocumentSnapshot doc) {
    eventId = doc.id;
    title = doc['title'];
    date = doc['date'];
    imgURL = doc['imgURL'];
    detail = doc['detail'];
    // eventID = doc['eventID'];
  }
}

class HostEntryList {
  String? eventId;
  String? uid;
  String? title;
  String? date;
  String? imgURL;
  String? detail;

  HostEntryList(DocumentSnapshot doc) {
    eventId = doc.id;
    uid = doc['uid'];
    title = doc['title'];
    date = doc['date'];
    imgURL = doc['imgURL'];
    detail = doc['detail'];
  }
}

class MyEntryList {
  String? eventId;
  String? uid;
  String? title;
  String? eventDate;

  MyEntryList(DocumentSnapshot doc) {
    eventId = doc['eventID'];
    uid = doc['uid'];
    title = doc['title'];
    eventDate = doc['eventDate'];
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
