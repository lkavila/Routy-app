import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:routy_app_v102/provider/sign_in.dart';
import 'package:routy_app_v102/screens/authenticate/email_sign_up.dart';

class EmailPassSignIn extends StatelessWidget {

  final  emailInputController = new TextEditingController();
  final  pwdInputController = new TextEditingController();


  @override
  Widget build(BuildContext context) => Container(
        width: 270.0,
        height: 210.0,
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
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceAround,
              children: [
              Builder(
                // Here the magic happens
                // this builder function will generate a new BuilContext for you
                builder: (BuildContext newContext){
                  return TextButton(
                    child: Text("Iniciar sesión", style: TextStyle(color: Colors.blue, fontFamily: "Roboto")),
                    onPressed: () {
                    final provider =  Provider.of<SignInProvider>(newContext, listen: false);
                      provider.loginWithEmail(emailInputController.text, pwdInputController.text);
                        },
                      );
                    }
                  ),
                Text("ó"),
                TextButton(
                      onPressed:  (){ Navigator.push(context,
                                MaterialPageRoute(builder: (context) => RegisterPage()),
                              );
                          },
                        child: Text("Registrate", style: TextStyle(color: Colors.blue, fontFamily: "Roboto")),
                      ),
                
              ],
            )


          ]
        )
        )
      );
}