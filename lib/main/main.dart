import 'package:flutter/material.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:plantapp2/register/register_page.dart';
import '../rootpage.dart';
import 'package:plantapp2/login/login_page.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(initialRoute: '/', routes: <String, WidgetBuilder>{
      '/': (_) => LoginPage(),
      // '/': (_) => RootPage(),
    });
  }
}
