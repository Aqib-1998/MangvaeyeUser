import 'package:cached_network_image/cached_network_image.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:mangvaeye_user/directories/ImageDirectory.dart';
import 'package:mangvaeye_user/main.dart';
import 'package:mangvaeye_user/utils/MyColors.dart';



class Cart extends StatefulWidget {
  final List<int> productPrice, kilo, pao;
  final String shopId, location,userName;
  final double lat, long;
  final List<String> productId,productName,productImage,productNote;

  const Cart(
      {Key key,
      @required this.productPrice,
      @required this.kilo,
      @required this.pao,
      @required this.productId,
      @required this.productName,
      @required this.location,
      @required this.productImage,
      @required this.productNote,
      @required this.shopId,@required this.userName,@required this.lat,@required this.long})
      : super(key: key);

  @override
  _CartState createState() => _CartState();
}

class _CartState extends State<Cart> {

  @override
  void initState() {
    tempSum = 0;
    super.initState();
  }

  get child => null;
  double tempSum = 0,sum = 0;

  @override
  Widget build(BuildContext context) {
    for(int i = 0;i< widget.productName.length;i++){
      tempSum = tempSum + (widget.productPrice[i] * widget.kilo[i])+((widget.productPrice[i]/4) * widget.pao[i]);
    }
    sum = tempSum;
    tempSum = 0;
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      home: Scaffold(
        backgroundColor: MyColors.WHITE,
        body: SingleChildScrollView(
          child: Column(
            children: [
              Padding(
                padding: const EdgeInsets.all(20),
                child: Column(
                  children: [
                    Padding(
                      padding: const EdgeInsets.only(top: 30),
                      child: Row(
                        children: [
                          Expanded(
                            flex: 1,
                            child: Container(
                              height: 50,
                              child: Image.asset(
                                ImageDirectory.imgDirectory + "backIcon.png",
                                scale: 3,
                              ),
                            ),
                          ),
                          Expanded(
                            flex: 5,
                            child: Text(
                              "Cart",
                              textAlign: TextAlign.center,
                              style: TextStyle(
                                  fontSize: 22, fontWeight: FontWeight.bold),
                            ),
                          ),
                          Expanded(flex: 1, child: SizedBox())
                        ],
                      ),
                    ),
                    Padding(
                      padding: const EdgeInsets.only(top: 25),
                      child: Container(
                        height: 100,
                        decoration: BoxDecoration(
                          borderRadius:
                              BorderRadius.all(const Radius.circular(15)),
                          color: Colors.deepOrange,
                        ),
                        child: Padding(
                          padding: const EdgeInsets.all(20),
                          child: Column(
                            children: [
                              Row(
                                children: [
                                  Image.asset(
                                    ImageDirectory.imgDirectory +
                                        "locIconWhite.png",
                                    scale: 3,
                                  ),
                                  Padding(
                                    padding: const EdgeInsets.only(left: 15),
                                    child: Text(
                                      "Deliver to",
                                      style: TextStyle(
                                          color: Colors.white, fontSize: 12),
                                    ),
                                  ),
                                ],
                              ),
                              Row(
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceBetween,
                                children: [
                                  Padding(
                                    padding: const EdgeInsets.only(left: 35),
                                    child: Text(
                                      widget.location,
                                      style: TextStyle(
                                          color: Colors.white, fontSize: 13),
                                    ),
                                  ),
                                  Image.asset(
                                    ImageDirectory.imgDirectory +
                                        "arrowDownwardIcon.png",
                                    scale: 3,
                                  ),
                                ],
                              ),
                            ],
                          ),
                        ),
                      ),
                    ),
                    Padding(
                      padding: const EdgeInsets.only(top: 10),
                      child: SizedBox(
                        height: 210,
                        child: ListView.builder(
                          shrinkWrap: true,
                          itemCount: widget.productName.length,
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
                                      const Radius.circular(20),
                                    ),
                                  ),
                                  child: InkWell(
                                    onTap: () {},
                                    child: Row(
                                      mainAxisAlignment:
                                          MainAxisAlignment.spaceBetween,
                                      children: [
                                        Row(
                                          children: [
                                            Column(
                                              mainAxisSize: MainAxisSize.max,
                                              children: [
                                                ClipRRect(
                                                  child: CachedNetworkImage(
                                                    height: 100,
                                                    width: 125,
                                                    imageUrl: widget.productImage[index],
                                                    progressIndicatorBuilder: (context,
                                                        url,
                                                        downloadProgress) =>
                                                        Center(
                                                            child: CircularProgressIndicator(
                                                                value:
                                                                downloadProgress
                                                                    .progress)),
                                                    errorWidget:
                                                        (context, url, error) =>
                                                        Icon(Icons.error),
                                                    fit: BoxFit.fill,
                                                  ),
                                                  borderRadius: BorderRadius.all(
                                                      Radius.circular(10)),
                                                ),
                                              ],
                                            ),
                                            Padding(
                                              padding:
                                                  const EdgeInsets.symmetric(
                                                      vertical: 0,
                                                      horizontal: 10),
                                              child: Column(
                                                crossAxisAlignment:
                                                    CrossAxisAlignment.start,
                                                children: [
                                                  Text(
                                                    widget.productName[index],
                                                    style: TextStyle(
                                                      fontSize: 16,
                                                      color: Colors.black,
                                                    ),
                                                  ),
                                                  Text(
                                                    "${widget.kilo[index]} kg ${widget.pao[index]} pao",
                                                    style: TextStyle(
                                                        fontSize: 12,
                                                        color: Colors.black),
                                                  ),
                                                  Text(
                                                   "${widget.productPrice[index].toString()} Rs/kilo",
                                                    style: TextStyle(
                                                        fontSize: 10,
                                                        color: Colors.black),
                                                  ),
                                                ],
                                              ),
                                            ),
                                          ],
                                        ),
                                        Padding(
                                          padding:
                                              const EdgeInsets.only(right: 10),
                                          child: Column(
                                            children: [
                                              Image.asset(
                                                ImageDirectory.imgDirectory +
                                                    "crossIcon.png",
                                                scale: 2.5,
                                              ),
                                            ],
                                          ),
                                        )
                                      ],
                                    ),
                                  ),
                                ),
                                SizedBox(
                                  height: 10,
                                )
                              ],
                            );
                          },
                        ),
                      ),
                    ),
                    Padding(
                      padding: const EdgeInsets.only(top: 15),
                      child: Container(
                        decoration: BoxDecoration(
                          color: Colors.white,
                          borderRadius: BorderRadius.all(
                            const Radius.circular(10),
                          ),
                        ),
                        height: 50,
                        child: Padding(
                          padding: const EdgeInsets.symmetric(
                              vertical: 10, horizontal: 20),
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              Text(
                                "PROMO CODE",
                                style: TextStyle(
                                    color: Colors.black12,
                                    fontWeight: FontWeight.bold),
                              ),
                              Image.asset(
                                ImageDirectory.imgDirectory +
                                    "plusGreyIcon.png",
                                scale: 3,
                              ),
                            ],
                          ),
                        ),
                      ),
                    ),
                  ],
                ),
              ),
              Container(
                decoration: BoxDecoration(
                    color: Colors.amber,
                    borderRadius: BorderRadius.only(
                      topRight: Radius.circular(40),
                      topLeft: Radius.circular(40),
                    )),
                height: 280,
                child: Padding(
                  padding:
                      const EdgeInsets.symmetric(vertical: 30, horizontal: 20),
                  child: Column(
                    children: [
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Text(
                            "Item total",
                            style: TextStyle(color: Color(0xff373737)),
                          ),
                          Text(
                            "$sum Rs",
                            style: TextStyle(color: Color(0xff373737)),
                          ),
                        ],
                      ),
                      Padding(padding: const EdgeInsets.only(top: 15)),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Text(
                            "Discount",
                            style: TextStyle(color: Color(0xff373737)),
                          ),
                          Text(
                            "-\&10",
                            style: TextStyle(color: Color(0xff373737)),
                          ),
                        ],
                      ),
                      Padding(padding: const EdgeInsets.only(top: 15)),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Text(
                            "Tax",
                            style: TextStyle(color: Color(0xff373737)),
                          ),
                          Text(
                            "\$2",
                            style: TextStyle(color: Color(0xff373737)),
                          ),
                        ],
                      ),
                      Padding(padding: const EdgeInsets.only(top: 15)),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Text(
                            "Total",
                            style: TextStyle(
                                fontSize: 17,
                                color: Colors.black,
                                fontWeight: FontWeight.bold),
                          ),
                          Text(
                            "\&12.49",
                            style: TextStyle(
                                color: Colors.black45,
                                fontWeight: FontWeight.bold),
                          ),
                        ],
                      ),
                      Padding(
                        padding: EdgeInsets.only(top: 30),
                        child: SizedBox(
                          height: 50,
                          width: MediaQuery.of(context).size.width,
                          child: ElevatedButton(
                            style: ButtonStyle(
                              backgroundColor:
                                  MaterialStateProperty.all(MyColors.WHITE),
                            ),
                            onPressed: () {
                              print(widget.userName);
                              FirebaseFirestore.instance.collection('Shop Users').doc(widget.shopId).collection('Queued Orders').add({
                                'Customer Name': widget.userName,
                                'location':widget.location,
                                'Product Name': widget.productName,
                                'Product Note': widget.productNote,
                                'Product Price': widget.productPrice,
                                'kg': widget.kilo,
                                'pao' : widget.pao,
                                'Total Price': sum,
                                'TimeStamp' : DateTime.now(),
                                'lat' : widget.lat,
                                'long': widget.long
                              }).whenComplete((){


                                Navigator.pushAndRemoveUntil(context, MaterialPageRoute(builder: (context)=> MyApp()), (route) => false);
                              });


                            },
                            child: Text(
                              "Place Your Order",
                              style: TextStyle(color: MyColors.Black),
                            ),
                          ),
                        ),
                      )
                    ],
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );

  }

}
