import 'package:flutter/material.dart';
import 'package:routy_app_v102/screens/wrapper.dart';
import 'package:firebase_core/firebase_core.dart';

Future main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();

  runApp(MyApp());
}
class MyApp extends StatelessWidget {
  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      theme: ThemeData(
        primaryColor: Colors.blue,
        primaryColorDark: Colors.grey,
        primarySwatch: Colors.blue,
        accentColor: Colors.orange,
        fontFamily: 'Roboto'
      ),
      home: Wrapper(),
    );
  }
}

