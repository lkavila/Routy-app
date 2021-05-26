import 'package:cloud_firestore/cloud_firestore.dart';

class EditCarFirebase {
  editCar(String userId, String carId, String name, String tipoCombustible,
      double consumo, String tipoCar, String tipoApiCar) {
    CollectionReference users = FirebaseFirestore.instance.collection('users');
    users.doc(userId)
        .update({
          'vehiculos.$carId.name': name,
          'vehiculos.$carId.tipoCombustible': tipoCombustible,
          'vehiculos.$carId.consumo': consumo,
          'vehiculos.$carId.tipoCar': tipoCar,
          'vehiculos.$carId.tipoCarApi': tipoApiCar, })
        .then((value) => print("car edited succesfully"))
        .catchError((error) => print("Failed to edit user vehicle: $error"));
  }
}
