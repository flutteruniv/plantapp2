import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/cupertino.dart';
import 'package:image_picker/image_picker.dart';

class EntryModel extends ChangeNotifier {
  String? name;
  String? rep;

  bool isLoading = false;

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
  Future addEntry() async {
    //「title=""」も「date!.isEmpt」yも一緒の意味
    if (name == null || name == "") {
      throw 'エントリー名が空です。';
    }
    if (rep == null || rep!.isEmpty) {
      throw 'レペゼンが空です。';
    }

    final doc = FirebaseFirestore.instance.collection('entry').doc();

    //FireStoreに追加
    await doc.set({
      'name': name,
      'rep': rep,
    });
  }
}
