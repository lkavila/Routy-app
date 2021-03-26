import 'package:flutter/material.dart';
import 'package:routy_app_v102/provider/sign_in.dart';
import 'package:routy_app_v102/screens/wrapper.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';

class DrawerMenu extends StatelessWidget {
  final SignInProvider provider;
  const DrawerMenu(this.provider, {Key key}) : super(key: key);

  TextStyle myStyle(){
      return TextStyle(color: Colors.white, fontSize: 18);
  }
  @override
  Widget build(BuildContext context) {

    return Drawer(
        child: Container(
          width: 100,
          color: Colors.blue[700],
          child: ListView(
          children: <Widget>[
          UserAccountsDrawerHeader(
              accountName: Text("${provider.myUser.fullName}"),
              accountEmail: Text("${provider.myUser.email}"),
              currentAccountPicture: CircleAvatar(backgroundImage: NetworkImage(provider.myUser.image),),
              decoration: BoxDecoration(
                color: Colors.red,
              ),
            ),
            
            ListTile(
              title: Text('Inicio',style: myStyle(),),
              leading: FaIcon(FontAwesomeIcons.mapMarkedAlt,color: Colors.white), 
            ),
            ListTile(
              title: Text('Perfil',style: myStyle(),),
              leading: FaIcon(FontAwesomeIcons.user, color: Colors.white), 
            ),
            ListTile(
              title: Text('Mis rutas',style: myStyle(),),
              leading: FaIcon(FontAwesomeIcons.route, color: Colors.white), 
            ),
            ListTile(
              title: Text('Mis vehículos', style: myStyle(),),
              leading: FaIcon(FontAwesomeIcons.car, color: Colors.white,), 
            ),
            ListTile(
              title: Text('Configuración',style: myStyle(),),
              leading: Icon(Icons.settings, color: Colors.white),
            ),
            ListTile(
              title: Text('Cerrar sesión',style: myStyle(),),
              leading: Icon(Icons.logout, color: Colors.white),
              onTap: (){
                      provider.logOut();
                      Navigator.pushAndRemoveUntil(context, MaterialPageRoute(builder: (context)=> Wrapper()), (route) => route.isFirst);
              },
            ),
          ],
        ),
        ),

    );


  }
}