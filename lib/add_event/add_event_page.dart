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
                            : Image.asset('assets/images/noimage.png'),
                      ),
                      onTap: () async {
                        await model.pickImage();
                      },
                    ),
                    const SizedBox(height: 20),
                    TextFormField(
                      decoration: InputDecoration(
                        hintText: 'イベント名',
                        hintStyle: const TextStyle(fontSize: 12),
                        filled: true,
                        focusedBorder: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(16),
                        ),
                        enabledBorder: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(16),
                        ),
                      ),
                      onChanged: (text) {
                        model.title = text;
                      },
                    ),
                    const SizedBox(height: 20),
                    TextFormField(
                      controller: textEditingController,
                      decoration: InputDecoration(
                        hintText: '日程',
                        hintStyle: const TextStyle(fontSize: 12),
                        filled: true,
                        focusedBorder: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(16),
                        ),
                        enabledBorder: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(16),
                        ),
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
                      keyboardType: TextInputType.multiline,
                      maxLines: null,
                      decoration: InputDecoration(
                        hintText: 'イベント詳細',
                        hintStyle: const TextStyle(fontSize: 12),
                        filled: true,
                        focusedBorder: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(16),
                        ),
                        enabledBorder: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(16),
                        ),
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
                    const SizedBox(height: 20),
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
