import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:routy_app_v102/Presentation/GetX/user_controller.dart';
import 'package:routy_app_v102/Presentation/widgets/text_input_widget.dart';

class EmailPassSignIn extends StatelessWidget {
  final GlobalKey<FormState> _registerFormKey = GlobalKey<FormState>();
  final emailInputController = new TextEditingController();
  final pwdInputController = new TextEditingController();

  @override
  Widget build(BuildContext context) => Container(
      width: 300.0,
      height: 250.0,
      padding: EdgeInsets.all(4),
      child: Form(
          key: _registerFormKey,
          child: Column(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: <Widget>[
                MyTextInput(emailInputController, "eren.shingeki@gmail.com",
                    "Email", "emailValidator", false),
                MyTextInput(pwdInputController, " ", "Contraseña",
                    "pwdValidator", true),
                Align(
                  alignment: Alignment.topRight,
                  child: Text("¿Olvidaste tu contraseña?",
                      style: TextStyle(color: Colors.blue[900])),
                ),
                ElevatedButton(
                  child: Text(
                    "Iniciar sesión",
                  ),
                  style: ElevatedButton.styleFrom(
                      primary: Colors.blue[900],
                      elevation: 5,
                      shadowColor: Colors.black),
                  onPressed: () {
                    if (_registerFormKey.currentState.validate()) {
                      final UserController uc = Get.find();
                      uc.loginWithEmail(
                          emailInputController.text, pwdInputController.text);
                    }
                  },
                ),
              ])));
}
