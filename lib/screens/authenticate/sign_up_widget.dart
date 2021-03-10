import 'package:flutter/material.dart';
import 'package:routy_app_v102/widget/signup_buttons_widget.dart';

class SignUpWidget extends StatelessWidget {

 final List<Color> _colors = [Colors.white, Colors.blue];
 final List<double> _stops = [0.4, 0.9];

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
          buildSignUp(),
        ],
      );
  }
  Widget buildSignUp() => Column(
        children: [
          Spacer(),
          Align(
            alignment: Alignment.center,
            child: Container(
              margin: EdgeInsets.symmetric(horizontal: 20),
              width: 190,
              child: Text(
                'Routy',
                style: TextStyle(
                  color: Colors.blue,
                  fontSize: 70,
                  fontWeight: FontWeight.normal,
                  fontFamily: 'Pacifico'
                ),
              ),
            ),
          ),
          Spacer(),
          SignupButtonsWidget(),
          SizedBox(height: 12),
          Text(
            'Login to continue',
            style: TextStyle(fontSize: 16),
          ),
          Spacer(),
        ],
      );
}
