import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'add_event_model.dart';

class SecondPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider<AddEventModel>(
      create: (_) => AddEventModel(),
      child: Scaffold(
        appBar: AppBar(
          title: Text('入力フォーム'),
        ),
        body: Center(
            child: Consumer<AddEventModel>(builder: (context, model, child) {
          return Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              TextFormField(
                decoration: InputDecoration(
                  border: OutlineInputBorder(),
                  labelText: 'イベント名',
                ),
                onChanged: (text) {
                  model.title = text;
                },
              ),
              const SizedBox(height: 20),
              TextFormField(
                decoration: const InputDecoration(
                  border: OutlineInputBorder(),
                  labelText: '日程',
                ),
                onChanged: (text) {
                  model.date = text;
                },
              ),
              const SizedBox(height: 20),
              TextButton(
                style: ButtonStyle(
                  backgroundColor:
                      MaterialStateProperty.all<Color>(Colors.teal),
                ),
                //エラーキャッチ
                onPressed: () async {
                  try {
                    await model.addEvent();
                    final snackBar = SnackBar(
                      backgroundColor: Colors.green,
                      content: Text('イベントを追加しました。'),
                    );
                    ScaffoldMessenger.of(context).showSnackBar(snackBar);
                  } catch (e) {
                    final snackBar = SnackBar(
                      backgroundColor: Colors.red,
                      content: Text(
                        e.toString(),
                      ),
                    );
                    ScaffoldMessenger.of(context).showSnackBar(snackBar);
                  }
                },
                child: Text(
                  "エントリーする",
                  style: TextStyle(color: Colors.white),
                ),
              ),
            ],
          );
        })),
      ),
    );
  }
}
