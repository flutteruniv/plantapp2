import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:provider/provider.dart';
import 'main_model.dart';
import 'event_detail.dart';
import 'eventcard.dart';

class EventDetail extends StatelessWidget {
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
          title: Text('詳細'),
        ),
        body: Center(
          child: Consumer<MainModel>(builder: (context, model, child) {
            final events = model.events;

            return Column(children: [
              Image.asset("assets/images/image1.jpg"),
              const SizedBox(height: 20),
              Text(events[0].title.toString()),
              const SizedBox(height: 10),
              Text(events[0].date.toString()),
              const SizedBox(height: 10),
              Text(
                  "世界最高峰の1 on 1ブレイキンバトル「Red Bull BC One」。毎年、何千人ものB-Boy/B-Girlたちが『Red Bull BC One World Final』の舞台に立つために挑戦している。16名のB-Boy、そして16名のB-GirlのみがRed Bull BC Oneのステージに立つ権利を得ることができ、その中のたった1名がチャンピオンの称号を得ることができる。2004年以降、世界中の主要都市16箇所でワールドファイナルが行われ、Red Bull BC Oneは、50以上の地区予選、そして、30箇所以上でサイファーやキャンプなどのプログラムが行われている。イベントのない国では、『Red Bull BC One E-Battle』が行われ、インターネット環境があれば世界どこからでも誰でも参加ができ、チャンピオンを目指すことができる。Red Bull BC Oneはまた、世界トップレベルのブレイキン・クルー「Red Bull BC One All Stars」も抱えている。"),
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
