import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:plantapp2/entry/entry_page.dart';
import 'package:provider/provider.dart';
import 'my_event_detail_model.dart';
import '../entrylist/entorylist_page.dart';

class MyEventDetailPage extends StatelessWidget {
  // final docRef = FirebaseFirestore.instance.doc('date');
  MyEventDetailPage(this.eventID);
  String eventID;

  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider<MyEventDetailModel>(
      // createでfetchBooks()も呼び出すようにしておく。
      create: (_) => MyEventDetailModel(eventID)..fetchMyEventDetail(),
      child: Scaffold(
        appBar: AppBar(
          title: Text('詳細'),
        ),
        body: Center(
          child: Consumer<MyEventDetailModel>(builder: (context, model, child) {
            // final events = model.events;

            return SingleChildScrollView(
              child: Column(children: [
                Image.network(
                  model.imgURL.toString(),
                ),
                const SizedBox(height: 20),
                Text(
                  model.title.toString(),
                ),
                const SizedBox(height: 10),
                Text(
                  model.date.toString(),
                ),
                const SizedBox(height: 10),
                Padding(
                  padding: const EdgeInsets.all(16.0),
                  child: Text(
                    model.detail.toString(),
                  ),
                ),
                const SizedBox(height: 10),
                TextButton(
                  style: ButtonStyle(
                    backgroundColor:
                        MaterialStateProperty.all<Color>(Colors.teal),
                  ),
                  onPressed: () => {
                    Navigator.of(context)
                        .push(MaterialPageRoute(builder: (context) {
                      return EntoryList(
                          model.title.toString(),
                          model.eventId.toString());
                    }))
                  },
                  child: Text(
                    "エントリーリスト",
                    style: TextStyle(color: Colors.white),
                  ),
                ),
                const SizedBox(height: 10),
                TextButton(
                  style: ButtonStyle(
                    backgroundColor:
                        MaterialStateProperty.all<Color>(Colors.teal),
                  ),
            onPressed:null,
                  // onPressed: () => {
                  //   Navigator.of(context)
                  //       .push(MaterialPageRoute(builder: (context) {
                  //     return EntryPage(
                  //         events[eventNum].title.toString(),
                  //         events[eventNum].eventId.toString(),
                  //         events[eventNum].date.toString());
                  //   }))
                  // },
                  child: Text(
                    "エントリー内容を変更する",
                    style: TextStyle(color: Colors.white),
                  ),
                ),
              ]),
            );
          }),
        ),
      ),
    );
  }
}
