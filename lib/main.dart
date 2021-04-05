import 'package:flutter/material.dart';
import 'package:routy_app_v102/screens/home/crearVehiculo.dart';
import 'package:routy_app_v102/screens/home/logged_in.dart';
import 'package:routy_app_v102/screens/home/misRutas.dart';
import 'package:routy_app_v102/screens/home/misVehiculos.dart';
import 'package:routy_app_v102/screens/map.dart';
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
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        primaryColor: Colors.blue[900],
        buttonColor: Colors.blue[900],
        primaryColorDark: Colors.grey,
        primarySwatch: Colors.blue,
        accentColor: Colors.orange,
        fontFamily: "OpenSans",
      ),
      initialRoute: "/wrapper",
      routes: {
        "/wrapper": (context) => Wrapper(),
        "/misRutas": (context) => MisRutas(),
        "/logged_in": (context) => LoggedIn(),
        "/misVehiculos": (context) => MisVehiculos(),
        "/crearVehiculo": (context) => CrearVehiculo(),
        "/map": (context) => MyMap(),
      },
    );
  }
}
