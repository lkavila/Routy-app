import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:routy_app_v102/Presentation/GetX/dark_mode_controller.dart';

class GradientsSwitcher extends StatelessWidget {
  const GradientsSwitcher({Key key}) : super(key: key);
  
  @override
  Widget build(BuildContext context) {
    
    return Container(
      child: modoOscuro(),
    );
  }

  Widget modoOscuro() {
    DarkModeController _darkModeController = Get.find();
    return Align(
        alignment: Alignment.bottomCenter,
        child: Padding(
            padding: EdgeInsets.all(0.0),
            child:
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                   children: [
              Text(
                "Gradiente oscuro",
                textAlign: TextAlign.left,
                style: TextStyle(
                  fontSize: 15,
                  color: _darkModeController.colorMode(),
                ),
              ),
              GetBuilder<DarkModeController>(
                  builder: (_) {
                      return Switch(
                        value: _darkModeController.gradientColors,
                        onChanged: (value)=> _darkModeController.changeGradientColors(),
                        activeTrackColor: Colors.blue,
                        activeColor: Colors.blue[800],
                      );
              }
              )
            ]
            )
            )
            );
  }
}