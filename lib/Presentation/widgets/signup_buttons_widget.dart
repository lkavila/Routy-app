import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:get/get.dart';
import 'package:routy_app_v102/Presentation/GetX/user_controller.dart';

class SignupButtonsWidget extends StatelessWidget {
  const SignupButtonsWidget({Key key}) : super(key: key);
  @override
  
  Widget build(BuildContext context){
    final UserController uc = Get.find();
     return Container(
        padding: EdgeInsets.all(4),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.spaceAround,
          children: ([
            ElevatedButton.icon(
              key: Key("login_with_google"),
              label: Text(
                'Iniciar sesión con Google',
                style: TextStyle(fontWeight: FontWeight.bold, fontSize: 15, color: Colors.white),
              ),
              icon: FaIcon(FontAwesomeIcons.google, color: Colors.white),
              style: ElevatedButton.styleFrom(primary: Colors.red, minimumSize: Size(265, 40), elevation: 4.0),
              onPressed: () {
                uc.loginWithGoogle();
              },
            ),
            ElevatedButton.icon(
              key: Key("login_with_facebook"),
              label: Text(
                'Iniciar sesión con Facebook',
                style: TextStyle(fontWeight: FontWeight.bold, fontSize: 15, color: Colors.white),
              ),
              icon: FaIcon(FontAwesomeIcons.facebook, color: Colors.white),
              style: ElevatedButton.styleFrom(primary: Colors.blue[900], minimumSize: Size(260, 40), elevation: 4.0),
              onPressed: () {
                uc.loginWithFacebook();
              },
            ),
          ])
        )

      );
  }
}