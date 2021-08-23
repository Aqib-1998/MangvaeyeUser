
import 'dart:async';
import 'package:animated_splash_screen/animated_splash_screen.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:mangvaeye_user/screens/Login.dart';
import 'package:mangvaeye_user/screens/bottom_navigation_with_screens/HomeScreen.dart';
import 'package:mangvaeye_user/utils/auth.dart';
import 'package:mangvaeye_user/utils/auth_bloc.dart';
import 'package:page_transition/page_transition.dart';
import 'package:provider/provider.dart';


Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Provider(
      create: (context) => AuthBloc(),
      child: MaterialApp(
        title: 'Food Delivery User',
        theme: ThemeData(fontFamily: 'Poppins'),
        debugShowCheckedModeBanner: false,
        home: AnimatedSplashScreen(
            duration: 3,
            splash: "assets/images/logo.png",
            nextScreen: CheckUser(auth: Auth(),),
            splashIconSize: 75.0,
            animationDuration: Duration(seconds: 1),
            pageTransitionType: PageTransitionType.leftToRightWithFade,
            splashTransition: SplashTransition.slideTransition,
            backgroundColor: Colors.white
        ),
      ),
    );
  }
}



bool newUserBool ;

class CheckUser extends StatefulWidget {
  final AuthBase auth;
  const CheckUser({Key key,@required this.auth}) : super(key: key);
  @override
  _CheckUserState createState() => _CheckUserState();
}

class _CheckUserState extends State<CheckUser> {


  @override
  Widget build(BuildContext context) {


    return StreamBuilder<GiveUser>(
      stream: widget.auth.onAuthStateChanged,
      builder: (context,snapshot){
        if(snapshot.connectionState == ConnectionState.active){
          GiveUser user = snapshot.data;
          if(user == null){
            return LoginPage(
              auth: widget.auth,
            );
          }
          print("user =========> $user");
          String uid =  FirebaseAuth.instance.currentUser.uid;
          void getData()async{
            await FirebaseFirestore.instance.collection("Users").doc(uid).get().then((value) async {
              newUserBool = value.data()["New user?"];
              print(newUserBool);
              if(mounted){
                setState(() {
                  print(newUserBool);
                });
              }

            } );

          }
          if(newUserBool == null){
            getData();
            return Container(color: Colors.white,child: Center(child: CircularProgressIndicator()));

          }

          return HomeScreen(auth: widget.auth,uid: uid,);
        }else{
          return Scaffold(
            body: Center(
              child: CircularProgressIndicator(),
            ),
          );
        }
      },
    );

  }
}