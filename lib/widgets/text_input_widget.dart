import 'package:flutter/material.dart';

class MyTextInput extends StatelessWidget {
  final TextEditingController controller;
  final String validator;
  final String labelText, hintText;
  final bool obscure;
  //static String value;
  const MyTextInput(this.controller, this.hintText, this.labelText,
      this.validator, this.obscure,
      {Key key})
      : super(key: key);

  String validacion(String value) {
    switch (validator) {
      case "emailValidator":
        return emailValidator(value);
        break;
      case "pwdValidator":
        return pwdValidator(value);
        break;
      case "nameValidator":
        return nameValidator(value);
        break;
      default:
    }
    return null;
  }

  String emailValidator(String value) {
    Pattern pattern =
        r'^(([^<>()[\]\\.,;:\s@\"]+(\.[^<>()[\]\\.,;:\s@\"]+)*)|(\".+\"))@((\[[0-9]{1,3}\.[0-9]{1,3}\.[0-9]{1,3}\.[0-9]{1,3}\])|(([a-zA-Z\-0-9]+\.)+[a-zA-Z]{2,}))$';
    RegExp regex = new RegExp(pattern);
    if (!regex.hasMatch(value)) {
      return 'Formato de email inválido';
    } else {
      return null;
    }
  }

  String pwdValidator(String value) {
    if (value.length < 8) {
      return 'La contraseña debe tener al menos 8 caracteres';
    } else {
      return null;
    }
  }

  String nameValidator(String value) {
    if (value.length < 3) {
      return 'El nombre debe tener al menos 3 caracteres';
    } else {
      return null;
    }
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      child: Padding(
        padding: EdgeInsets.fromLTRB(0, 5, 0, 10),
        child: TextFormField(
            obscureText: obscure,
            decoration: InputDecoration(
              filled: false,
              border: new OutlineInputBorder(
                borderRadius: const BorderRadius.all(
                  const Radius.circular(15.0),
                ),
                borderSide: new BorderSide(
                  color: Colors.blue,
                  width: 2.0,
                ),
              ),
              labelText: labelText,
              hintText: hintText,
              contentPadding: EdgeInsets.fromLTRB(10, 10, 10, 10),
            ),
            controller: controller,
            style: TextStyle(color: Colors.blue[900]),
            validator: validacion),
      ),
    );
  }
}
