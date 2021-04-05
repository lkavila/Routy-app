import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:routy_app_v102/provider/sign_in.dart';
import 'package:routy_app_v102/widgets/logo_widget.dart';
import 'package:routy_app_v102/widgets/text_input_widget.dart';

class RegisterPage extends StatefulWidget {
  final SignInProvider provider;
  RegisterPage(this.provider, {Key key}) : super(key: key);

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

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        body: Container(
            padding: const EdgeInsets.fromLTRB(20.0, 20, 20.0, 0),
            child: SingleChildScrollView(
                child: Form(
              key: _registerFormKey,
              child: Column(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: <Widget>[
                  Logo(70),
                  SizedBox(
                    height: MediaQuery.of(context).size.height * 0.01,
                  ),
                  Text(
                    "Registro",
                    style: TextStyle(
                        fontSize: 20, color: Color.fromRGBO(12, 55, 106, 1)),
                  ),
                  SizedBox(
                    height: MediaQuery.of(context).size.height * 0.04,
                  ),
                  MyTextInput(firstNameInputController, "Eren Yeager", "Nombre",
                      "nameValidator", false),
                  MyTextInput(emailInputController, "eren.shingeki@gmail.com",
                      "Email", "emailValidator", false),
                  MyTextInput(pwdInputController, " ", "Contraseña",
                      "nameValidator", true),
                  SizedBox(
                    height: MediaQuery.of(context).size.height * 0.07,
                  ),
                  Container(
                    width: 150,
                    child: ElevatedButton(
                      child: Text("Registrar", style: TextStyle(fontSize: 18)),
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
                  SizedBox(
                    height: MediaQuery.of(context).size.height * 0.05,
                  ),
                  Text("¿Ya tienes una cuenta?", style: style()),
                  TextButton(
                    child: Text("Ingresa aquí!"),
                    onPressed: () {
                      Navigator.pop(context);
                    },
                  ),
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
