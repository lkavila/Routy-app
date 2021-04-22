import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:get/get.dart';
import 'package:routy_app_v102/Domain/entities/car.dart';
import 'package:routy_app_v102/Presentation/GetX/user_controller.dart';

class UpdateCarFirebase{

   void updateVehicle(String id, double recorrido, double consumido, double uso){
    final UserController uc = Get.find();
    CarEntity car = uc.user.vehiculos.where((element) => element.id==id).first;
    CollectionReference users = FirebaseFirestore.instance.collection('users');
    uc.user.vehiculos.remove(car);
    car.consumido = consumido;
    car.uso = uso;
    car.recorrido = recorrido;
    uc.user.vehiculos.add(car);
    print(car.toJson());
    
    users.doc(uc.user.id)
      .update({'vehiculos.${car.name}.uso': uso,
              'vehiculos.${car.name}.consumido': consumido,
              'vehiculos.${car.name}.recorrido': recorrido})
      .then((value) => print("car created Updated"))
      .catchError((error) => print("Failed to update user vehiculo: $error"));
  }
}