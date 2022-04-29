import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'edit_event_model.dart';

class EditEventPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider<EditEventModel>(
      create: (_) => EditEventModel(),
      child: Scaffold(
        appBar: AppBar(
          title: Text('イベント編集'),
        ),
        body: Center(
            child: Consumer<EditEventModel>(builder: (context, model, child) {
          final textEditingController = model.textEditingController;
          return Stack(
            children: [
              SingleChildScrollView(
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    GestureDetector(
                      child: SizedBox(
                        width: 200,
                        height: 160,
                        child: model.imageFile != null
                            ? Image.file(model.imageFile!)
                            : Container(color: Colors.grey),
                      ),
                      onTap: () async {
                        await model.pickImage();
                      },
                    ),
                    const SizedBox(height: 20),
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
                      controller: textEditingController,
                      decoration: const InputDecoration(
                        border: OutlineInputBorder(),
                        labelText: '日程',
                      ),
                      onTap: () {
                        model.getDate(context);
                      },
                      onChanged: (text) {
                        model.date = text;
                      },
                    ),
                    const SizedBox(height: 20),
                    TextFormField(
                      maxLines: null,
                      decoration: const InputDecoration(
                        border: OutlineInputBorder(),
                        labelText: 'イベント詳細',
                      ),
                      onChanged: (text) {
                        model.detail = text;
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
                          model.startLoading();
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
                        } finally {
                          model.endLoading();
                        }
                      },
                      child: Text(
                        "イベント作成",
                        style: TextStyle(color: Colors.white),
                      ),
                    ),
                  ],
                ),
              ),
              //isLoadingがtrueの時だけ動く
              if (model.isLoading)
                Container(
                  color: Colors.black54,
                  child: Center(
                    child: CircularProgressIndicator(),
                  ),
                )
            ],
          );
        })),
      ),
    );
  }
}
