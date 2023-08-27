import 'package:flutter/material.dart';
import 'package:foodex_app/app/utils/dimension.dart';
import 'package:foodex_app/screen/Search/search_food.dart';
import 'package:geocoding/geocoding.dart';
import 'package:geolocator/geolocator.dart';

import '../../app/constraints/api_url.dart';
import '../export_screen.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  String location = '';
  String address = '';

  Future<Position> getGeoLocationPosition() async {
    bool serviceEnabled;
    LocationPermission permission;
    permission = await Geolocator.checkPermission();
    serviceEnabled = await Geolocator.isLocationServiceEnabled();
    if (!serviceEnabled) {
      await Geolocator.openLocationSettings();
      return Future.error('Location services are disabled.');
    }
    if (permission == LocationPermission.denied) {
      permission = await Geolocator.requestPermission();
      if (permission == LocationPermission.denied) {
        return Future.error('Location permissions are denied');
      }
    }
    if (permission == LocationPermission.deniedForever) {
      // Permissions are denied forever, handle appropriately.
      return Future.error(
          'Location permissions are permanently denied, we cannot request permissions.');
    }
    return await Geolocator.getCurrentPosition(
        desiredAccuracy: LocationAccuracy.high);
  }

  Future<void> getAddressFromLatLong(Position position) async {
    List<Placemark> placemarks =
        await placemarkFromCoordinates(position.latitude, position.longitude);
    setState(() {
      Placemark place = placemarks[0];
      address =
          '${place.subLocality}, ${place.thoroughfare}, ${place.locality}, ${place.postalCode}, ${place.country}';
      getCurrentLocation = address;
    });
  }

  void setAddress() async {
    final Position position = await getGeoLocationPosition();
    setState(() {
      getAddressFromLatLong(position);
    });
  }

  @override
  void initState() {
    setAddress();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    return SafeArea(
      child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            //====================== Top Bar Start ============================================
            Padding(
              padding: EdgeInsets.only(
                  left: Dimensions.height10, right: Dimensions.height10),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  IconButton(
                    icon: Icon(Icons.location_on, size: Dimensions.iconSize24),
                    color: Colors.orange,
                    onPressed: () {
                      // final Position position = await getGeoLocationPosition();
                      // setState(() {
                      //   getAddressFromLatLong(position);
                      // });
                    },
                  ),
                  Expanded(
                    child: Text(
                      locationInfo(),
                      style: TextStyle(
                          fontSize: Dimensions.font12,
                          fontWeight: FontWeight.bold),
                    ),
                  ),
                  IconButton(
                    icon: Icon(Icons.search, size: Dimensions.iconSize24),
                    color: Colors.orange,
                    onPressed: () {
                      Navigator.push(
                          context,
                          MaterialPageRoute(
                              builder: (_) => const SearchAllFood()));
                    },
                  ),
                  IconButton(
                    icon:
                        Icon(Icons.shopping_cart, size: Dimensions.iconSize24),
                    color: Colors.orange,
                    onPressed: () {
                      Navigator.push(
                          context,
                          MaterialPageRoute(
                              builder: (_) => const CartScreen()));
                    },
                  )
                ],
              ),
            ),
            Divider(
              thickness: Dimensions.height10 - 7,
            ),

            // ============================ Top Bar End ============================

            // ======================== Special Food class Called ==================
            const Expanded(
                child: SingleChildScrollView(child: FoodListScreen())),
          ]),
    );
  }

  locationInfo() {
    if (address.isEmpty) {
      return 'Locating you..';
    } else {
      return address;
    }
  }
}
