import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:routy_app_v102/GetX/user.dart';
import 'package:routy_app_v102/screens/map.dart';
import 'package:routy_app_v102/screens/wrapper.dart';
import 'package:routy_app_v102/widgets/background_painter.dart';
import 'package:routy_app_v102/widgets/hidden_drawer_menu.dart';
import 'package:routy_app_v102/widgets/menu_widget.dart';

class LoggedIn extends StatefulWidget {
  LoggedIn({Key key}) : super(key: key);

  @override
  _LoggedInState createState() => _LoggedInState();
}


class _LoggedInState extends State<LoggedIn> {
  final GlobalKey<ScaffoldState> _scaffoldKey = new GlobalKey<ScaffoldState>();
    

  @override
  initState() {
    
    super.initState();
    print("en loogedIn");
  }


  @override
  Widget build(BuildContext context) {
    final UserX userx = Get.find();
    return Scaffold(
      key: _scaffoldKey,
      drawer: DrawerMenu(),
      body: Stack(
        children: [

        Container(
      alignment: Alignment.center,
      color: Colors.blueGrey.shade900,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.center,
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Text(
            'Logged In',
            style: myStyle(),
          ),
          SizedBox(height: 8),
          CircleAvatar(
            maxRadius: 60,
            backgroundImage: NetworkImage(userx.myUser.image),
          ),
          SizedBox(height: 8),
          Text(
            'Name: ' + userx.myUser.fullName,
            style: myStyle(),
          ),
          SizedBox(height: 8),
          Text(
            'Email: ' + userx.myUser.email,
            style: myStyle(),
          ),
          SizedBox(height: 8),
          Text(
            'Fecha de creación: ' + userx.myUser.createdAt.toDate().toString(),
            style: myStyle(),
          ),
          SizedBox(height: 8),
          ElevatedButton(
            onPressed: () {
              Navigator.push(context,MaterialPageRoute(builder: (context) => MyMap()),);
              
            },
            child: Text('Ir a Mapa'),
          ),
          SizedBox(height: 8),
          ElevatedButton(
            onPressed: () {
                      userx.logOut();
                      Navigator.pushAndRemoveUntil(context, MaterialPageRoute(builder: (context)=> Wrapper()), (route) => route.isFirst);
                      },
            child: Text('Logout', style: myStyle(),),),

        ],
      ),
    ),

        Menu(_scaffoldKey), //este es el menu que abre el drawer

        ],
      )
    );

  }
}
    TextStyle myStyle(){
      return TextStyle(color: Colors.white, fontSize: 14);
    }
    Widget buildLoading() => Stack(
        fit: StackFit.expand,
        children: [
          CustomPaint(painter: BackgroundPainter()),
          Center(child: CircularProgressIndicator()),
        ],
      );