import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:routy_app_v102/Presentation/GetX/route_controller.dart';
import 'package:routy_app_v102/Presentation/GetX/user_controller.dart';
import 'package:routy_app_v102/Presentation/pages/wrapper.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:routy_app_v102/Presentation/widgets/logo_widget.dart';

class DrawerMenu extends StatelessWidget {
  const DrawerMenu({Key key}) : super(key: key);
  
  TextStyle myStyle(){
      return TextStyle(color: Colors.white, fontSize: 15);
  }
  @override
  Widget build(BuildContext context) {
    final UserController uc = Get.find();
    final RouteController rutax = Get.find();
    return Container(
        width: MediaQuery.of(context).size.width * 0.7, // 75% of screen will be occupied
        
        child: Drawer(
          child: Container(
            color: Colors.indigo[800],
            child: ListView(
            children: <Widget>[
              Align(
                alignment: Alignment.center,
                child:             UserAccountsDrawerHeader(
                accountName: Text("${uc.user.fullName}"),
                accountEmail: Text("${uc.user.email}"),
                currentAccountPicture: CircleAvatar(backgroundImage: NetworkImage(uc.user.image),),
                decoration: BoxDecoration(
                  color: Colors.indigo[900],
                ),
              ),
              ),

              
              ListTile(
                title: Text('Inicio',style: myStyle(),),
                leading: FaIcon(FontAwesomeIcons.mapMarkedAlt,color: Colors.white), 
                onTap: (){
                  Navigator.pushNamed(context, '/map');
                },
              ),
              ListTile(
                title: Text('Perfil',style: myStyle(),),
                leading: FaIcon(FontAwesomeIcons.user, color: Colors.white), 
                onTap: (){
                  Navigator.pushNamed(context, '/logged_in');
                },
              ),
              ListTile(
                title: Text('Mis rutas',style: myStyle(),),
                leading: FaIcon(FontAwesomeIcons.route, color: Colors.white), 
                onTap: (){
                  Navigator.pushNamed(context, '/misRutas');
                },
              ),
              
              ListTile(
                title: Text('Mis vehículos', style: myStyle(),),
                leading: FaIcon(FontAwesomeIcons.car, color: Colors.white,), 
                onTap: (){
                  Navigator.pushNamed(context, '/misVehiculos');
                },
              ),
              ListTile(
                title: Text('Configuración',style: myStyle(),),
                leading: Icon(Icons.settings, color: Colors.white),
              ),

              ListTile(
                title: Text('Cerrar sesión',style: myStyle(),),
                leading: Icon(Icons.logout, color: Colors.white),
                onTap: ()async {
                        await uc.salir();
                        rutax.limpiar();
                        Navigator.pushAndRemoveUntil(context, MaterialPageRoute(builder: (context)=> Wrapper()), (route) => route.isFirst);
                },

              ),
              SizedBox(
                height: MediaQuery.of(context).size.width * 0.06,
              ),
              Align(
                alignment: Alignment.bottomCenter,
                child:  Container(
                  width: 130,
                  decoration: BoxDecoration(
                    color: Colors.white,
                    borderRadius: BorderRadius.all(
                        Radius.circular(100.0),
                    ),
                      ),
                  child: Logo(40),
                ),
              ),
            ],
          ),
        ),
        ),
    );


  }
}