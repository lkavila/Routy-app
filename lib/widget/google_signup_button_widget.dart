import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:routy_app_v102/provider/google_sign_in.dart';
import 'package:provider/provider.dart';

class GoogleSignupButtonWidget extends StatelessWidget {
  @override
  Widget build(BuildContext context) => Container(
        padding: EdgeInsets.all(4),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.spaceAround,
          children: ([
            ElevatedButton.icon(
              label: Text(
                'Sign In With Google',
                style: TextStyle(fontWeight: FontWeight.bold, fontSize: 20, color: Colors.white),
              ),
              icon: FaIcon(FontAwesomeIcons.google, color: Colors.white),
              style: ElevatedButton.styleFrom(primary: Colors.red, minimumSize: Size(260, 40)),
              onPressed: () {
                final provider =
                    Provider.of<GoogleSignInProvider>(context, listen: false);
                provider.login();
              },
            ),
            ElevatedButton.icon(
              label: Text(
                'Sign In With Facebook',
                style: TextStyle(fontWeight: FontWeight.bold, fontSize: 20, color: Colors.white),
              ),
              icon: FaIcon(FontAwesomeIcons.facebook, color: Colors.white),
              style: ElevatedButton.styleFrom(primary: Colors.blue, minimumSize: Size(260, 40)),
              onPressed: () {
                final provider =
                    Provider.of<GoogleSignInProvider>(context, listen: false);
                provider.login();
              },
            ),
          ])
        )

      );
}
