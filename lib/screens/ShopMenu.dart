import 'package:cached_network_image/cached_network_image.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:geocoding/geocoding.dart';
import 'package:geoflutterfire/geoflutterfire.dart';
import 'package:geolocator/geolocator.dart';
import 'package:mangvaeye_user/directories/ImageDirectory.dart';
import 'package:mangvaeye_user/screens/bottom_navigation_with_screens/cart.dart';

class ShopMenu extends StatefulWidget {
  final String shopID, shopName, shopPhoto, currentLocation, userName;
  final double lat, long;

  const ShopMenu(
      {Key key,
      @required this.shopID,
      @required this.shopName,
      @required this.shopPhoto,
      @required this.currentLocation,
      @required this.userName,
      @required this.lat,
      @required this.long})
      : super(key: key);

  @override
  _ShopMenuState createState() => _ShopMenuState();
}

final noteController = TextEditingController();
bool cart = false;

int length = 0;

class _ShopMenuState extends State<ShopMenu> {
  int kg = 1, pao = 0;
  List<String> productNameList = [],
      productIdList = [],
      productImageList = [],
      productNoteList = [];
  List<int> productPriceList = [], weightKg = [], weightPao = [];
  OutlineInputBorder outlineBorder = OutlineInputBorder(
      borderRadius: BorderRadius.circular(10),
      borderSide: BorderSide(color: Colors.transparent));

  _showModalBottomSheet(
      context,
      String shopId,
      String productName,
      String productId,
      int productPrice,
      String productImage,
      String productNote,
      String location) {
    showModalBottomSheet(
        backgroundColor: Colors.transparent,
        context: context,
        isScrollControlled: true,
        builder: (BuildContext context) {
          return SingleChildScrollView(
            child: Padding(
              padding: MediaQuery.of(context).viewInsets,
              child: Column(
                mainAxisSize: MainAxisSize.min,
                children: [
                  Container(
                    decoration: BoxDecoration(
                        color: Colors.white,
                        borderRadius: BorderRadius.only(
                          topRight: Radius.circular(20),
                          topLeft: Radius.circular(20),
                        )),
                    child: Padding(
                      padding: const EdgeInsets.symmetric(
                          vertical: 20, horizontal: 15),
                      child: Column(
                        children: [
                          Row(
                            children: [
                              Text(
                                productName,
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
                              onTap: () {},
                              child: Container(
                                decoration: BoxDecoration(
                                  border: Border.all(
                                      width: 1, color: Colors.transparent),
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
                          InkWell(
                            onTap: () {
                              //fetchCurrentLocation();
                            },
                            child: Text(
                              "Select Current Location / Address",
                              style: TextStyle(
                                  fontWeight: FontWeight.bold, fontSize: 12),
                            ),
                          ),
                          Padding(padding: EdgeInsets.only(top: 10)),
                          Row(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              InkWell(
                                onTap: () {
                                  setState(() {
                                    kg++;
                                  });
                                },
                                child: Image.asset(
                                  ImageDirectory.imgDirectory + "plusIcon.png",
                                  scale: 3,
                                ),
                              ),
                              Padding(
                                padding: const EdgeInsets.only(
                                    right: 13.5, left: 13.5),
                                child: Text("$kg Kg"),
                              ),
                              InkWell(
                                onTap: () {
                                  setState(() {
                                    if (kg > 0) {
                                      kg--;
                                    } else {
                                      Fluttertoast.showToast(
                                          msg: "Cannot go below 0");
                                    }
                                  });
                                },
                                child: Image.asset(
                                  ImageDirectory.imgDirectory + "minusIcon.png",
                                  scale: 3,
                                ),
                              ),
                            ],
                          ),
                          Row(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              InkWell(
                                onTap: () {
                                  setState(() {
                                    if (pao < 4) {
                                      pao++;
                                    } else {
                                      Fluttertoast.showToast(
                                          msg: "Limit exceeded");
                                    }
                                  });
                                },
                                child: Image.asset(
                                  ImageDirectory.imgDirectory + "plusIcon.png",
                                  scale: 3,
                                ),
                              ),
                              Padding(
                                padding: const EdgeInsets.only(
                                    right: 13.5, left: 13.5),
                                child: Text("$pao Pao"),
                              ),
                              InkWell(
                                onTap: () {
                                  setState(() {
                                    if (pao > 0) {
                                      pao--;
                                    } else {
                                      Fluttertoast.showToast(
                                          msg: "Cannot go below 0");
                                    }
                                  });
                                },
                                child: Image.asset(
                                  ImageDirectory.imgDirectory + "minusIcon.png",
                                  scale: 3,
                                ),
                              ),
                            ],
                          ),
                          Padding(padding: EdgeInsets.only(top: 10)),
                          Container(
                            height: MediaQuery.of(context).size.height * 0.15,
                            decoration: BoxDecoration(
                              borderRadius: BorderRadius.all(
                                const Radius.circular(8),
                              ),
                              color: Colors.black12,
                            ),
                            child: Padding(
                              padding: const EdgeInsets.all(10.0),
                              child: TextField(
                                maxLines: 4,
                                controller: noteController,
                                decoration: InputDecoration(
                                  hintText: "Enter note (Optional)",
                                  border: outlineBorder,
                                  focusedBorder: outlineBorder,
                                  enabledBorder: outlineBorder,
                                  errorBorder: outlineBorder,
                                  disabledBorder: outlineBorder,
                                ),
                              ),
                            ),
                          ),
                          Padding(
                            padding: const EdgeInsets.only(top: 10),
                            child: InkWell(
                              onTap: () {
                                if (kg > 0 && widget.currentLocation != null) {
                                  print(widget.currentLocation);
                                  Navigator.pop(context);

                                  productNameList.add(productName);
                                  productIdList.add(productId);
                                  productPriceList.add(productPrice);
                                  productImageList.add(productImage);
                                  productNoteList.add(noteController.text);
                                  weightKg.add(kg);
                                  weightPao.add(pao);
                                  setState(() {
                                    cart = true;
                                    noteController.clear();
                                    kg = 1;
                                    pao = 0;
                                  });
                                  showInformationDialog(
                                      context,
                                      shopId,
                                      productNameList,
                                      productIdList,
                                      productPriceList,
                                      productImageList,
                                      productNoteList,
                                      location);
                                } else {
                                  if (kg == 0 && pao == 0) {
                                    Fluttertoast.showToast(
                                        msg: "Please select a Quantity");
                                  }
                                  // if (widget.currentLocation.isNotEmpty) {
                                  //   Fluttertoast.showToast(
                                  //       msg: "Please give address information");
                                  // }
                                }
                              },
                              child: Container(
                                height:
                                    MediaQuery.of(context).size.height * 0.07,
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
                                      mainAxisAlignment:
                                          MainAxisAlignment.center,
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
              ),
            ),
          );
        });
  }

  Future<void> showInformationDialog(
      BuildContext context,
      String shopId,
      List<String> productName,
      List<String> productId,
      List<int> productPrice,
      List<String> productImage,
      List<String> productNote,
      String location) async {
    return await showDialog(
        context: context,
        builder: (context) {
          return AlertDialog(
            backgroundColor: Colors.transparent,
            elevation: 0,
            content: Container(
              height: MediaQuery.of(context).size.height * 0.40,
              child: Stack(
                children: [
                  Container(
                    height: MediaQuery.of(context).size.height * 0.35,
                    decoration: BoxDecoration(
                        color: Colors.white,
                        borderRadius: BorderRadius.circular(20)),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Column(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            SizedBox(
                              height: 10,
                            ),
                            Image.asset(
                              ImageDirectory.imgDirectory + "cartgreenIcon.png",
                              scale: 3,
                            ),
                            Padding(
                              padding: const EdgeInsets.only(top: 10),
                              child: Text(
                                "Successfully",
                                style: TextStyle(
                                    color: Colors.green,
                                    fontWeight: FontWeight.bold,
                                    fontSize: 18),
                              ),
                            ),
                            Padding(
                              padding: const EdgeInsets.only(top: 2),
                              child: Text(
                                "added to cart",
                                style: TextStyle(
                                    color: Colors.green,
                                    fontWeight: FontWeight.bold,
                                    fontSize: 18),
                              ),
                            ),
                          ],
                        ),
                      ],
                    ),
                  ),
                  Align(
                      alignment: Alignment.bottomCenter * 0.9,
                      child: ElevatedButton(
                        onPressed: () {
                          print(location);
                          noteController.clear();
                          Navigator.push(
                              context,
                              MaterialPageRoute(
                                  builder: (context) => Cart(
                                        productName: productName,
                                        shopId: shopId,
                                        productPrice: productPrice,
                                        location: location,
                                        productId: productId,
                                        productImage: productImage,
                                        kilo: weightKg,
                                        pao: weightPao,
                                        productNote: productNote,
                                        userName: widget.userName,
                                        lat: widget.lat,
                                        long: widget.long,
                                      ))).whenComplete(() {
                            kg = 1;
                            pao = 0;
                          });
                        },
                        child: Text(
                          "Check out now",
                          style: TextStyle(
                              fontWeight: FontWeight.bold, fontSize: 16),
                        ),
                        style: ElevatedButton.styleFrom(
                            primary: Colors.amber,
                            onPrimary: Colors.black,
                            minimumSize: Size(120, 50),
                            shape: RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(15))),
                      )),
                  Align(
                      alignment: Alignment.topCenter * 0.9,
                      child: ElevatedButton(
                        onPressed: () {
                          print(location);
                          noteController.clear();
                          kg = 1;
                          pao = 0;
                          Navigator.pop(context);
                        },
                        child: Text(
                          "X",
                          style: TextStyle(
                              fontWeight: FontWeight.bold, fontSize: 16),
                        ),
                      )),
                ],
              ),
            ),
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
                    imageUrl: widget.shopPhoto,
                    fit: BoxFit.fitWidth,
                    progressIndicatorBuilder:
                        (context, url, downloadProgress) => Center(
                            child: CircularProgressIndicator(
                                value: downloadProgress.progress)),
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
                            ImageDirectory.imgDirectory + "backIcon.png",
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
                      style:
                          TextStyle(fontSize: 30, fontWeight: FontWeight.bold),
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
                            ImageDirectory.imgDirectory + "star.png",
                            scale: 2.3,
                          ),
                          Text(
                            "4.6",
                            style: TextStyle(fontWeight: FontWeight.bold),
                          ),
                          Padding(
                            padding: const EdgeInsets.only(left: 35),
                            child: Image.asset(
                              ImageDirectory.imgDirectory + "clock.png",
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
                      height: MediaQuery.of(context).size.height * 0.6,
                      child: StreamBuilder<QuerySnapshot>(
                          stream: FirebaseFirestore.instance
                              .collection("Shop Users")
                              .doc(widget.shopID)
                              .collection('Shop Menus')
                              .snapshots(),
                          builder: (context, snapshot) {
                            if (!snapshot.hasData ||
                                snapshot.data.docs.length == 0) {
                              return Center(
                                child: Text("This shop has no Menus!"),
                              );
                            }
                            if (snapshot.connectionState ==
                                ConnectionState.waiting) {
                              return Center(child: CircularProgressIndicator());
                            }
                            return ListView.builder(
                              shrinkWrap: true,
                              itemCount: snapshot.data.docs.length,
                              padding: EdgeInsets.symmetric(
                                  vertical: 10, horizontal: 0),
                              itemBuilder: (context, index) {
                                String menuName =
                                    snapshot.data.docs[index]["Menu Name"];
                                String menuId = snapshot.data.docs[index].id;
                                int menuPrice = int.parse(
                                    snapshot.data.docs[index]["Menu Amount"]);
                                String menuImage =
                                    snapshot.data.docs[index]["Menu Image"];
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
                                          _showModalBottomSheet(
                                              context,
                                              widget.shopID,
                                              menuName,
                                              menuId,
                                              menuPrice,
                                              menuImage,
                                              noteController.text,
                                              widget.currentLocation);
                                        },
                                        child: Row(
                                          children: [
                                            ClipRRect(
                                              child: CachedNetworkImage(
                                                height: 100,
                                                width: 125,
                                                imageUrl: menuImage,
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
                                                    menuName,
                                                    style: TextStyle(
                                                      fontSize: 16,
                                                      color: Colors.black45,
                                                    ),
                                                  ),
                                                  Text(
                                                    "$menuPrice Rs/kilo",
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
                          }),
                    ),
                  ],
                ),
              ),
            ],
          )),
        ),
        floatingActionButton: cart
            ? FloatingActionButton(
                child: Text(productNameList.length.toString()),
                onPressed: () {
                  print(productNameList);
                },
              )
            : null,
      ),
    );
  }

  @override
  void initState() {
    kg = 1;
    pao = 0;
    cart = false;
    noteController.clear();
    productNameList.clear();
    productNoteList.clear();
    productPriceList.clear();
    productIdList.clear();
    productImageList.clear();

    super.initState();
  }

// var locationMessage = "";
// String _currentAddress = "";
// final geo = Geoflutterfire();
// GeoFirePoint myLocation;
//
// Future fetchCurrentLocation() async {
//   var position = await Geolocator.getCurrentPosition(
//       desiredAccuracy: LocationAccuracy.high);
//   var longitude = position.longitude, latitude = position.latitude;
//   List<Placemark> placemarks =
//   await placemarkFromCoordinates(latitude, longitude);
//   Placemark place = placemarks[0];
//
//   setState(() {
//     locationMessage = "$latitude , $longitude";
//     _currentAddress =
//     "${place.street}, ${place.locality},${place.administrativeArea}, ${place.country}";
//     myLocation = geo.point(
//       latitude: latitude,
//       longitude: longitude,
//     );
//     print(locationMessage);
//     print(_currentAddress);
//   });
// }
}
