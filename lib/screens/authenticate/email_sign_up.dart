import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:routy_app_v102/provider/sign_in.dart';
import 'package:routy_app_v102/widgets/logo_widget.dart';
import 'package:routy_app_v102/widgets/signup_buttons_widget.dart';

class RegisterPage extends StatefulWidget {
  RegisterPage({Key key}) : super(key: key);

  @override
  _RegisterPageState createState() => _RegisterPageState();
}

class _RegisterPageState extends State<RegisterPage> {
  final GlobalKey<FormState> _registerFormKey = GlobalKey<FormState>();
  TextEditingController firstNameInputController;
  TextEditingController emailInputController;
  TextEditingController pwdInputController;
  final String defualtUrlImage =
      "https://firebasestorage.googleapis.com/v0/b/approute40-movil.appspot.com/o/users_images%2Fdefault.png?alt=media&token=bbeb9f9d-638f-4b89-ac89-e47c10de8382";

  @override
  initState() {
    firstNameInputController = new TextEditingController();
    emailInputController = new TextEditingController();
    pwdInputController = new TextEditingController();
    super.initState();
  }

  String emailValidator(String value) {
    Pattern pattern =
        r'^(([^<>()[\]\\.,;:\s@\"]+(\.[^<>()[\]\\.,;:\s@\"]+)*)|(\".+\"))@((\[[0-9]{1,3}\.[0-9]{1,3}\.[0-9]{1,3}\.[0-9]{1,3}\])|(([a-zA-Z\-0-9]+\.)+[a-zA-Z]{2,}))$';
    RegExp regex = new RegExp(pattern);
    if (!regex.hasMatch(value)) {
      return 'Email format is invalid';
    } else {
      return null;
    }
  }

  String pwdValidator(String value) {
    if (value.length < 8) {
      return 'Password must be longer than 8 characters';
    } else {
      return null;
    }
  }

  String nameValidator(String value) {
    if (value.length < 3) {
      return 'Name must be longer than 3 characters';
    } else {
      return null;
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        body: Container(
            padding: const EdgeInsets.fromLTRB(20.0, 9, 20.0, 0),
            child: SingleChildScrollView(
                child: Form(
              key: _registerFormKey,
              child: Column(
                children: <Widget>[
                  Logo(70),
                  Text(
                    "Registro",
                    style: TextStyle(
                        fontSize: 25, color: Color.fromRGBO(12, 55, 106, 1)),
                  ),
                  TextFormField(
                      decoration: InputDecoration(
                          enabledBorder: OutlineInputBorder(
                            borderSide: BorderSide(color: Colors.blue[900]),
                          ),
                          focusedBorder: OutlineInputBorder(
                            borderSide: BorderSide(color: Colors.blue[900]),
                          ),
                          border: OutlineInputBorder(
                              borderRadius: new BorderRadius.circular(10)),
                          labelText: 'Nombre',
                          hintText: "John"),
                      controller: firstNameInputController,
                      validator: nameValidator),
                  TextFormField(
                    decoration: InputDecoration(
                        labelText: 'Email', hintText: "john.doe@gmail.com"),
                    controller: emailInputController,
                    keyboardType: TextInputType.emailAddress,
                    validator: emailValidator,
                  ),
                  TextFormField(
                    decoration: InputDecoration(
                        labelText: 'Contraseña', hintText: "********"),
                    controller: pwdInputController,
                    obscureText: true,
                    validator: pwdValidator,
                  ),
                  SizedBox(
                    height: MediaQuery.of(context).size.height * 0.05,
                  ),
                  Container(
                    width: 150,
                    child: Expanded(
                      flex: 1,
                      child: ElevatedButton(
                        child:
                            Text("Registrar", style: TextStyle(fontSize: 18)),
                        onPressed: () {
                          if (_registerFormKey.currentState.validate()) {
                            SignInProvider provider = SignInProvider();
                            provider.createAccount(
                                emailInputController.text,
                                pwdInputController.text,
                                defualtUrlImage,
                                Timestamp.now(),
                                firstNameInputController.text);
                            Navigator.pop(context);
                          }
                        },
                        style: ButtonStyle(
                            backgroundColor: MaterialStateProperty.resolveWith(
                                (states) => Colors.blue[900]),
                            elevation: MaterialStateProperty.resolveWith(
                                (states) => 10)),
                      ),
                    ),
                  ),
                  Text("¿Ya tienes una cuenta?", style: style()),
                  TextButton(
                    child: Text("Ingresa aquí!"),
                    onPressed: () {
                      Navigator.pop(context);
                    },
                  ),
                  Text(
                    "ó",
                    style: style(),
                  ),
                  SignupButtonsWidget()
                ],
              ),
            ))));
  }

  TextStyle style() {
    return TextStyle(
        color: Color.fromRGBO(12, 55, 106, 1),
        fontSize: 14,
        fontWeight: FontWeight.normal);
  }
} // xelente :V
