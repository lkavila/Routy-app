import 'package:flutter/material.dart';

class Menu extends StatelessWidget {
  final GlobalKey<ScaffoldState> _scaffoldKey;
  const Menu(this._scaffoldKey,{Key key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      child:     Padding(
      padding: EdgeInsets.fromLTRB(0, 35.0, 0, 0.0),
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
    );
  }
}