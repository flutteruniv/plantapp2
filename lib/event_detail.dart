import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:provider/provider.dart';
import 'main_model.dart';
import 'event_detail.dart';
import 'eventcard.dart';

class EventDetail extends StatelessWidget {
  // final docRef = FirebaseFirestore.instance.doc('date');
  EventDetail(this.eventNum);
  int eventNum;

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
          title: Text('詳細'),
        ),
        body: Center(
          child: Consumer<MainModel>(builder: (context, model, child) {
            final events = model.events;

            return Column(children: [
              Image.network(
                events[eventNum].imgURL.toString(),
              ),
              const SizedBox(height: 20),
              Text(
                events[eventNum].title.toString(),
              ),
              const SizedBox(height: 10),
              Text(
                events[eventNum].date.toString(),
              ),
              const SizedBox(height: 10),
              Text(
                events[eventNum].detail.toString(),
              ),
              const SizedBox(height: 10),
              TextButton(
                style: ButtonStyle(
                  backgroundColor:
                      MaterialStateProperty.all<Color>(Colors.teal),
                ),
                onPressed: null,
                child: Text(
                  "エントリーする",
                  style: TextStyle(color: Colors.white),
                ),
              ),
            ]);
          }),
        ),
      ),
    );
  }
}
