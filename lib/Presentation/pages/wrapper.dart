import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:routy_app_v102/Presentation/GetX/user.dart';
import 'package:routy_app_v102/Presentation/provider/sign_in.dart';
import 'package:routy_app_v102/Presentation/pages/home/misRutas.dart';
import 'package:routy_app_v102/Presentation/widgets/background_painter.dart';
import 'package:routy_app_v102/Presentation/pages/authenticate/sign_up_widget.dart';
import 'package:provider/provider.dart';

class Wrapper extends StatelessWidget {
  final GlobalKey<ScaffoldState> _scaffoldKey = new GlobalKey<ScaffoldState>();

  @override
  Widget build(BuildContext context) {
  final userX = Get.put(UserX());
  return Scaffold(
        key: _scaffoldKey,
        drawerEnableOpenDragGesture: true,
        resizeToAvoidBottomInset: false,
        body: ChangeNotifierProvider(
          create: (context) => SignInProvider(),
          child: Builder(
            builder: (context) {
               final provider = Provider.of<SignInProvider>(context);

              if (provider.isSigningIn) {
                print("hola11111111");
                return buildLoading();
              } else if (FirebaseAuth.instance.currentUser!=null) {
                print("hola22222222222");
                userX.facebookSignIn = provider.facebookSignIn;
                userX.googleSignIn = provider.googleSignIn;
                userX.signinWith = provider.signinWith;
                return GetBuilder<UserX>(
                        builder: (_) { 
                          print("??????????????");
                          if(userX.myUser==null){
                            print("hola33333333333");
                            userX.getUser();
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
        ),

      );
  }
  Widget buildLoading() => Stack(
        fit: StackFit.expand,
        children: [
          CustomPaint(painter: BackgroundPainter()),
          Center(child: CircularProgressIndicator()),
        ],
      );

  
}