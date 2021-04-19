import 'package:firebase_auth/firebase_auth.dart';
import 'package:google_sign_in/google_sign_in.dart';
import 'package:routy_app_v102/Data/datasources/Remote/Firebase/Users/add_account.dart';

class LoginWithGoogleFirebase {

  Future<void> loginWithGoogle(GoogleSignIn googleSignIn)async{
    final user = await googleSignIn.signIn();
    if (user == null) {
      return;
    } else {
      final googleAuth = await user.authentication;

      final credential = GoogleAuthProvider.credential(
        accessToken: googleAuth.accessToken,
        idToken: googleAuth.idToken,
      );

      UserCredential currentUser =
          await FirebaseAuth.instance.signInWithCredential(credential);

      final AddAccountFirebase _addAccount = AddAccountFirebase();
      _addAccount.addAccount(currentUser.user, currentUser.user.displayName,
          currentUser.user.email, currentUser.user.photoURL);
    }
  }
}