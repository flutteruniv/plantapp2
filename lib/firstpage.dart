import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:provider/provider.dart';
import 'main/main_model.dart';
import 'event_detail/event_detail_page.dart';
import 'widget/eventcard.dart';

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
          title: Text('イベント一覧'),
        ),
        body: Center(
          child: Consumer<MainModel>(builder: (context, model, child) {
            final events = model.events;

            return SingleChildScrollView(
              child: Column(
                children: [
                  for (int i = 0; i < events.length; i++) ...{
                    EventCard(
                      imgURL: events[i].imgURL,
                      title: events[i].title,
                      date: events[i].date,
                      press: () {
                        Navigator.push(
                          context,
                          MaterialPageRoute(
                            builder: (context) => EventDetail(i),
                          ),
                        );
                      },
                    ),
                  }
                ],
              ),
            );
          }),
        ),
      ),
    );
  }
}
