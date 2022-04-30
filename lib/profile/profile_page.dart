import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:plantapp2/host_event/host_event_page.dart';
import 'package:plantapp2/login/login_page.dart';
import 'package:plantapp2/my_entry_event/my_entry_page.dart';
import 'package:plantapp2/profile/profile_page_model.dart';
import 'package:provider/provider.dart';
import '../profile_edit/profile_edit_page.dart';

class ProfilePage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider<ProfilePageModel>(
      create: (_) => ProfilePageModel()..fetchUser(),
      child: Scaffold(
        appBar: AppBar(
          title: Text('プロフィール'),
        ),
        endDrawer: Consumer<ProfilePageModel>(builder: (context, model, child) {
          return SafeArea(
            child: ClipRRect(
              borderRadius: BorderRadius.only(
                  topLeft: Radius.circular(20),
                  bottomLeft: Radius.circular(20)),
              child: Drawer(
                child: ListView(
                  children: <Widget>[
                    header(),
                    ListTile(
                      title: Text("エントリー済みイベント"),
                      trailing: Icon(Icons.arrow_forward),
                      onTap: () {
                        Navigator.push(
                          context,
                          MaterialPageRoute(
                            builder: (context) => MyEntryPage(),
                          ),
                        );
                      },
                    ),
                    ListTile(
                      title: Text("イベントの編集"),
                      trailing: Icon(Icons.arrow_forward),
                      onTap: () {
                        Navigator.push(
                          context,
                          MaterialPageRoute(
                            builder: (context) => HostEventPage(),
                          ),
                        );
                      },
                    ),
                    ListTile(
                      title: Text("ログアウト"),
                      trailing: Icon(Icons.arrow_forward),
                      onTap: () async {
                        model.startLoading();
                        try {
                          await model.signOut();
                          Navigator.pushReplacement(
                            context,
                            MaterialPageRoute(
                              builder: (context) => const LoginPage(),
                            ),
                          );
                          final snackBar = SnackBar(
                            backgroundColor: Colors.green,
                            content: Text(model.infoText),
                          );
                          ScaffoldMessenger.of(context).showSnackBar(snackBar);
                        } catch (e) {
                          final snackBar = SnackBar(
                              backgroundColor: Colors.red,
                              content: Text(e.toString()));
                          Navigator.push(
                            context,
                            MaterialPageRoute(
                              builder: (context) => const LoginPage(),
                            ),
                          );
                          ScaffoldMessenger.of(context).showSnackBar(snackBar);
                        } finally {}
                      },
                    ),
                  ],
                ),
              ),
            ),
          );
        }),
        body: Consumer<ProfilePageModel>(builder: (context, model, child) {
          return Center(
            child: Padding(
              padding: const EdgeInsets.all(16.0),
              child: Column(
                children: [
                  CircleAvatar(
                    radius: 60,
                    backgroundColor: Colors.blueGrey,
                    backgroundImage: NetworkImage(model.imgURL.toString()),
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
                                          builder: (context) => ProfileEditPage(
                                              model.username,
                                              model.rep,
                                              model.genre,
                                              model.imgURL),
                                        ),
                                      );
                                    },
                                  )
                                ],
                              ));
                    },
                    child: Text('プロフィールを編集する'),
                  ),
                  Text(model.username ?? 'ユーザ名なし'),
                  Text(model.rep ?? 'レペゼンなし'),
                  Text(model.genre ?? 'ジャンルなし'),
                  Text(model.email ?? 'メールアドレスなし'),
                ],
              ),
            ),
          );
        }),
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
