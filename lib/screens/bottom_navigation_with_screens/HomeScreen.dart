
import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:geocoding/geocoding.dart';
import 'package:location/location.dart';
import 'package:mangvaeye_user/directories/ImageDirectory.dart';
import 'package:mangvaeye_user/main.dart';
import 'package:mangvaeye_user/screens/ShopMenu.dart';
import 'package:mangvaeye_user/utils/MyColors.dart';
import 'package:mangvaeye_user/utils/auth.dart';
import 'package:mangvaeye_user/widget/search_widget.dart';
import 'package:location/location.dart' as Location;
import 'package:geoflutterfire/geoflutterfire.dart';
import 'package:cloud_firestore/cloud_firestore.dart';


class HomeScreen extends StatefulWidget {
  final AuthBase auth;
  final String uid;

  const HomeScreen({Key key,@required this.auth,@required this.uid}) : super(key: key);

  @override
  _HomeScreenState createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  String address = "Enter address for delivery";
  List<Placemark> placeMarks;
  Location.Location location = new Location.Location();
   final geo = Geoflutterfire();
   final _fireStore = FirebaseFirestore.instance;

   void init(){
     //_fireStore = FirebaseFirestore.instance;
}

@override
  void initState() {
  init();

    // super.initState();
    print("init called");
    fetchCurrentLocation();
  }
  var ref = FirebaseFirestore.instance.collection("Shop Users");
   var res;
  Future<void> _signOut() async {
    try {
      await widget.auth.signOut().then((res) {
        Navigator.pushAndRemoveUntil(
            context,
            MaterialPageRoute(builder: (context) => CheckUser(auth: widget.auth)),
            ModalRoute.withName('/'));
      });
    } catch (e) {}
  }

  @override
  Widget build(BuildContext context) {
    // fetchCurrentLocation();
    return Scaffold(
      resizeToAvoidBottomInset: true,
      backgroundColor: Colors.white,
      body: SingleChildScrollView(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Stack(
              clipBehavior: Clip.antiAlias,
              children: [
                Container(
            decoration: BoxDecoration(
                      color: MyColors.APP_COLOR,
                      borderRadius: BorderRadius.only(
                          bottomLeft: Radius.circular(25.0),
                          bottomRight: Radius.circular(25.0))),
                  height: MediaQuery.of(context).size.height * 0.25,
                  width: MediaQuery.of(context).size.width,
                ),
                SizedBox(
                  height: MediaQuery.of(context).size.height * 0.29,
                  child: Image.asset(
                    ImageDirectory.imgDirectory + "topBg.png",
                    height: MediaQuery.of(context).size.height,
                    fit: BoxFit.fitHeight,
                  ),
                ),
                Padding(
                  padding:
                      const EdgeInsets.symmetric(vertical: 20, horizontal: 0),
                  child: Container(
                    padding: const EdgeInsets.only(top: 10, left: 10),
                    child: Padding(
                      padding: const EdgeInsets.symmetric(
                          horizontal: 0.0, vertical: 10),
                      child: searchbar(),
                    ),
                  ),
                ),
              ],
            ),
            Padding(
              padding: const EdgeInsets.fromLTRB(20, 0, 20, 20),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Row(
                    children: [
                      Padding(
                        padding: const EdgeInsets.symmetric(
                            horizontal: 0.0, vertical: 0.0),
                        child: Image.asset(
                          ImageDirectory.imgDirectory + "loc.png",
                          scale: 2.70,
                        ),
                      ),
                      Padding(
                        padding: EdgeInsets.only(left: 5),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(
                              "Your Address:",
                              style: TextStyle(fontSize: 13),
                            ),
                            Text("$address", style: TextStyle(fontSize: 11)),
                          ],
                        ),
                      ),

                    ],
                  ),
                  Padding(
                    padding: EdgeInsets.only(right: 10),
                    child: InkWell(

                      onTap: () {
                        // print("clicked");
                        fetchCurrentLocation();
                      },
                      child: Image.asset(
                        ImageDirectory.imgDirectory + "reload.png",
                        scale: 20,
                      ),
                    ),
                  ),
                ],
              ),
            ),
            Center(child: TextButton(onPressed: _signOut, child: Text("Signout",style: TextStyle(color: Colors.red),))),
            Padding(
              padding: const EdgeInsets.only(
                  bottom: 0.0, top: 0.0, left: 25.0, right: 0),
              child: Text(
                "Nearest Shops",
                style: TextStyle(fontSize: 17, color: Color(0xff373737)),
              ),
            ),
            SizedBox(
              height: MediaQuery.of(context).size.height * 0.55,
              width: MediaQuery.of(context).size.width,
              child: StreamBuilder(
                stream: ref.snapshots(),
                builder: (context, snapshot) {
                  if(!snapshot.hasData){
                    return Center(child: Text("No shops available.. "),);
                  }
                  if(snapshot.connectionState == ConnectionState.waiting){
                    return Center(child: CircularProgressIndicator(color:  MyColors.APP_COLOR,),);
                  }
                  snapshot.data.docs.forEach((res){
                    print(res.id); // printing document id of Shop Users
                  });
                  return ListView.builder(
                    shrinkWrap: true,
                    itemCount: snapshot.data.docs.length,
                    itemBuilder: (context, index) {

                      return GestureDetector(
                        onTap: () => goToNextScreenWithStack(context, ShopMenu(
                          shopID: snapshot.data.docs[index].id,
                          shopName: snapshot.data.docs[index]["Shop Name"],
                          shopPhoto: snapshot.data.docs[index]["Shop Image"],
                        )),
                        child: Container(
                          margin: EdgeInsets.only(bottom: 20),
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.center,
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              Padding(
                                padding: const EdgeInsets.only(
                                    bottom: 0.0, top: 0.0, left: 20.0, right: 20),
                                child: Container(
                                  height: MediaQuery.of(context).size.height/5,
                                  clipBehavior: Clip.antiAlias,
                                  decoration: BoxDecoration(
                                      borderRadius: BorderRadius.circular(15)),
                                  width: MediaQuery.of(context).size.width,
                                  child: CachedNetworkImage(
                                    imageUrl: snapshot.data.docs[index]["Shop Image"],
                                    progressIndicatorBuilder: (context, url, downloadProgress) =>
                                        Center(child: CircularProgressIndicator(value: downloadProgress.progress)),
                                    errorWidget: (context, url, error) => Icon(Icons.error),
                                    fit: BoxFit.fitWidth,
                                  ),
                                  // child: Image.asset(
                                  //   ImageDirectory.imgDirectory + "veg.png",
                                  //   width: MediaQuery.of(context).size.width,
                                  //   fit: BoxFit.fitWidth,
                                  // ),
                                ),
                              ),
                              Padding(
                                padding: const EdgeInsets.only(top: 10),
                                child: Text(
                                  snapshot.data.docs[index]["Shop Name"],
                                  style: TextStyle(
                                      fontSize: 20, fontWeight: FontWeight.bold),
                                ),
                              ),
                              Text(
                                "Estimate Delivery: 15 mint",
                                style: TextStyle(
                                    fontSize: 10, fontWeight: FontWeight.normal),
                              ),
                              Row(
                                mainAxisAlignment: MainAxisAlignment.center,
                                children: [
                                  Image.asset(
                                    ImageDirectory.imgDirectory + "star.png",
                                    scale: 3,
                                  ),
                                  Text("4.6", style: TextStyle(fontSize: 13)),
                                ],
                              ),
                              Row(
                                mainAxisAlignment: MainAxisAlignment.center,
                                children: [
                                  Image.asset(
                                    ImageDirectory.imgDirectory +
                                        "person_profile_icon.png",
                                    scale: 3,
                                  ),
                                  Text("1k+", style: TextStyle(fontSize: 13)),
                                ],
                              ),
                            ],
                          ),
                        ),
                      );
                    },
                  );
                }
              ),
            )
          ],
        ),
      ),
    );
  }

  goToNextScreenWithStack(BuildContext context, dynamic route) {
    Navigator.push(context, MaterialPageRoute(builder: (context) => route));

    Navigator.pushNamed(context, route);
  }

  Widget searchbar() =>
      SearchWidget(text: "", onChanged: search, hintText: "Search here");

  void search(String name) {}

  void fetchCurrentLocation() async {
    Location.Location location = new Location.Location();

    // print("1");
    bool _serviceEnabled;
    PermissionStatus _permissionGranted;
    LocationData _locationData;
    // print("2");
   // location.changeSettings(accuracy: LocationAccuracy.navigation);

    // _serviceEnabled = await location.serviceEnabled();
    // _permissionGranted = await location.hasPermission();
    //
    // if (_serviceEnabled && _permissionGranted == PermissionStatus.granted) {
    //   _locationData = await location.getLocation();
    //
    //
    //
    //   _getAddress(_locationData.latitude!, _locationData.longitude!);
    // } else {
    //   if (_serviceEnabled) {
    //     _permissionGranted = await location.requestPermission();
    //   } else {
    //     _serviceEnabled = await location.requestService();
    //   }
    //
    //   if (_permissionGranted == PermissionStatus.granted && _serviceEnabled) {
    //     _locationData = await location.getLocation();
    //
    //     _getAddress(_locationData.latitude!, _locationData.longitude!);
    //   } else {
    //     Fluttertoast.showToast(msg: "location is not available");
    //   }
    //
    // }
    _serviceEnabled = await location.serviceEnabled();
    if (!_serviceEnabled) {
      _serviceEnabled = await location.requestService();
      if (!_serviceEnabled) {
        return;
      }
    }

    _permissionGranted = await location.hasPermission();
    if (_permissionGranted == PermissionStatus.denied) {
      _permissionGranted = await location.requestPermission();
      if (_permissionGranted != PermissionStatus.granted) {
        return;
      }
    }
    _locationData = await location.getLocation();

    _getAddress(_locationData.latitude, _locationData.longitude);
    // print("lat "+ _locationData.latitude.toString());
    // print("long "+ _locationData.longitude.toString());


    // if (_serviceEnabled) {
    //   if (_permissionGranted == PermissionStatus.granted) {
    //     _locationData = await location.getLocation();
    //
    //     _getAddress(_locationData.latitude!, _locationData.longitude!);
    //   } else {
    //     _permissionGranted = await location.requestPermission();
    //     if (_permissionGranted == PermissionStatus.granted) {
    //       _locationData = await location.getLocation();
    //       _locationData.accuracy!.abs();
    //       _getAddress(_locationData.latitude!, _locationData.longitude!);
    //     }
    //   }
    // } else {
    //   _serviceEnabled = await location.requestService();
    //   if (_serviceEnabled) {
    //     if (_permissionGranted == PermissionStatus.granted) {
    //       _locationData = await location.getLocation();
    //
    //       _getAddress(_locationData.latitude!, _locationData.longitude!);
    //     } else {
    //       _permissionGranted = await location.requestPermission();
    //       if (_permissionGranted == PermissionStatus.granted) {
    //         _locationData = await location.getLocation();
    //
    //         _getAddress(_locationData.latitude!, _locationData.longitude!);
    //       }
    //     }
    //   }
    // }
    //
    //   _permissionGranted = await location.hasPermission();
    //   if (_permissionGranted == PermissionStatus.denied) {
    //     _permissionGranted = await location.requestPermission();
    //     if (_permissionGranted != PermissionStatus.granted) {
    //       return;
    //     }
    //   }

    // to get continious updated loc

    // location.onLocationChanged.listen((LocationData currentLocation) {
    //   setState(() {
    //     address = placeMarks[0].name! +
    //         " " +
    //         placeMarks[0].subLocality! +
    //         "," +
    //         placeMarks[0].locality!;
    //     print(address);
    //   });
    //   //  List<Placemark> placeMarks = await placemarkFromCoordinates(lat, lang);
    //   //address = placeMarks.first.name! + "\n" + placeMarks.first.street! ;
    // });

  }

  void _getAddress(double lat, double lang) async {
    //final coordinates = new Coordinates(lat, lang);
    placeMarks = await placemarkFromCoordinates(lat, lang);
    placeMarks;
    if(mounted){
      setState(() {
        address = placeMarks[0].name +
            " " +
            placeMarks[0].subLocality +
            "," +
            placeMarks[0].locality+"\n"+placeMarks[0].administrativeArea+","+placeMarks[0].subAdministrativeArea;
        // print(placeMarks);
      });
    }

    //writeGeoDateToFireStoreDb(lat,lang);
    GeoFirePoint myLocation = geo.point(latitude: lat, longitude: lang);

    _fireStore
        .collection('Shops')
        .add({'name': 'random name', 'position': myLocation.data});
    queryDataToFireStoreDb(lat, lang);

    //await List<Placemark> placemarks = await placemarkFromCoordinates(52.2165157, 6.9437819);
    // List<Address> add =
    // await Geocoder.local.findAddressesFromCoordinates(coordinates);
    // return add;
  }

  queryDataToFireStoreDb(double lat,double long){
// Create a geoFirePoint
    GeoFirePoint center = geo.point(latitude: lat, longitude: long);

// get the collection reference or query
    var collectionReference = _fireStore.collection('Shops');
//    var radius = BehaviorSubject.seeded(100.0);

    double radius = 50;
    String field = 'position';

    Stream<List<DocumentSnapshot>> stream = geo.collection(collectionRef: collectionReference)
        .within(center: center, radius: radius, field: field, strictMode: true);

    stream.listen((List<DocumentSnapshot> documentList) {
      // doSomething()

    });
  }

}
