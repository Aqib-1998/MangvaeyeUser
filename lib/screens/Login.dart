import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:mangvaeye_user/directories/ImageDirectory.dart';
import 'package:mangvaeye_user/utils/auth.dart';
import 'package:mangvaeye_user/utils/auth_bloc.dart';
import 'package:provider/provider.dart';

import 'EnterOTPScreen.dart';

class LoginPage extends StatefulWidget {
  final AuthBase auth;

  const LoginPage({Key key,@required this.auth}) : super(key: key);
  @override
  _LoginPageState createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {
  var message;
  var formKey = GlobalKey<FormState>();
  TextEditingController _phoneNoController = TextEditingController();

  Future<void> _signInWithGoogle() async{
    try {
      await widget.auth.signInWithGoogle();
    } catch(e){
      print(e.toString() );
    }
  }

  @override
  Widget build(BuildContext context) {
    var authBloc = Provider.of<AuthBloc>(context);
    return Scaffold(
      backgroundColor: Color(0xFFf6f6f6),
      resizeToAvoidBottomInset: true,
      body: SingleChildScrollView(
        child: Stack(
          children: [
            Column(
              children: [
                Stack(
                  children: [
                    Padding(
                        padding: EdgeInsets.only(bottom: 0),
                        child: Container(
                          height: MediaQuery.of(context).size.height * 0.26,
                          decoration: BoxDecoration(
                              color: Color(0xffcca700),
                              borderRadius: BorderRadius.only(
                                  bottomLeft: Radius.circular(30),
                                  bottomRight: Radius.circular(30))),
                          child: Column(
                              mainAxisAlignment: MainAxisAlignment.center,
                              crossAxisAlignment: CrossAxisAlignment.stretch,
                              children: [
                                Align(
                                  alignment: Alignment.center,
                                  child: Text(
                                    'Login',
                                    style: TextStyle(
                                      color: Colors.black,
                                      fontSize: 22.0,
                                      fontWeight: FontWeight.w800,
                                    ),
                                  ),
                                ),
                                SizedBox(
                                  height: 1,
                                ),
                                Align(
                                  alignment: Alignment.center,
                                  child: Text(
                                    'Access account',
                                    style: TextStyle(
                                      color: Colors.black,
                                      fontSize: 16.0,
                                      fontWeight: FontWeight.w400,
                                    ),
                                  ),
                                )
                              ]),
                        )),
                    SizedBox(

                        height: MediaQuery.of(context).size.height * 0.3,
                        child: Image.asset(
                          ImageDirectory.imgDirectory+"topBg.png",
                          height: MediaQuery.of(context).size.height,
                          fit: BoxFit.fitHeight,
                        )),
                  ],
                ),
                SizedBox(
                  height: 5,
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    GestureDetector(
                        onTap: _signInWithGoogle,
                        child: Image.asset(ImageDirectory.imgDirectory+"google_icon.png",scale: 2.5)),
                    SizedBox(
                      width: 15,
                    ),
                    GestureDetector(
                        onTap: () {
                          authBloc.loginFacebook();
                          print('Facebook Signin');
                        },
                        child: Image.asset(ImageDirectory.imgDirectory+"fbLogo.png",scale: 2.5,))
                  ],
                ),
                SizedBox(
                  height: 5,
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Text('Or Login with Phone Number',)
                  ],
                ),
                Stack(
                  children: [
                    Stack(
                      children: [
                        Align(
                          alignment: Alignment.topCenter,
                          child: Container(
                            height: MediaQuery.of(context).size.height * 0.4,
                            width: 380,
                            padding: EdgeInsets.symmetric(
                              horizontal: 30.0,
                              vertical: 25.0,
                            ),
                            color: Color(0xFFf6f6f6),
                            child: Column(
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: [
                                Padding(
                                  padding: const EdgeInsets.only(bottom: 10),
                                  child: Row(
                                    children: [
                                      Text(
                                        'Mobile No',
                                        style: TextStyle(
                                          fontSize: 15,
                                        ),
                                      )
                                    ],
                                  ),
                                ),
                                TextField(
                                  controller: _phoneNoController,
                                  keyboardType: TextInputType.number,
                                  autofocus: false,
                                  autocorrect: false,
                                  style: TextStyle(
                                    fontSize: 16.0,
                                  ),
                                  decoration: InputDecoration(
                                      enabledBorder: OutlineInputBorder(
                                        borderSide: BorderSide(color: Colors.transparent),
                                        borderRadius: BorderRadius.circular(10),),
                                      border: InputBorder.none,
                                      focusColor: Colors.white,
                                      filled: true,
                                      fillColor: Colors.white,
                                      contentPadding: EdgeInsets.all(12),
                                      prefix: Text("+92-"),
                                      hintText: '341234567',
                                      hintStyle: TextStyle(
                                          fontSize: 12
                                      )),
                                ),

                                SizedBox(
                                  height: 20,
                                ),
                                Container(
                                  height: 50,
                                  width: MediaQuery.of(context).size.width * 1.5,
                                  child: ElevatedButton(
                                    onPressed: () {
                                      Navigator.push(
                                        context,
                                        MaterialPageRoute(
                                            builder: (context) => OTPScreen(phone: _phoneNoController.text,auth: widget.auth)
                                          // PinCodeVerificationScreen(
                                          //     phoneController.text)
                                        ),
                                      );
                                    },
                                    child: Text(
                                      "Sign In",
                                      style: TextStyle(
                                        fontSize: 14.0,
                                        color: Colors.black,
                                      ),
                                    ),
                                    style: ElevatedButton.styleFrom(
                                        shape: RoundedRectangleBorder(
                                            borderRadius:
                                            BorderRadius.circular(12)),
                                        primary: Color(0xffcca700),
                                        minimumSize: Size(1, 50) // put the width and height you want
                                    ),
                                  ),
                                ),
                                SizedBox(
                                  height:20,
                                ),
                              ],
                            ),
                          ),
                        ),
                      ],
                    )
                  ],
                )
              ],
            ),

          ],

        ),
      ),
    );
  }




}
