import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get_storage/get_storage.dart';
import 'package:routy_app_v102/Presentation/pages/wrapper.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter_config/flutter_config.dart';

Future main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();
  await GetStorage.init();
  await FlutterConfig.loadEnvVariables();
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  // This widget is the root of your application.
  final appdata = GetStorage();
  @override
  Widget build(BuildContext context) {
    appdata.writeIfNull('darkmode', false);

    return SimpleBuilder(builder: (_) {
      bool isDarkMode = appdata.read('darkmode');
      return GetMaterialApp(
        debugShowCheckedModeBanner: false,
        theme: isDarkMode
            ? ThemeData(
                //brightness: Brightness.dark,
                appBarTheme: AppBarTheme(color: Colors.indigo[900]),
                fontFamily: "OpenSans",
                buttonColor: Colors.blue[900],
                dialogBackgroundColor: Color.fromRGBO(12, 55, 106, 0.95),
                scaffoldBackgroundColor: Colors.grey[850],
              )
            : ThemeData(
                brightness: Brightness.light,
                appBarTheme: AppBarTheme(color: Colors.blue),
                primaryColor: Colors.blue[500],
                buttonColor: Colors.blue[500],
                primaryColorLight: Colors.white,
                dialogBackgroundColor: Colors.blue[800],
                accentColor: Colors.blue[700],
                fontFamily: "OpenSans",
              ),
        home: Wrapper(),
      );
    });
  }
}
