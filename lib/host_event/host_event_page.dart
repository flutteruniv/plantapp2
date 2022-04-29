import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:plantapp2/edit_event/edit_event_page.dart';
import 'package:provider/provider.dart';
import '../main/main_model.dart';
import 'host_event_model.dart';

class HostEventPage extends StatelessWidget {
  // final docRef = FirebaseFirestore.instance.doc('date');
  // HostEventPage(this.eventNum, this.eventTitle);
  // int eventNum;
  // String eventTitle;
  @override
  Widget build(BuildContext context) {
    FirebaseFirestore.instance
        .collection('event')
        .doc('DEarDWxlkm6lkrmAvNZs')
        .get()
        .then((ref) {
      print(ref.get("date"));
    });

    return ChangeNotifierProvider<HostEventModel>(
      // createでfetchBooks()も呼び出すようにしておく。
      create: (_) => HostEventModel()..fetchHostEventList(),
      child: Scaffold(
        appBar: AppBar(
          title: Text('主催イベントリスト'),
        ),
        body: Center(
          child: Consumer<HostEventModel>(builder: (context, model, child) {
            final hostEntryList = model.hostEntryList;

            return SingleChildScrollView(
              child: Column(children: [
                const SizedBox(height: 10),
                for (int i = 0; i < hostEntryList.length; i++) ...{
                  Card(
                    child: ListTile(
                      title: Text(hostEntryList[i].title.toString()),
                      subtitle: Text(hostEntryList[i].date.toString()),
                      onTap: () {
                        Navigator.push(
                          context,
                          MaterialPageRoute(
                            builder: (context) => EditEventPage(),
                          ),
                        );
                      },
                    ),
                  ),
                }
              ]),
            );
          }),
        ),
      ),
    );
  }
}
