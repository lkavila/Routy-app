import 'package:flutter/material.dart';
import 'package:routy_app_v102/Domain/entities/car.dart';

class VehicleCard extends StatelessWidget {
  final CarEntity vehiculo;
  const VehicleCard(this.vehiculo, {Key key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      child: carWidget(vehiculo),
    );
  }

  Widget carWidget(CarEntity vehiculo) {
    final List<Color> _colors = [Colors.blue, Color.fromRGBO(11, 210, 181, 1)];
    final List<double> _stops = [0.4, 1];
    return Container(
        width: 350,
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(40),
        ),
        padding: EdgeInsets.fromLTRB(15.0, 15.0, 15.0, 0.0),
        child: Card(
            color: Colors.grey,
            elevation: 3.0,
            shape: RoundedRectangleBorder(
              side: BorderSide(color: Colors.grey[350], width: 2),
              borderRadius: BorderRadius.circular(15),
            ),
            clipBehavior: Clip.antiAlias,
            child: Container(
              decoration: BoxDecoration(
                gradient: LinearGradient(
                  begin: Alignment.centerLeft,
                  end: Alignment.centerRight,
                  colors: _colors,
                  stops: _stops,
                ),
              ),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  ListTile(
                    title: Text(
                      "Nombre: ${vehiculo.name}",
                      style: TextStyle(
                          color: Colors.white,
                          fontSize: 20,
                          fontWeight: FontWeight.w600),
                    ),
                    subtitle: Text(
                      'Tipo: ${vehiculo.tipoCar}',
                      style: TextStyle(
                        color: Colors.white,
                        fontSize: 14,
                      ),
                    ),
                  ),
                  Padding(
                    padding: EdgeInsets.fromLTRB(15.0, 0.0, 15.0, 0.0),
                    child: Text(
                      'Kilometros recorridos: ${vehiculo.recorrido}',
                      style: TextStyle(
                        color: Colors.white,
                        fontSize: 14,
                      ),
                    ),
                  ),
                  Padding(
                    padding: EdgeInsets.fromLTRB(15.0, 0.0, 15.0, 0.0),
                    child: Text(
                      'Combustible consumido: ${vehiculo.consumido}',
                      style: TextStyle(
                        color: Colors.white,
                        fontSize: 14,
                      ),
                    ),
                  ),
                  Padding(
                    padding: EdgeInsets.fromLTRB(15.0, 0.0, 15.0, 0.0),
                    child: Text(
                      'Tipo de Combustible: ${vehiculo.tipoCombustible}',
                      style: TextStyle(
                        color: Colors.white,
                        fontSize: 14,
                      ),
                    ),
                  ),
                  Padding(
                    padding: EdgeInsets.fromLTRB(15.0, 0.0, 15.0, 0.0),
                    child: Text(
                      'Consumo: ${vehiculo.consumo} Galones/100Km',
                      style: TextStyle(
                        color: Colors.white,
                        fontSize: 14,
                      ),
                    ),
                  ),
                  Padding(
                    padding: EdgeInsets.fromLTRB(15.0, 0.0, 15.0, 10.0),
                    child: Text(
                      'Uso: ${vehiculo.uso}',
                      style: TextStyle(
                        color: Colors.white,
                        fontSize: 14,
                      ),
                    ),
                  ),
                ],
              ),
            )));
  }
}
