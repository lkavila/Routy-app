import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter_facebook_login/flutter_facebook_login.dart';
import 'package:routy_app_v102/Data/datasources/Remote/Firebase/Users/add_account.dart';

class LoginWithFacebookFirebase{

  Future<void> loginWithFacebook(FacebookLogin facebookSignIn) async{
    
    final res = await facebookSignIn.logIn(['email']);

    switch (res.status) {
      case FacebookLoginStatus.loggedIn:
        print('It worked');

        //Get Token
        final FacebookAccessToken fbToken = res.accessToken;

        //Convert to Auth Credential
        final AuthCredential credential =
            FacebookAuthProvider.credential(fbToken.token);

        //User Credential to Sign in with Firebase
        final currentUser =
            await FirebaseAuth.instance.signInWithCredential(credential);

      final AddAccountFirebase _addAccount = AddAccountFirebase();
      _addAccount.addAccount(currentUser.user, currentUser.user.displayName,
          currentUser.user.email, currentUser.user.photoURL);
          
        print('${currentUser.user.displayName} is now logged in');
        break;
      case FacebookLoginStatus.cancelledByUser:
        print('The user canceled the login');
        break;
      case FacebookLoginStatus.error:
        print('There was an error');
        break;
    }
  }
}