


import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class BaseClass{
  BaseClass();

  goToNextScreenWithStack(BuildContext context,dynamic route){
    Navigator.push(context, MaterialPageRoute(builder: (context)=> route));

    Navigator.pushNamed(context, route);

  }
  goToNextScreenWithoutStack(BuildContext context,dynamic route){

    Navigator.pushReplacement(context, MaterialPageRoute(builder:(_) => route ));

  }


}