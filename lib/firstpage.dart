import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:provider/provider.dart';
import 'main_model.dart';
import 'nextpage.dart';
import 'eventcard.dart';

class FirstPage extends StatelessWidget {
  // final docRef = FirebaseFirestore.instance.doc('date');

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
      child: Scaffold(
        appBar: AppBar(
          title: Text('テスト'),
        ),
        body: Center(
          child: Consumer<MainModel>(builder: (context, model, child) {
            final events = model.events;
            print(events);

            return SingleChildScrollView(
              child: Column(
                children: [
                  EventCard(
                    image: "assets/images/image1.jpg",
                    title: events[0].title,
                    date: events[0].date,
                    press: () {
                      Navigator.push(
                        context,
                        MaterialPageRoute(
                          builder: (context) => NextPage(),
                        ),
                      );
                    },
                  ),
                  EventCard(
                      image: "assets/images/image1.jpg",
                      title: events[1].title,
                      date: events[1].date),
                  EventCard(
                      image: "assets/images/image1.jpg",
                      title: "BC ONE",
                      date: "2022/4/5"),
                  EventCard(
                      image: "assets/images/image1.jpg",
                      title: "BC ONE",
                      date: "2022/4/5"),
                ],
              ),
            );
          }),
        ),
      ),
    );
  }
}