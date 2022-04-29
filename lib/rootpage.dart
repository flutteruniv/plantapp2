import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'firstpage.dart';
import 'add_event/add_event_page.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:provider/provider.dart';
import 'main/main_model.dart';
import 'profile/profile_page.dart';

class RootPage extends StatelessWidget {
  // final docRef = FirebaseFirestore.instance.doc('date');
  final List<Widget> _pageList = <Widget>[
    FirstPage(),
    SecondPage(),
    ProfilePage()
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
        return Stack(
          children: [
            Scaffold(
              body: _pageList[model.currentIndex],
              bottomNavigationBar: BottomNavigationBar(
                  items: const <BottomNavigationBarItem>[
                    BottomNavigationBarItem(
                      icon: Icon(Icons.event_note),
                      label: 'Event List',
                    ),
                    BottomNavigationBarItem(
                      icon: Icon(Icons.edit),
                      label: 'Create an Event',
                    ),
                    BottomNavigationBarItem(
                      icon: Icon(Icons.face),
                      label: 'Profile',
                    ),
                  ],
                  currentIndex: currentIndex,
                  selectedItemColor: Colors.amber[800],
                  //todo ログイン確認
                  onTap: (index) {
                    if (FirebaseAuth.instance.currentUser != null) {
                      print('ログインしている');
                      print(FirebaseAuth.instance.currentUser?.email);
                    } else {
                      print('ログインしていない');
                    }
                    print(index);
                    model.currentIndex = index;
                    currentIndex = model.currentIndex;
                  }),
            ),
            if (model.isLoading)
              Container(
                  color: Colors.black54,
                  child: Center(
                    child: CircularProgressIndicator(),
                  ))
          ],
        );
      }),
    );
  }
}
