import 'package:cloud_firestore/cloud_firestore.dart';
import 'events.dart';
import 'package:flutter/cupertino.dart';

class MainModel extends ChangeNotifier {
  List<Events> events = [];

  Future<void> fetchEvents() async {
    // Firestoreからコレクション'events'(QuerySnapshot)を取得してdocsに代入。
    final docs = await FirebaseFirestore.instance.collection('event').get();
    // getter docs: docs(List<QueryDocumentSnapshot<T>>型)のドキュメント全てをリストにして取り出す。
    // map(): Listの各要素をBookに変換
    // toList(): Map()から返ってきたIterable→Listに変換する。
    final events = docs.docs.map((doc) => Events(doc)).toList();
    this.events = events;
    notifyListeners();
  }

  int _currentIndex = 0;
  int get currentIndex => _currentIndex;
  set currentIndex(int index) {
    _currentIndex = index;
    notifyListeners();
  }
}
//
// class BottomNavigationModel extends ChangeNotifier {
//   int _currentIndex = 0;
//
//   int get currentIndex => _currentIndex;
//
//   set currentIndex(int index) {
//     _currentIndex = index;
//     notifyListeners();
//   }
// }
//
// //参考：https://zenn.dev/ryouhei_furugen/articles/ebcd36964b0182
