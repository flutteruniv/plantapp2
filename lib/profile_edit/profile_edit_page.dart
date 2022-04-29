import 'package:flutter/material.dart';
import 'package:plantapp2/profile_edit/profile_edit_model.dart';
import 'package:provider/provider.dart';

class ProfileEditPage extends StatelessWidget {
  ProfileEditPage(this.username, this.genre, this.rep, this.imgURL);
  final String? username;
  final String? genre;
  final String? rep;
  final String? imgURL;

  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider<ProfileEditModel>(
      create: (_) => ProfileEditModel(username, rep, genre, imgURL),
      child: Scaffold(
        appBar: AppBar(
          title: Text('プロフィール編集'),
        ),
        body: Center(
          child: Consumer<ProfileEditModel>(builder: (context, model, child) {
            return Padding(
              padding: const EdgeInsets.all(16.0),
              child: Column(
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
                  TextField(
                    controller: model.usernameController,
                    decoration: InputDecoration(hintText: 'ユーザーネーム'),
                    onChanged: (text) {
                      model.setUserName(text);
                    },
                  ),
                  TextField(
                    controller: model.repController,
                    decoration: InputDecoration(hintText: 'レペゼン'),
                    onChanged: (text) {
                      model.setRep(text);
                    },
                  ),
                  TextField(
                    controller: model.genreController,
                    decoration: InputDecoration(hintText: 'ジャンル'),
                    onChanged: (text) {
                      model.setGenre(text);
                    },
                  ),
                  ElevatedButton(
                    onPressed: model.isUpdated()
                        ? () async {
                            try {
                              await model.updateProfile();
                              Navigator.of(context).pop();
                            } catch (e) {
                              final snackBar = SnackBar(
                                backgroundColor: Colors.black54,
                                content: Text(
                                  e.toString(),
                                ),
                              );
                              ScaffoldMessenger.of(context)
                                  .showSnackBar(snackBar);
                            }
                          }
                        : null,
                    child: const Text('更新する'),
                  )
                ],
              ),
            );
          }),
        ),
      ),
    );
  }
}
