import 'package:flutter/material.dart';

class Logo extends StatelessWidget {
  final double fontsize;
  const Logo(this.fontsize, {Key key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      child:           Stack(
          children: [
          Align(
            alignment: Alignment.center,
            child: Container(
              child: Text(
                'Routy',
                style: TextStyle(
                  color: Colors.blue[900],
                  fontSize: fontsize,
                  fontWeight: FontWeight.normal,
                  fontFamily: 'Pacifico'
                ),
              ),
            ),
          ),
          SizedBox(
            height: fontsize*1.55,
          child: Align(
            alignment: Alignment.bottomCenter,
            child: Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children:[

              Text(
                'by ',
                style: TextStyle(
                  color: Colors.black,
                  fontSize: fontsize*0.18,
                ),
              ),
              Text(
                'TNTeam',
                style: TextStyle(
                  color: Colors.black,
                  fontWeight: FontWeight.bold,
                  fontSize: fontsize*0.18,
                ),
              ),
              ],
            ),
              
          ),
          ),
          ],),
    );
  }
}