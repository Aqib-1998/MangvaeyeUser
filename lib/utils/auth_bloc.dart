
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter_login_facebook/flutter_login_facebook.dart';

import 'auth.dart';


final _auth = FirebaseAuth.instance;
final firestore = FirebaseFirestore.instance;
class AuthBloc {
  final authService = Auth();
  final fb = FacebookLogin();
  GiveUser _userFromFirebase(User user) {
    if (user == null) {
      return null;
    }
    return GiveUser(uid: user.uid);
  }
  Future<GiveUser> currentUser() async {
    final user = FirebaseAuth.instance.currentUser;
    return _userFromFirebase(user);
  }

  loginFacebook() async {
    print('Starting Facebook Login');
    final res = await fb.logIn(
        permissions: [
          FacebookPermission.publicProfile,
          FacebookPermission.email
        ]
    );

    switch(res.status){
      case FacebookLoginStatus.success:
        print('It worked');
        //Get Token
        final FacebookAccessToken fbToken = res.accessToken;
        //Convert to Auth Credential
        final AuthCredential credential
        = FacebookAuthProvider.credential(fbToken.token);

        //User Credential to Sign in with Firebase
        final result = await authService.signInWithCredential(credential);

          firestore.collection("Users").doc(_auth.currentUser.uid).set({
            'New user?' : result.additionalUserInfo.isNewUser,
            'Account Type?': "Facebook",
            'Username': result.user.displayName
          });


        print('${result.user.displayName} is now logged in');
        break;
      case FacebookLoginStatus.cancel:
        print('The user canceled the login');

        break;
      case FacebookLoginStatus.error:
        print(FacebookLoginStatus.error);

        break;
    }
  }

  logout(){
    authService.logout();
  }
}