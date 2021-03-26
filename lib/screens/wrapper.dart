import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:routy_app_v102/models/user.dart';
import 'package:routy_app_v102/provider/sign_in.dart';
import 'package:routy_app_v102/screens/home/logged_in.dart';
import 'package:routy_app_v102/screens/home/misRutas.dart';
import 'package:routy_app_v102/widgets/background_painter.dart';
import 'package:routy_app_v102/screens/authenticate/sign_up_widget.dart';
import 'package:provider/provider.dart';
import 'package:routy_app_v102/widgets/hidden_drawer_menu.dart';

class Wrapper extends StatelessWidget {
  final GlobalKey<ScaffoldState> _scaffoldKey = new GlobalKey<ScaffoldState>();
  @override
  Widget build(BuildContext context) {
 
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
                if(provider.myUser==null){
                  getActiveUser(provider);
                  return buildLoading();

                }else  if (provider.myUser!=null){
                    return MisRutas(provider);
                }
              } else {
                return  SignUpWidget();
                }
              return SignUpWidget();
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

   Future<MyUser> getActiveUser(SignInProvider provider) async{
      return await provider.getUser();
    }
  
}