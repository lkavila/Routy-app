import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:routy_app_v102/provider/sign_in.dart';

class SignupButtonsWidget extends StatelessWidget {
  final SignInProvider provider;
  const SignupButtonsWidget(this.provider, {Key key}) : super(key: key);
  @override
  
  Widget build(BuildContext context){
     return Container(
        padding: EdgeInsets.all(4),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.spaceAround,
          children: ([
            ElevatedButton.icon(
              label: Text(
                'Iniciar sesión con Google',
                style: TextStyle(fontWeight: FontWeight.bold, fontSize: 15, color: Colors.white),
              ),
              icon: FaIcon(FontAwesomeIcons.google, color: Colors.white),
              style: ElevatedButton.styleFrom(primary: Colors.red, minimumSize: Size(265, 40), elevation: 4.0),
              onPressed: () {
                provider.loginWithGoogle();
              },
            ),
            ElevatedButton.icon(
              label: Text(
                'Iniciar sesión con Facebook',
                style: TextStyle(fontWeight: FontWeight.bold, fontSize: 15, color: Colors.white),
              ),
              icon: FaIcon(FontAwesomeIcons.facebook, color: Colors.white),
              style: ElevatedButton.styleFrom(primary: Colors.blue[900], minimumSize: Size(260, 40), elevation: 4.0),
              onPressed: () {
                provider.loginWithFacebook();
              },
            ),
          ])
        )

      );
  }
}