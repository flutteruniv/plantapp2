import 'package:flutter/material.dart';
import 'firstpage.dart';
import 'secondpage.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:provider/provider.dart';
import 'main_model.dart';

class RootPage extends StatelessWidget {
  // final docRef = FirebaseFirestore.instance.doc('date');
  final List<Widget> _pageList = <Widget>[
    FirstPage(),
    SecondPage(),
  ];

  int currentIndex = 0;

  @override
  Widget build(BuildContext context) {
    FirebaseFirestore.instance
        .collection('event')
        .doc('DEarDWxlkm6lkrmAvNZs')
        .get()
        .then((ref) {
      print(ref.get("date"));
    });

    return ChangeNotifierProvider<MainModel>(
      // createでfetchBooks()も呼び出すようにしておく。
      create: (_) => MainModel()..fetchEvents(),
      child: Consumer<MainModel>(builder: (context, model, child) {
        return Scaffold(
          body: _pageList[model.currentIndex],
          bottomNavigationBar: BottomNavigationBar(
              items: const <BottomNavigationBarItem>[
                BottomNavigationBarItem(
                  icon: Icon(Icons.event_note),
                  label: 'Event List',
                ),
                BottomNavigationBarItem(
                  icon: Icon(Icons.edit),
                  label: 'Make a Event',
                ),
              ],
              currentIndex: currentIndex,
              selectedItemColor: Colors.amber[800],
              onTap: (index) {
                model.currentIndex = index;
              }),
        );
      }),
    );
  }
}
