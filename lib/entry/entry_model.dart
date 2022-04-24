import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/cupertino.dart';
import 'package:image_picker/image_picker.dart';
import 'dart:io';

class EntryModel extends ChangeNotifier {
  String? user;
  String? rep;
  String? genre;
  bool isLoading = false;

  final timestamp = DateTime.now();
  final picker = ImagePicker();

  void startLoading() {
    isLoading = true;
    notifyListeners();
  }

  void endLoading() {
    isLoading = false;
    notifyListeners();
  }

  //ヌルチェック 空だったらFireStoreに入れたくない
  Future addEntry(String eventTitle) async {
    //「title=""」も「date!.isEmpt」yも一緒の意味
    if (user == null || user == "") {
      throw 'エントリー名が空です。';
    }
    if (rep == null || rep!.isEmpty) {
      throw '所属が空です。';
    }
    if (genre == null || genre!.isEmpty) {
      throw 'ジャンルが空です。。';
    }

    final doc = FirebaseFirestore.instance.collection('entry').doc();

    // final title = await FirebaseFirestore.instance
    //     .collection('event')
    //     //todo isEqualTo:イベント名にしたい。
    //     .where('title', isEqualTo: events[1].title.toString())
    //     .get();

    //FireStoreに追加
    await doc.set({
      'user': user,
      'rep': rep,
      'genre': genre,
      'timestamp': timestamp,
      'title': eventTitle
    });
  }
}
