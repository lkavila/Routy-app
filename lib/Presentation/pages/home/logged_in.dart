import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:routy_app_v102/Presentation/GetX/user_controller.dart';
import 'package:routy_app_v102/Presentation/pages/map.dart';
import 'package:routy_app_v102/Presentation/pages/wrapper.dart';
import 'package:routy_app_v102/Presentation/widgets/background_painter.dart';
import 'package:routy_app_v102/Presentation/widgets/hidden_drawer_menu.dart';
import 'package:routy_app_v102/Presentation/widgets/menu_widget.dart';

import 'misVehiculos.dart';

class LoggedIn extends StatefulWidget {
  LoggedIn({Key key}) : super(key: key);

  @override
  _LoggedInState createState() => _LoggedInState();
}

class _LoggedInState extends State<LoggedIn> {
  final GlobalKey<ScaffoldState> _scaffoldKey = new GlobalKey<ScaffoldState>();

  @override
  initState() {
    super.initState();
    print("en loogedIn");
  }

  @override
  Widget build(BuildContext context) {
    final UserController uc = Get.find();
    return Scaffold(
        drawer: DrawerMenu(),
        appBar: AppBar(
          title: Text(
            'Mi perfil',
            style: TextStyle(
              fontFamily: 'pacifico',
              fontSize: 20,
            ),
          ),
        ),
        key: _scaffoldKey,
        body: Stack(
          children: [
            Container(
              padding: EdgeInsets.fromLTRB(20, 60, 20, 30),
              alignment: Alignment.center,
              child: Column(
                  crossAxisAlignment: CrossAxisAlignment.center,
                  mainAxisAlignment: MainAxisAlignment.start,
                  children: [
                    Text(
                      uc.user.fullName,
                      style: TextStyle(
                        color: Colors.blue[700],
                        fontSize: 28,
                      ),
                    ),
                    SizedBox(height: 8),
                    CircleAvatar(
                      maxRadius: 60,
                      backgroundImage: NetworkImage(uc.user.image),
                    ),
                    SizedBox(height: 8),

                    SizedBox(height: 8),
                    Text(
                      uc.user.email,
                      style: myStyle(),
                    ),
                    SizedBox(height: 8),
                    //Text(
                    //'Fecha de creación: ' +
                    //  uc.user.createdAt.toDate().toString(),
                    //style: myStyle(),
                    //),
                    SizedBox(height: 8),
                    ElevatedButton(
                      onPressed: () {
                        Navigator.push(
                          context,
                          MaterialPageRoute(builder: (context) => MyMap()),
                        );
                      },
                      child: Text('Ir a Mapa'),
                    ),

                    SizedBox(height: 8),
                    ElevatedButton(
                      onPressed: () async {
                        await uc.logOut();
                        Navigator.pushAndRemoveUntil(
                            context,
                            MaterialPageRoute(
                                builder: (context) => MisVehiculos()),
                            (route) => route.isFirst);
                      },
                      child: Text(
                        'Vehiculos',
                        style: TextStyle(color: Colors.white, fontSize: 15),
                      ),
                    ),
                  ]),
            ),

            //Menu(_scaffoldKey), //este es el menu que abre el drawer
          ],
        ));
  }
}

TextStyle myStyle() {
  return TextStyle(color: Colors.blue[700], fontSize: 18);
}

Widget buildLoading() => Stack(
      fit: StackFit.expand,
      children: [
        CustomPaint(painter: BackgroundPainter()),
        Center(child: CircularProgressIndicator()),
      ],
    );
