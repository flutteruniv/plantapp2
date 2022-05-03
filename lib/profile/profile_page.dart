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
                        showDialog(
                          context: context,
                          builder: (_) {
                            return AlertDialog(
                              title: Text("ログアウトしますか？"),
                              content: null,
                              actions: <Widget>[
                                // ボタン領域
                                TextButton(
                                  child: Text("戻る"),
                                  onPressed: () => Navigator.pop(context),
                                ),
                                TextButton(
                                    child: Text("ログアウトする"),
                                    onPressed: () async {
                                      model.startLoading();
                                      try {
                                        await model.signOut();
                                        Navigator.pushAndRemoveUntil(
                                            context,
                                            MaterialPageRoute(
                                                builder: (context) =>
                                                    const LoginPage()),
                                            (_) => false);
                                        final snackBar = SnackBar(
                                          backgroundColor: Colors.green,
                                          content: Text(model.infoText),
                                        );
                                        ScaffoldMessenger.of(context)
                                            .showSnackBar(snackBar);
                                      } catch (e) {
                                        final snackBar = SnackBar(
                                            backgroundColor: Colors.red,
                                            content: Text(e.toString()));
                                        Navigator.push(
                                          context,
                                          MaterialPageRoute(
                                            builder: (context) =>
                                                const LoginPage(),
                                          ),
                                        );
                                        ScaffoldMessenger.of(context)
                                            .showSnackBar(snackBar);
                                      }
                                    }),
                              ],
                            );
                          },
                        );
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
                    radius: 75,
                    backgroundColor: Colors.blueGrey,
                    backgroundImage: NetworkImage(model.imgURL.toString()),
                  ),
                  TextButton(
                    onPressed: () {
                      showDialog(
                        context: context,
                        builder: (_) {
                          return AlertDialog(
                            title: Text("プロフィールを編集しますか？"),
                            content: null,
                            actions: <Widget>[
                              // ボタン領域
                              TextButton(
                                child: Text("戻る"),
                                onPressed: () => Navigator.pop(context),
                              ),
                              TextButton(
                                  child: Text("編集する"),
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
                                  }),
                            ],
                          );
                        },
                      );
                    },
                    child: Text(
                      'プロフィールを編集する',
                      style: TextStyle(color: Colors.teal),
                    ),
                  ),
                  Text(
                    model.username ?? 'ユーザ名なし',
                    style: const TextStyle(
                        fontSize: 18,
                        color: Colors.white,
                        fontWeight: FontWeight.bold),
                  ),
                  const SizedBox(height: 5),
                  Text(
                    model.rep ?? 'レペゼンなし',
                    style: TextStyle(
                      fontSize: 18,
                      color: Colors.white70,
                    ),
                  ),
                  const SizedBox(height: 5),
                  Text(
                    model.genre ?? 'ジャンルなし',
                    style: TextStyle(
                      fontSize: 18,
                      color: Colors.white70,
                    ),
                  ),
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
        decoration: BoxDecoration(color: Colors.teal),
      ),
    );
  }
}
