import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/cupertino.dart';
import 'package:image_picker/image_picker.dart';
import 'dart:io';

class AddEventModel extends ChangeNotifier {
  String? title;
  String? date;
  File? imageFile;
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
  Future addEvent() async {
    //「title=""」も「date!.isEmpt」yも一緒の意味
    if (title == null || title == "") {
      throw 'イベントのタイトルが空です。';
    }
    if (date == null || date!.isEmpty) {
      throw '日程が空です。';
    }

    final doc = FirebaseFirestore.instance.collection('event').doc();

    String? imgURL;

    //storageにアップロード nullじゃなければ
    if (imageFile != null) {
      final task = await FirebaseStorage.instance
          .ref('event/${doc.id}')
          .putFile(imageFile!);
      imgURL = await task.ref.getDownloadURL();
    }

    //FireStoreに追加
    await doc.set({
      'title': title,
      'date': date,
      'imgURL': imgURL,
    });
  }

  Future pickImage() async {
    final pickedFile = await picker.pickImage(source: ImageSource.gallery);
    if (pickedFile != null) {
      imageFile = File(pickedFile.path);
      notifyListeners();
    }
  }
}
