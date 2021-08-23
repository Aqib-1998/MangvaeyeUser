import 'package:cached_network_image/cached_network_image.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:mangvaeye_user/directories/ImageDirectory.dart';

class ShopMenu extends StatefulWidget {
  final String shopID,shopName,shopPhoto;
  const ShopMenu({Key key,@required this.shopID,@required this.shopName,@required this.shopPhoto}) : super(key: key);

  @override
  _ShopMenuState createState() => _ShopMenuState();
}

class _ShopMenuState extends State<ShopMenu> {
  get builder => null;

  _showModalBottomSheet(context) {
    showModalBottomSheet(

      backgroundColor: Colors.transparent,
        context: context,
        builder: (BuildContext context) {
          return ListView(
            children: [
              Container(

                decoration: BoxDecoration(
                    color: Colors.white,
                    borderRadius: BorderRadius.only(
                     topRight: Radius.circular(20),
                      topLeft: Radius.circular(20),
                    )),
                child: Padding(
                  padding:
                  const EdgeInsets.symmetric(vertical: 20, horizontal: 15),
                  child: Column(
                    children: [
                      Row(
                        children: [
                          Text(
                            "Fresh Carrot",
                            style: TextStyle(
                              fontSize: 20,
                              fontWeight: FontWeight.bold,
                              color: Colors.black,
                            ),
                          ),
                        ],
                      ),
                      Padding(
                        padding: const EdgeInsets.only(top: 20),
                        child: InkWell(
                          onTap: (){},
                          child: Container(
                            decoration: BoxDecoration(
                              border:
                              Border.all(width: 1, color: Colors.transparent),
                              color: Colors.black12,
                              borderRadius: const BorderRadius.all(
                                const Radius.circular(10),
                              ),
                            ),
                            height: 50,
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: [
                                Text(
                                  "Select location / Address",
                                  style: TextStyle(
                                    fontSize: 12,
                                    fontWeight: FontWeight.bold,
                                    color: Colors.black,
                                  ),
                                ),
                              ],
                            ),
                          ),
                        ),
                      ),
                      Padding(
                        padding: const EdgeInsets.only(top: 8, bottom: 6),
                        child: Text(
                          "Or",
                          style: TextStyle(fontWeight: FontWeight.bold),
                        ),
                      ),
                      Text(
                        "Select Current Location / Address",
                        style: TextStyle(
                            fontWeight: FontWeight.bold, fontSize: 12),
                      ),
                      Padding(padding: EdgeInsets.only(top: 10)),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Image.asset(
                            ImageDirectory.imgDirectory+"plusIcon.png",
                            scale: 3,
                          ),
                          Padding(
                            padding:
                            const EdgeInsets.only(right: 13.5, left: 13.5),
                            child: Text("0 Kg"),
                          ),
                          Image.asset(
                            ImageDirectory.imgDirectory+"minusIcon.png",
                            scale: 3,
                          ),
                        ],
                      ),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Image.asset(
                            ImageDirectory.imgDirectory+"plusIcon.png",
                            scale: 3,
                          ),
                          Padding(
                            padding:
                            const EdgeInsets.only(right: 13.5, left: 13.5),
                            child: Text("0 Kg"),
                          ),
                          Image.asset(
                            ImageDirectory.imgDirectory+"minusIcon.png",
                            scale: 3,
                          ),
                        ],
                      ),
                      Padding(padding: EdgeInsets.only(top: 10)),
                      Container(
                        height: MediaQuery.of(context).size.height*0.15,
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.all(
                            const Radius.circular(8),
                          ),
                          color: Colors.black12,
                        ),
                        child: Column(
                          children: [
                            Row(
                              children: [
                                Padding(
                                  padding:
                                  const EdgeInsets.only(top: 10, left: 10),
                                  child: Text(
                                    "Enter Note (optional)",
                                    style: TextStyle(
                                        color: Colors.black45,
                                        fontWeight: FontWeight.bold),
                                  ),
                                )
                              ],
                            ),
                          ],
                        ),
                      ),
                      Padding(
                        padding: const EdgeInsets.only(top: 10),
                        child: InkWell(
                          onTap: () {Navigator.pop(context);},
                          child: Container(
                            height: MediaQuery.of(context).size.height*0.07,
                            decoration: BoxDecoration(
                              borderRadius: BorderRadius.all(
                                const Radius.circular(8),
                              ),
                              color: Colors.amber,
                            ),
                            child: Column(
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: [
                                Row(
                                  mainAxisAlignment: MainAxisAlignment.center,
                                  children: [
                                    Text(
                                      "Add To Basket",
                                      style: TextStyle(
                                          fontSize: 15,
                                          fontWeight: FontWeight.bold,
                                          color: Colors.white),
                                    ),
                                  ],
                                ),
                              ],
                            ),
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
              ),
            ],
          );
        });
  }
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: Scaffold(
        body: SizedBox(
          height: MediaQuery.of(context).size.height,
          child: SingleChildScrollView(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Stack(
                  children: [
                    CachedNetworkImage(
                      imageUrl: widget.shopPhoto,fit: BoxFit.fitWidth,
                      progressIndicatorBuilder: (context, url, downloadProgress) =>
                          Center(child: CircularProgressIndicator(value: downloadProgress.progress)),
                      errorWidget: (context, url, error) => Icon(Icons.error),
                    ),
                    Padding(
                      padding: const EdgeInsets.symmetric(
                          vertical: 40, horizontal: 20),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: <Widget>[
                          InkWell(
                            onTap: () => Navigator.pop(context),
                            child: Image.asset(
                              ImageDirectory.imgDirectory+"backIcon.png",
                              scale: 3.5,
                            ),
                          ),
                        ],
                      ),
                    )
                  ],
                ),
                Padding(
                  padding:
                  const EdgeInsets.symmetric(vertical: 40, horizontal: 20),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        widget.shopName,
                        style: TextStyle(
                            fontSize: 30, fontWeight: FontWeight.bold),
                      ),
                      Text(
                        "See Reviews (200)",
                        style: TextStyle(
                            color: Colors.black45, fontWeight: FontWeight.bold),
                      ),
                      Padding(
                        padding: const EdgeInsets.symmetric(
                            vertical: 5, horizontal: 0),
                        child: Row(
                          children: [
                            Image.asset(
                              ImageDirectory.imgDirectory+"star.png",
                              scale: 2.3,
                            ),
                            Text(
                              "4.6",
                              style: TextStyle(fontWeight: FontWeight.bold),
                            ),
                            Padding(
                              padding: const EdgeInsets.only(left: 35),
                              child: Image.asset(
                                ImageDirectory.imgDirectory+"clock.png",
                                scale: 2.4,
                              ),
                            ),
                            Text(
                              "15 min",
                              style: TextStyle(color: Colors.black45),
                            ),
                          ],
                        ),
                      ),
                      Text(
                        "Kami store is the place where you can get fresh vegetable",
                        style: TextStyle(color: Colors.black45),
                      ),
                      Padding(
                        padding: const EdgeInsets.only(top: 10, bottom: 5),
                        child: Text("${widget.shopName} Menu",
                            style: TextStyle(
                              fontSize: 20,
                              fontWeight: FontWeight.bold,
                            )),
                      ),
                      SizedBox(
                        height: MediaQuery.of(context).size.height* 0.6,
                        child: StreamBuilder<QuerySnapshot>(
                          stream: FirebaseFirestore.instance.collection("Shop Users").doc(widget.shopID).collection('Shop Menus').snapshots(),
                            builder: (context, snapshot) {
                            if(!snapshot.hasData || snapshot.data.docs.length == 0){
                              return Center(child: Text("This shop has no Menus!"),);
                            }
                            if(snapshot.connectionState == ConnectionState.waiting){
                              return Center(child: CircularProgressIndicator());
                            }
                            return ListView.builder(
                              shrinkWrap: true,
                              itemCount: snapshot.data.docs.length,
                              padding:
                              EdgeInsets.symmetric(vertical: 10, horizontal: 0),
                              itemBuilder: (context, index) {
                                return Column(
                                  children: [
                                    Container(
                                      decoration: BoxDecoration(
                                        border: Border.all(
                                            width: 1, color: Colors.black12),
                                        color: Colors.white,
                                        borderRadius: const BorderRadius.all(
                                          const Radius.circular(10),
                                        ),
                                      ),
                                      child: InkWell(
                                        onTap: () {
                                          _showModalBottomSheet(context);
                                        },
                                        child: Row(
                                          children: [
                                            Column(
                                              children: [
                                                CachedNetworkImage(
                                                  height: 100,
                                                  width: 100,
                                                  imageUrl: snapshot.data.docs[index]["Menu Image"],
                                                  progressIndicatorBuilder: (context, url, downloadProgress) =>
                                                      Center(child: CircularProgressIndicator(value: downloadProgress.progress)),
                                                  errorWidget: (context, url, error) => Icon(Icons.error),
                                                ),
                                              ],
                                            ),
                                            Padding(
                                              padding: const EdgeInsets.symmetric(
                                                  vertical: 0, horizontal: 10),
                                              child: Column(
                                                crossAxisAlignment:
                                                CrossAxisAlignment.start,
                                                children: [
                                                  Text(
                                                    snapshot.data.docs[index]["Menu Name"],
                                                    style: TextStyle(
                                                      fontSize: 16,
                                                      color: Colors.black45,
                                                    ),
                                                  ),
                                                  Text(
                                                    "${snapshot.data.docs[index]["Menu Amount"]} rupees kilo",
                                                    style: TextStyle(
                                                        fontSize: 12,
                                                        color: Colors.black45),
                                                  ),
                                                  Text(
                                                    "Click to order",
                                                    style: TextStyle(
                                                        fontSize: 10,
                                                        color: Colors.black45),
                                                  ),
                                                ],
                                              ),
                                            ),
                                          ],
                                        ),
                                      ),
                                    ),
                                    SizedBox(
                                      height: 15,
                                    )
                                  ],
                                );
                              },
                            );
                          }
                        ),
                      ),
                    ],
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
