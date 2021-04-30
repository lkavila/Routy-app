import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:routy_app_v102/Presentation/GetX/user_controller.dart';
import 'package:routy_app_v102/Presentation/pages/home/misRutas.dart';
import 'package:routy_app_v102/Presentation/pages/authenticate/sign_up_widget.dart';
import 'package:routy_app_v102/Presentation/widgets/loading_widget.dart';

class Wrapper extends StatelessWidget {
  final scaffoldKey = GlobalKey<ScaffoldState>();

  @override
  Widget build(BuildContext context) {
  final userController = Get.put(UserController());
  return Scaffold(
        key: scaffoldKey,
        drawerEnableOpenDragGesture: true,
        resizeToAvoidBottomInset: false,
        body: GetBuilder<UserController>(builder: (_) { 
              if (userController.isSigningIn) {
                return buildLoading();
              } else if (FirebaseAuth.instance.currentUser!=null) {
                return GetBuilder<UserController>(
                        builder: (_) {
                          if(userController.user==null){
                            userController.getUser();
                            return buildLoading();
                          }else {
                              return MisRutas();
                              }
                            }
                          );
                      
              } else {
                return  SignUpWidget();
                }
            },
          ),
          );
        

  }
  Widget buildLoading() => Stack(
        fit: StackFit.expand,
        children: [
          Center(child: Loading("Iniciando sesión...")),
        ],
      );

  
}