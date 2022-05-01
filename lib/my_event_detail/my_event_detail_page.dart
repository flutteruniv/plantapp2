import 'package:flutter/material.dart';
import 'package:plantapp2/my_entry_edit/my_entry_edit_page.dart';
import 'package:provider/provider.dart';
import '../domain/events.dart';
import 'my_event_detail_model.dart';
import '../entrylist/entorylist_page.dart';

class MyEventDetailPage extends StatelessWidget {
  // final docRef = FirebaseFirestore.instance.doc('date');
  MyEventDetailPage(this.myEntryList);
  final MyEntryList myEntryList;

  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider<MyEventDetailModel>(
      // createでfetchBooks()も呼び出すようにしておく。
      create: (_) =>
          MyEventDetailModel(myEntryList.eventId)..fetchMyEventDetail(),
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
                  myEntryList.user.toString(),
                ),
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
                          model.title.toString(), model.eventId.toString());
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
                  onPressed: () => {
                    Navigator.of(context)
                        .push(MaterialPageRoute(builder: (context) {
                      return MyEntryEditPage(myEntryList);
                    }))
                  },
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
