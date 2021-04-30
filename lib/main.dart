import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get_storage/get_storage.dart';
import 'package:routy_app_v102/Presentation/pages/home/crearVehiculo.dart';
import 'package:routy_app_v102/Presentation/pages/home/logged_in.dart';
import 'package:routy_app_v102/Presentation/pages/home/misRutas.dart';
import 'package:routy_app_v102/Presentation/pages/home/misVehiculos.dart';
import 'package:routy_app_v102/Presentation/pages/map.dart';
import 'package:routy_app_v102/Presentation/pages/wrapper.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter_config/flutter_config.dart';

import 'Presentation/pages/home/configuraciones.dart';

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
            ? ThemeData.dark(
              
            )
            : ThemeData.light(
                //primaryColor: Colors.blue[900],
                //buttonColor: Colors.blue[900],
                //primaryColorDark: Colors.grey,
                //primarySwatch: Colors.blue,
                //accentColor: Colors.blue,
                //fontFamily: "OpenSans",
                ),
        initialRoute: "/wrapper",
        routes: {
          "/wrapper": (context) => Wrapper(),
          "/misRutas": (context) => MisRutas(),
          "/logged_in": (context) => LoggedIn(),
          "/misVehiculos": (context) => MisVehiculos(),
          "/crearVehiculo": (context) => CrearVehiculo(),
          "/map": (context) => MyMap(),
          "/configuraciones": (context) => Configuracion(),
        },
      );
    });
  }
}
