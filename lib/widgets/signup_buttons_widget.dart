import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:routy_app_v102/provider/sign_in.dart';
import 'package:provider/provider.dart';

class SignupButtonsWidget extends StatelessWidget {
  @override
  Widget build(BuildContext context) => Container(
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
                final provider = Provider.of<SignInProvider>(context, listen: false);
                provider.loginWithGoogle();
              },
            ),
            ElevatedButton.icon(
              label: Text(
                'Iniciar sesión con Facebook',
                style: TextStyle(fontWeight: FontWeight.bold, fontSize: 15, color: Colors.white),
              ),
              icon: FaIcon(FontAwesomeIcons.facebook, color: Colors.white),
              style: ElevatedButton.styleFrom(primary: Colors.blue[700], minimumSize: Size(260, 40), elevation: 4.0),
              onPressed: () {
                final provider = Provider.of<SignInProvider>(context, listen: false);
                provider.loginWithFacebook();
              },
            ),
          ])
        )

      );
}
