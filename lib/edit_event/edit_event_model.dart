import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'dart:io';

import 'package:intl/intl.dart';

class EditEventModel extends ChangeNotifier {
  EditEventModel(title, date, detail, imgURL, id) {
    titleEditingController.text = title!;
    dateEditingController.text = date.toString();
    detailEditingController.text = detail.toString();
    imgURL = imgURL;
    documentId = id;
  }

  String? title;
  String? date;
  String? detail;
  String? imgURL;
  String? documentId;
  File? imageFile;
  bool isLoading = false;

  final timestamp = DateTime.now();

  final titleEditingController = TextEditingController();
  final dateEditingController = TextEditingController();
  final detailEditingController = TextEditingController();

  final picker = ImagePicker();

  void setTitle(String title) {
    this.title = title;
    notifyListeners();
  }

  void setDate(String date) {
    this.date = date;
    notifyListeners();
  }

  void setDetail(String detail) {
    this.detail = detail;
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
      dateEditingController.text = DateFormat("yyyy年MM月dd日").format(newDate);
    } else {
      return;
    }
  }

  void startLoading() {
    isLoading = true;
    notifyListeners();
  }

  void endLoading() {
    isLoading = false;
    notifyListeners();
  }

  bool isUpdated() {
    return title != null;
  }

  Future updateEvent() async {
    print(documentId);
    if (imageFile != null) {
      final doc = FirebaseFirestore.instance.collection('event').doc();

      final task = await FirebaseStorage.instance
          .ref('event/${doc.id}')
          .putFile(imageFile!);
      imgURL = await task.ref.getDownloadURL();
    }

    this.title = titleEditingController.text;
    this.date = dateEditingController.text;
    this.detail = detailEditingController.text;
    await FirebaseFirestore.instance
        .collection('event')
        .doc(documentId)
        .update({
      'title': title,
      'date': date,
      'detail': detail,
      'imgURL': imgURL,
    });
  }

  Future deleteEvent() {
    return FirebaseFirestore.instance
        .collection('event')
        .doc(documentId)
        .delete();
  }

  Future deleteEntryAll() {
    return FirebaseFirestore.instance
        .collection('entry')
        .where('eventID', isEqualTo: documentId)
        .get()
        .then((snapshot) {
      for (DocumentSnapshot ds in snapshot.docs) {
        ds.reference.delete();
      }
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
