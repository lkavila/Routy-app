import 'package:flutter/material.dart';

class Loading extends StatelessWidget {
  final String mensaje;
  const Loading(this.mensaje, {Key key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Stack(
      alignment: AlignmentDirectional.center,
        children: [
          Container(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Center(child: CircularProgressIndicator(backgroundColor: Colors.blue[800], semanticsLabel: mensaje,)),
                Text(mensaje, style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold, fontFamily: 'Pacifico'),),
              ],
            ),
          ),

          
      ],
      );
  }
}