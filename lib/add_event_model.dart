import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/cupertino.dart';

class AddEventModel extends ChangeNotifier {
  String? title;
  String? date;

  //ヌルチェック 空だったらFireStoreに入れたくない
  Future addEvent() async {
    //「title=""」も「date!.isEmpt」yも一緒の意味
    if (title == null || title == "") {
      throw 'イベントのタイトルが空です。';
    }
    if (date == null || date!.isEmpty) {
      throw '日程が空です。';
    }
    //FireStoreに追加
    await FirebaseFirestore.instance.collection('event').add({
      'title': title,
      'date': date,
    });
  }
}
