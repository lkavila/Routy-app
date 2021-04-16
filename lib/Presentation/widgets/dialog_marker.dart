import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:routy_app_v102/utils.dart';

class DialogMarker extends StatelessWidget {
  final Set<Marker> markers;
  final Marker marker;
  const DialogMarker(this.marker, this.markers, {Key key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    print(markers);
    return Center( //showDialog()
      child: Container(
      height: 360,
      child: AlertDialog(
        title: Text("Modificar marker"),
        content: Container(
          child: Column(

            children: [
              TextButton(onPressed: (){
                Utils.hacerInicio(markers, marker);
                },
                child: Text("Hacer inicio")),

              TextButton(onPressed: (){
                Utils.hacerInicio(markers, marker);
                },
                child: Text("Hacer inicio")),

              TextButton(onPressed: (){
                Utils.hacerInicio(markers, marker);
                },
                child: Text("Hacer inicio")),
            ],
          ),
        ),
        actions: [
          TextButton(onPressed: (){

            Navigator.of(context, rootNavigator: true).pop();

          }, child: Text("Cancelar"))
        ],
      ),
      )
    );
  }
}