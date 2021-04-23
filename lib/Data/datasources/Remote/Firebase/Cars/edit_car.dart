import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:get/get.dart';
import 'package:routy_app_v102/Domain/entities/car.dart';
import 'package:routy_app_v102/Presentation/GetX/user_controller.dart';

class EditCarFirebase{

    editCar(String id, String name, String tipoCombustible, double consumo, String tipoCar, String tipoApiCar){
    final UserController uc = Get.find();
    CarEntity car = uc.user.vehiculos.where((element) => element.id==id).first;
    CollectionReference users = FirebaseFirestore.instance.collection('users');
    uc.user.vehiculos.remove(car);
    car.name = name;
    car.tipoCombustible = tipoCombustible;
    car.tipoCar = tipoCar;
    car.tipoCarApi = tipoApiCar;
    car.consumo = consumo;
    uc.user.vehiculos.add(car);
    print(car.toJson());
    
    users.doc(uc.user.id)
      .update({'vehiculos.$id.uso': name,
              'vehiculos.$id.tipoCombustible': tipoCombustible,
              'vehiculos.$id.consumo': consumo,
              'vehiculos.$id.tipoCar': tipoCar,
              'vehiculos.$id.tipoCarApi': tipoApiCar,})
      .then((value) => print("car created Updated"))
      .catchError((error) => print("Failed to update user vehiculo: $error"));
    }
}