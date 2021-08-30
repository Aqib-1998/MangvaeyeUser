import 'package:flutter/material.dart';
import 'package:hexcolor/hexcolor.dart';
import 'package:mangvaeye_user/directories/ImageDirectory.dart';

class OrdersListScreen extends StatefulWidget {
  const OrdersListScreen({Key key}) : super(key: key);

  @override
  _OrdersListScreenState createState() => _OrdersListScreenState();
}

class _OrdersListScreenState extends State<OrdersListScreen> {
  @override
  Widget build(BuildContext context) {
    return ListView(
      children: [
        Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [

            Padding(
                padding: EdgeInsets.only(top: 30, left: 20, bottom: 20),
                child: Text("My Orders", style: TextStyle(
                    fontSize: 25, fontWeight: FontWeight.bold),)),
            Padding(
                padding: EdgeInsets.only(top: 10, left: 20, bottom: 10),
                child: Text("Incompleted Orders", style: TextStyle(
                    fontSize: 15, fontWeight: FontWeight.bold),)),
            SizedBox(height: MediaQuery
                .of(context)
                .size
                .height * 0.35,
                child:Expanded(
                  child: Container(
                    width: MediaQuery.of(context).size.width,
                    height: 300,
                    child: ListView.builder(
                      itemCount: 3,
                      itemBuilder: (context, index) {
                        return Padding(
                          padding: const EdgeInsets.only(left: 8.0,right: 8.0,bottom: 4.0,top: 4.0),
                          child: Container(
                            width: MediaQuery.of(context).size.width,
                            height: 125,
                            child: Card(
                              color: HexColor('#F4F4F4'),
                              shape: RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(15.0),
                              ),
                              elevation: 3,
                              child: Row(
                                mainAxisAlignment:
                                MainAxisAlignment.spaceEvenly,
                                children: [
                                  Container(
                                      height: 55,
                                      child: Image.asset(
                                          ImageDirectory.imgDirectory+'Cart.png')),
                                  Padding(
                                    padding: const EdgeInsets.all(16.0),
                                    child: Column(
                                      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                                      crossAxisAlignment: CrossAxisAlignment.center,
                                      children: [
                                        Text("Ali Haider"),
                                        Text("10-8-2021"),
                                        Text("10:30 a.m")
                                      ],
                                    ),
                                  ),
                                  Container(
                                      height: 20,
                                      child: Image.asset(ImageDirectory.imgDirectory + "redclock.png")),
                                ],
                              ),
                            ),
                          ),
                        );
                      },
                    ),
                  ),
                )
            ),

            Padding(
                padding: EdgeInsets.only(top: 10, left: 20, bottom: 10),
                child: Text("Completed Orders", style: TextStyle(
                    fontSize: 15, fontWeight: FontWeight.bold),)),
            SizedBox(height: MediaQuery
                .of(context)
                .size
                .height * 0.35,



            child: Expanded(
              child: Container(
                width: MediaQuery.of(context).size.width,
                height: 300,
                child: ListView.builder(
                  itemCount: 3,
                  itemBuilder: (context, index) {
                    return Padding(
                      padding: const EdgeInsets.only(left: 8.0,right: 8.0,bottom: 4.0,top: 4.0),
                      child: Container(
                        width: MediaQuery.of(context).size.width,
                        height: 125,
                        child: Card(
                          color: HexColor('#F4F4F4'),
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(15.0),
                          ),
                          elevation: 3,
                          child: Row(
                            mainAxisAlignment:
                            MainAxisAlignment.spaceEvenly,
                            children: [
                              Container(
                                  height: 55,
                                  child: Image.asset(
                                      ImageDirectory.imgDirectory+'Cart.png')),
                              Padding(
                                padding: const EdgeInsets.all(16.0),
                                child: Column(
                                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                                  crossAxisAlignment: CrossAxisAlignment.center,
                                  children: [
                                    Text("Ali Haider"),
                                    Text("10-8-2021"),
                                    Text("10:30 a.m")
                                  ],
                                ),
                              ),
                              Container(
                                  height: 20,
                                  child: Image.asset(ImageDirectory.imgDirectory + "redclock.png")),
                            ],
                          ),
                        ),
                      ),
                    );
                  },
                ),
              ),
            ),),


          ],
        )

      ],
    );
  }
}
