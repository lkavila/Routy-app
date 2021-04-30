import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:routy_app_v102/Presentation/GetX/user_controller.dart';
import 'package:routy_app_v102/Presentation/pages/map.dart';
import 'package:routy_app_v102/Presentation/pages/wrapper.dart';
import 'package:routy_app_v102/Presentation/widgets/background_painter.dart';
import 'package:routy_app_v102/Presentation/widgets/hidden_drawer_menu.dart';
import 'package:routy_app_v102/Presentation/widgets/menu_widget.dart';

class LoggedIn extends StatefulWidget {
  LoggedIn({Key key}) : super(key: key);

  @override
  _LoggedInState createState() => _LoggedInState();
}


class _LoggedInState extends State<LoggedIn> {
  final _scaffoldKey = GlobalKey<ScaffoldState>();
    

  @override
  initState() {
    
    super.initState();
    print("en loogedIn");
  }


  @override
  Widget build(BuildContext context) {
    final UserController uc = Get.find();
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
            backgroundImage: NetworkImage(uc.user.image),
          ),
          SizedBox(height: 8),
          Text(
            'Name: ' + uc.user.fullName,
            style: myStyle(),
          ),
          SizedBox(height: 8),
          Text(
            'Email: ' + uc.user.email,
            style: myStyle(),
          ),
          SizedBox(height: 8),
          Text(
            'Fecha de creación: ' + uc.user.createdAt.toDate().toString(),
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
            onPressed: () async{
                      
                      await uc.logOut();
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