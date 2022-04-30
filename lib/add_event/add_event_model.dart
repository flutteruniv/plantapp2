import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'dart:io';
import 'package:intl/intl.dart';
import 'package:firebase_auth/firebase_auth.dart';

class AddEventModel extends ChangeNotifier {
  String? title;
  String? date;
  String? detail;
  File? imageFile;
  bool isLoading = false;
  final timestamp = DateTime.now();
  final textEditingController = TextEditingController();

  final picker = ImagePicker();

  void startLoading() {
    isLoading = true;
    notifyListeners();
  }

  void endLoading() {
    isLoading = false;
    notifyListeners();
  }

  Future getDate(BuildContext context) async {
    final initialDate = DateTime.now();

    final newDate = await showDatePicker(
      context: context,
      initialDate: initialDate,
      firstDate: DateTime(DateTime.now().year - 3),
      lastDate: DateTime(DateTime.now().year + 3),
    );

    if (newDate != null) {
      //選択した日付をTextFormFieldに設定
      textEditingController.text = DateFormat("yyyy年MM月dd日").format(newDate);
    } else {
      return;
    }
  }

  Future addEvent() async {
    // RandomID生成
    //   String eventID([int length = 32]) {
    //     const charset =
    //         '0123456789ABCDEFGHIJKLMNOPQRSTUVXYZabcdefghijklmnopqrstuvwxyz-._';
    //     final random = Random.secure();
    //     final randomStr =
    //         List.generate(length, (_) => charset[random.nextInt(charset.length)])
    //             .join();
    //     return randomStr;
    //   }
    //   print(eventID());
    //ヌルチェック 空だったらFireStoreに入れたくない

    //「title=""」も「date!.isEmpt」yも一緒の意味
    if (title == null || title == "") {
      throw 'イベントのタイトルが空です。';
    }
    if (date == null || date!.isEmpty) {
      throw '日程が空です。';
    }
    if (detail == null || detail!.isEmpty) {
      throw '詳細が空です。';
    }
    final uid = await FirebaseAuth.instance.currentUser!.uid;

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
      'eventID': doc.id,
      'title': title,
      'date': date,
      'detail': detail,
      'imgURL': imgURL,
      'timestamp': timestamp,
      'uid': uid,
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
