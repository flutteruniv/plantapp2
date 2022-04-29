import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'user_edit_page.dart';

class UserPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('プロフィール'),
      ),
      endDrawer: SafeArea(
        child: ClipRRect(
          borderRadius: BorderRadius.only(
              topLeft: Radius.circular(20), bottomLeft: Radius.circular(20)),
          child: Drawer(
            child: ListView(
              children: <Widget>[
                header(),
                ListTile(
                  title: Text("エントリー済みイベント"),
                  trailing: Icon(Icons.arrow_forward),
                ),
                ListTile(
                  title: Text("イベントの編集"),
                  trailing: Icon(Icons.arrow_forward),
                ),
              ],
            ),
          ),
        ),
      ),
      body: Center(
        child: Column(
          children: [
            CircleAvatar(
              radius: 60,
              backgroundColor: Colors.blueGrey,
              backgroundImage: NetworkImage(
                  "https://flutternyumon.com/wp-content/uploads/2022/02/blue-bird.png"),
            ),
            TextButton(
              onPressed: () {
                showDialog(
                    context: context,
                    builder: (_) => CupertinoAlertDialog(
                          title: Text("Change your profile?"),
                          content: Text("プロフィールを編集しますか？"),
                          actions: [
                            CupertinoDialogAction(
                                child: Text('戻る'),
                                isDestructiveAction: true,
                                onPressed: () {
                                  Navigator.of(context).pop();
                                }),
                            CupertinoDialogAction(
                              child: Text('編集する'),
                              onPressed: () {
                                Navigator.push(
                                  context,
                                  MaterialPageRoute(
                                    builder: (context) => UserEditPage(),
                                  ),
                                );
                              },
                            )
                          ],
                        ));
              },
              child: Text('プロフィールを編集する'),
            ),
            Text('名前'),
            Text('レペゼン'),
            Text('ジャンル'),
          ],
        ),
      ),
    );
  }
}

class header extends StatelessWidget {
  const header({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: 60,
      child: DrawerHeader(
        child: Text(
          '編集画面',
          style: TextStyle(
            fontSize: 16.0,
            color: Colors.white,
          ),
          textAlign: TextAlign.center,
        ),
        decoration: BoxDecoration(color: Colors.blue[300]),
      ),
    );
  }
}
