import 'package:flutter/material.dart';
import 'package:flutter/cupertino.dart';
import 'package:provider/provider.dart';
import '../rootpage.dart';
import 'edit_event_model.dart';

class EditEventPage extends StatelessWidget {
  EditEventPage(this.title, this.date, this.detail, this.imgURL, this.id);
  final String? title;
  final String? date;
  final String? detail;
  final String? imgURL;
  final String? id;

  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider<EditEventModel>(
      create: (_) => EditEventModel(title, date, detail, imgURL, id),
      child: Scaffold(
        appBar: AppBar(
          title: Text('イベント編集'),
        ),
        body: Center(
            child: Consumer<EditEventModel>(builder: (context, model, child) {
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
                            : Container(
                                child: model.imgURL != null ||
                                        model.imgURL == ""
                                    ? Image.network(
                                        model.imgURL.toString(),
                                        fit: BoxFit.cover,
                                      )
                                    : Image.asset('assets/images/noimage.png'),
                              ),
                      ),
                      onTap: () async {
                        await model.pickImage();
                      },
                    ),
                    const SizedBox(height: 20),
                    TextFormField(
                      controller: model.titleEditingController,
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
                      controller: model.dateEditingController,
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
                          await model.updateEvent();
                          Navigator.popUntil(context, (route) => route.isFirst);
                          final snackBar = SnackBar(
                            backgroundColor: Colors.green,
                            content: Text('イベントを更新しました。'),
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
                        "イベント更新",
                        style: TextStyle(color: Colors.white),
                      ),
                    ),
                    TextButton(
                      style: ButtonStyle(
                        backgroundColor:
                            MaterialStateProperty.all<Color>(Colors.red),
                      ),
                      //エラーキャッチ
                      onPressed: () {
                        showDialog(
                          context: context,
                          builder: (_) {
                            return AlertDialog(
                              title: Text("削除の確認。"),
                              content: Text("イベント削除後は取り消すことができません。"
                                  "本当によろしいですか？"),
                              actions: <Widget>[
                                // ボタン領域
                                TextButton(
                                  child: Text("Cancel"),
                                  onPressed: () => Navigator.pop(context),
                                ),
                                TextButton(
                                    child: Text("OK"),
                                    onPressed: () {
                                      model.deleteEvent();
                                      model.deleteEntryAll();
                                      Navigator.pop(context);
                                    }),
                              ],
                            );
                          },
                        );
                      },
                      child: Text(
                        "イベント削除",
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
