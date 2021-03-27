import 'package:flutter/material.dart';
import 'package:routy_app_v102/screens/authenticate/email_sign_up.dart';
import 'package:routy_app_v102/widgets/email_pass_sign_in.dart';
import 'package:routy_app_v102/widgets/logo_widget.dart';
import 'package:routy_app_v102/widgets/signup_buttons_widget.dart';

class SignUpWidget extends StatelessWidget {

 final List<Color> _colors = [Colors.white, Colors.blue];
 final List<double> _stops = [0.96, 0.04];

  @override
  Widget build(BuildContext context) {
    return Stack(
        fit: StackFit.expand,
        children: [
          Container(
          decoration: BoxDecoration(
              gradient: LinearGradient(
                begin: Alignment.topLeft,
                end: Alignment.bottomRight,
                colors: _colors,
                stops: _stops,
              )
          ),            
          ),
          buildSignUp(context),
        ],
      );
  }
  Widget buildSignUp(BuildContext context) => Column(
        children: [
          
          Logo(90),

          SizedBox(height: 10),

          EmailPassSignIn(),

          Text("ó"),
          SizedBox(height: 10),
          SignupButtonsWidget(),
          
          SizedBox(height: 10),
          TextButton(
             onPressed:  (){ Navigator.push(context,
                                MaterialPageRoute(builder: (context) => RegisterPage()),
                              );
                          },
                        child: Text("¿No tienes cuenta? Registrate aquí", style: TextStyle(color: Colors.blue[700])),
                      ),
          Spacer(),
        ],
      );
}
