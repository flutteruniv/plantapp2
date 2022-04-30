import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/cupertino.dart';

class MyEventDetailModel extends ChangeNotifier {
  MyEventDetailModel(id) {
    eventId = id;
  }
  String? title;
  String? date;
  String? detail;
  String? imgURL;
  String? eventId;

  bool isLoading = false;

  void fetchMyEventDetail() async {
    final snapshot =
        await FirebaseFirestore.instance.collection('event').doc(eventId).get();
    final data = snapshot.data();
    this.title = data?['title'];
    this.date = data?['date'];
    this.detail = data?['detail'];
    this.imgURL = data?['imgURL'];

    notifyListeners();
  }
}
