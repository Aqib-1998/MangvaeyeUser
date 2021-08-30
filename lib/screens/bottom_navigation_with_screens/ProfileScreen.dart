import 'package:flutter/material.dart';
import 'package:mangvaeye_user/directories/ImageDirectory.dart';
import 'package:mangvaeye_user/utils/MyColors.dart';
class ProfileScreen extends StatefulWidget {
  const ProfileScreen({Key key}) : super(key: key);

  @override
  _ProfileScreenState createState() => _ProfileScreenState();
}

class _ProfileScreenState extends State<ProfileScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(

      body:SingleChildScrollView(
        child: Column(
crossAxisAlignment: CrossAxisAlignment.start,
          children: [

            Stack(
              clipBehavior: Clip.antiAlias,
              children: [
                Container(
                  height: MediaQuery.of(context).size.height * 0.3,
                  child: Container(
                    decoration: BoxDecoration(
                        color: MyColors.APP_COLOR,
                        borderRadius: BorderRadius.only(
                            bottomLeft: Radius.circular(0.0),
                            bottomRight: Radius.circular(0.0))),
                    height: MediaQuery.of(context).size.height * 0.3,
                    width: MediaQuery.of(context).size.width,
                  ),
                ),
                SizedBox(
                  height: MediaQuery.of(context).size.height * 0.35,
                  child: Image.asset(
                    ImageDirectory.imgDirectory + "topBg.png",
                    height: MediaQuery.of(context).size.height,
                    fit: BoxFit.fitHeight,
                  ),
                ),
                Container(
                  height:MediaQuery.of(context).size.height * 0.38 ,

                  child:Align(
                    alignment: Alignment.bottomCenter,
                    child: CircleAvatar(
                      radius: 75,
                      backgroundImage: AssetImage(ImageDirectory.imgDirectory + "user.png"),
                    ),
                  )
                ),




              ],
            ),
            Align(
              alignment: Alignment.center,
              child: Padding(
                  padding: EdgeInsets.symmetric(horizontal: 0,vertical: 10),
                  child: Text("Aqib Ali", style: TextStyle(
                      fontSize: 25, fontWeight: FontWeight.bold),)),
            ),
            SizedBox(height: 100,),
            Padding(
                padding: EdgeInsets.symmetric(horizontal: 15,vertical: 10),
                child: Text("Rate Us", style: TextStyle(
                    fontSize: 20, fontWeight: FontWeight.bold),)),
            Padding(
                padding: EdgeInsets.symmetric(horizontal: 15,vertical: 10),
                child: Text("Give Suggestions", style: TextStyle(
                    fontSize: 20, fontWeight: FontWeight.bold),)),
            Padding(
                padding: EdgeInsets.symmetric(horizontal: 15,vertical: 10),
                child: Text("Sign Out", style: TextStyle(
                    fontSize: 20, fontWeight: FontWeight.bold),))
          ],
        ),
      ) ,
    );
  }
}
