import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:provider/provider.dart';
import '../main/main_model.dart';
import '../widget/entrycard.dart';

class EntoryList extends StatelessWidget {
  // final docRef = FirebaseFirestore.instance.doc('date');
  EntoryList(this.eventNum, this.eventTitle);
  int eventNum;
  String eventTitle;

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
      create: (_) => MainModel()..fetchEntryList(eventTitle.toString()),
      child: Scaffold(
        appBar: AppBar(
          title: Text('エントリーリスト${eventTitle}'),
        ),
        body: Center(
          child: Consumer<MainModel>(builder: (context, model, child) {
            // final events = model.events;
            final entryList = model.entrylist;

            return SingleChildScrollView(
              child: Column(children: [
                const SizedBox(height: 10),
                //画像とか日付とか
                // Text(
                //   events[eventNum].title.toString(),
                //   style: TextStyle(fontWeight: FontWeight.bold),
                // ),
                // const SizedBox(height: 10),
                // Text(
                //   events[eventNum].date.toString(),
                // ),
                const SizedBox(height: 10),
                for (int i = 0; i < entryList.length; i++) ...{
                  EntryCard(user: entryList[i].user, rep: entryList[i].rep),
                }

                // EntryCard(user: 'ボブチャンチン', rep: 'Waseda Breakers'),
                // EntryCard(user: 'Marcio', rep: 'Flying Steps'),
                // EntryCard(user: 'JOY', rep: 'Dark Wave'),
                // EntryCard(user: 'クリキン', rep: 'DefClans'),
                // EntryCard(user: 'Issei', rep: 'Found Nation'),
                // EntryCard(user: '岡村隆史', rep: 'ナインティナイン'),
                // EntryCard(user: 'Lilou', rep: 'Red Bull BC One ALL Stars'),
                // const SizedBox(height: 10),
              ]),
            );
          }),
        ),
      ),
    );
  }
}