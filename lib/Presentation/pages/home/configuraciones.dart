import 'package:flutter/material.dart';
import 'package:flutter/cupertino.dart';
import 'package:get_storage/get_storage.dart';
import 'package:routy_app_v102/Presentation/widgets/hidden_drawer_menu.dart';

class Configuracion extends StatefulWidget {
  Configuracion({Key key}) : super(key: key);

  @override
  ConfiguracionState createState() => ConfiguracionState();
}

class ConfiguracionState extends State<Configuracion> {
  final appdata = GetStorage();
  @override
  Widget build(BuildContext context) {
    appdata.writeIfNull('darkmode', false);
    bool isDarkMode = appdata.read('darkmode');
    return Scaffold(
      appBar: AppBar(
        title: Text(
          'Configuraciones',
          style: TextStyle(
            fontFamily: 'pacifico',
            fontSize: 20,
          ),
        ),
      ),
      drawer: DrawerMenu(),
      body: ListView(children: [
        Container(
            padding: EdgeInsets.fromLTRB(20.0, 30.0, 20.0, 20.0),
            child: Column(
                mainAxisAlignment: MainAxisAlignment.spaceAround,
                children: [
                  Row(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      mainAxisAlignment: MainAxisAlignment.end,
                      children: [
                        Text(
                          'Configuraciones',
                          style: TextStyle(
                            color: Colors.blue[700],
                            fontFamily: 'pacifico',
                            fontSize: 25,
                          ),
                        ),
                        Expanded(
                          child: Image(
                            alignment: Alignment.center,
                            image:
                                AssetImage('assets/images/configuraciones.png'),
                            height: 60,
                          ),
                        ),
                      ]),
                  Row(
                      crossAxisAlignment: CrossAxisAlignment.center,
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Align(
                          alignment: Alignment.topLeft,
                          child: Text(
                            "Modo dark",
                            textAlign: TextAlign.left,
                            style: TextStyle(
                              fontSize: 15,
                              color: Colors.blue[700],
                            ),
                          ),
                        ),
                        Switch(
                          value: isDarkMode,
                          onChanged: (value) =>
                              appdata.write('darkmode', value),
                          activeTrackColor: Colors.blue,
                          activeColor: Colors.blue[700],
                        )
                      ]),
                  Row(
                      crossAxisAlignment: CrossAxisAlignment.center,
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Align(
                          alignment: Alignment.topLeft,
                          child: Text(
                            "Cambiar contraseña",
                            textAlign: TextAlign.left,
                            style: TextStyle(
                              fontSize: 15,
                              color: Colors.blue[700],
                            ),
                          ),
                        ),
                        Expanded(
                          child: Image(
                            alignment: Alignment.centerRight,
                            image: AssetImage('assets/images/password.png'),
                            height: 40,
                          ),
                        ),
                      ]),
                ]))
      ]),
    );
  }
}
