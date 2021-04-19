import 'package:firebase_auth/firebase_auth.dart';
import 'package:routy_app_v102/Data/datasources/Remote/Firebase/Users/add_account.dart';

class CreateAccountFirebase{
  Future<void> createAccount(String email, String password, String name) async{
      final String defualtUrlImage =
      "https://firebasestorage.googleapis.com/v0/b/approute40-movil.appspot.com/o/users_images%2Fdefault.png?alt=media&token=bbeb9f9d-638f-4b89-ac89-e47c10de8382";

    try {
      await FirebaseAuth.instance
          .createUserWithEmailAndPassword(email: email, password: password);

      User user = FirebaseAuth.instance.currentUser;

      if (!user.emailVerified) {
        await user.sendEmailVerification();
      }

      final AddAccountFirebase _addAccount = AddAccountFirebase();
      _addAccount.addAccount(user, name, email, defualtUrlImage);
          
      
    } on FirebaseAuthException catch (e) {
      if (e.code == 'weak-password') {
        print('La contraseña es muy debil.');
      } else if (e.code == 'email-already-in-use') {
        print('Este Correo electronico ya existe.');
      }
    } catch (e) {
      print(e);
    }
  }
}