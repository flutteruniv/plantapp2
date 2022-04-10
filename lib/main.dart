import 'package:flutter/material.dart';
import 'package:firebase_core/firebase_core.dart';
import 'rootpage.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(initialRoute: '/', routes: <String, WidgetBuilder>{
      '/': (_) => RootPage(),
    });
  }
}
