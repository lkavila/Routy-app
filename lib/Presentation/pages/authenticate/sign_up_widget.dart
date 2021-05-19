import 'package:flutter/material.dart';
import 'package:routy_app_v102/Presentation/pages/authenticate/email_sign_up.dart';
import 'package:routy_app_v102/Presentation/widgets/email_pass_sign_in.dart';
import 'package:routy_app_v102/Presentation/widgets/logo_widget.dart';
import 'package:routy_app_v102/Presentation/widgets/signup_buttons_widget.dart';

class SignUpWidget extends StatelessWidget {

 final List<Color> _colors = [Colors.white, Colors.blue];
 final List<double> _stops = [0.96, 0.04];

  @override
  Widget build(BuildContext context) {
    
    return Stack(
        fit: StackFit.expand,
        children: [
          Container(
            key: Key("login"),
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
          SizedBox(height: 20),

          Logo(85),

          SizedBox(height: 5),

          EmailPassSignIn(),

          Text("ó"),
          SizedBox(height: 5),
          SignupButtonsWidget(),
          
          SizedBox(height: 5),
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
