import 'package:flutter/material.dart';
import 'package:routy_app_v102/provider/sign_in.dart';
import 'package:routy_app_v102/screens/map.dart';
import 'package:routy_app_v102/screens/wrapper.dart';
import 'package:routy_app_v102/widgets/background_painter.dart';
import 'package:routy_app_v102/widgets/hidden_drawer_menu.dart';

class LoggedIn extends StatefulWidget {
  final SignInProvider provider;
  LoggedIn(this.provider, {Key key}) : super(key: key);

  @override
  _LoggedInState createState() => _LoggedInState();
}


class _LoggedInState extends State<LoggedIn> {
  final GlobalKey<ScaffoldState> _scaffoldKey = new GlobalKey<ScaffoldState>();
    

  @override
  initState() {
    
    super.initState();
    print("en loogedIn");
    print(widget.provider.myUser.toJson());
  }


  @override
  Widget build(BuildContext context) {
    return Scaffold(
      key: _scaffoldKey,
      drawer: DrawerMenu(widget.provider),
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
            maxRadius: 75,
            backgroundImage: NetworkImage(widget.provider.myUser.image),
          ),
          SizedBox(height: 8),
          Text(
            'Name: ' + widget.provider.myUser.fullName,
            style: myStyle(),
          ),
          SizedBox(height: 8),
          Text(
            'Email: ' + widget.provider.myUser.email,
            style: myStyle(),
          ),
          SizedBox(height: 8),
          Text(
            'Fecha de creación: ' + widget.provider.myUser.createdAt.toDate().toString(),
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
                      widget.provider.logOut();
                      Navigator.pushAndRemoveUntil(context, MaterialPageRoute(builder: (context)=> Wrapper()), (route) => route.isFirst);
                      },
            child: Text('Logout', style: myStyle(),),),

        ],
      ),
    ),
    Padding(
      padding: EdgeInsets.fromLTRB(0, 40.0, 0, 0.0),
      child:  Container(
          
          width: 49.0,
          height: 48.0,
            decoration: BoxDecoration(
              borderRadius: BorderRadius.all(
                  Radius.circular(10.0),
              ),
                image: DecorationImage(
                  image: AssetImage('assets/images/menuIcon.PNG'),
                )
                ),
                
            child: Column(
              children: [
                IconButton(
                icon: const Icon(Icons.menu, color: Colors.transparent,),
                onPressed: () => _scaffoldKey.currentState.openDrawer(),
              ),
              ],
            ),
        ),
      ),
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