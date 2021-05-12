import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:routy_app_v102/Presentation/pages/map.dart';

class GoToMap extends StatelessWidget {
  final String tagMap;
  const GoToMap(this.tagMap, {Key key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      child: goToMap(),
    );
  }

  Widget goToMap() {
    return FloatingActionButton(
              key: Key("GoToMpap"),
              onPressed:() {
                Get.to(() => MyMap());
              }, 
              child: Icon(
                Icons.add_circle_outline,
                color: Colors.indigo[900],
                size: 40,
              ),
              backgroundColor: Colors.lightBlueAccent,
              heroTag: tagMap,
              mini: true,
          
          );
  }
}