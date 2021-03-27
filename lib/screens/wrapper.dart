import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:routy_app_v102/GetX/user.dart';
import 'package:routy_app_v102/provider/sign_in.dart';
import 'package:routy_app_v102/screens/home/misRutas.dart';
import 'package:routy_app_v102/widgets/background_painter.dart';
import 'package:routy_app_v102/screens/authenticate/sign_up_widget.dart';
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
          child: StreamBuilder(
            stream: FirebaseAuth.instance.authStateChanges(),
            builder: (context, snapshot) {
               final provider = Provider.of<SignInProvider>(context);


              if (provider.isSigningIn) {
                return buildLoading();
              } else if (snapshot.hasData) {

                userX.facebookSignIn = provider.facebookSignIn;
                userX.googleSignIn = provider.googleSignIn;
                userX.signinWith = provider.signinWith;

                return GetBuilder<UserX>(
                        builder: (_) { 
                          if(userX.myUser==null){
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