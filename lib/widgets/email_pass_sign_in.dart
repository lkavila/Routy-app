import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:routy_app_v102/provider/sign_in.dart';

class EmailPassSignIn extends StatelessWidget {
  final emailInputController = new TextEditingController();
  final pwdInputController = new TextEditingController();

  @override
  Widget build(BuildContext context) => Container(
      width: 270.0,
      height: 250.0,
      padding: EdgeInsets.all(4),
      child: Column(
          mainAxisAlignment: MainAxisAlignment.spaceAround,
          children: ([
            TextField(
              keyboardType: TextInputType.emailAddress,
              obscureText: false,
              controller: emailInputController,
              decoration: InputDecoration(
                border: OutlineInputBorder(),
                labelText: 'Email',
              ),
            ),
            TextField(
              obscureText: true,
              controller: pwdInputController,
              decoration: InputDecoration(
                border: OutlineInputBorder(),
                labelText: 'Password',
              ),
            ),
            Align(
              alignment: Alignment.topRight,
              child: Text("¿Olvidaste tu contraseña?",
                  style: TextStyle(color: Colors.blue[700])),
            ),
            Builder(
                // Here the magic happens
                // this builder function will generate a new BuilContext for you
                builder: (BuildContext newContext) {
              return ElevatedButton(
                child: Text("Iniciar sesión",
                    style: TextStyle(fontFamily: "Roboto")),
                style: ElevatedButton.styleFrom(
                    primary: Colors.blue[700],
                    elevation: 5,
                    shadowColor: Colors.black),
                onPressed: () {
                  final provider =
                      Provider.of<SignInProvider>(newContext, listen: false);
                  provider.loginWithEmail(
                      emailInputController.text, pwdInputController.text);
                },
              );
            }),
          ])));
}
