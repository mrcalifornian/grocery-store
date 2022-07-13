import 'package:flutter/material.dart';
import 'package:geocoding/geocoding.dart';
import 'package:geolocator/geolocator.dart';
import 'package:grocery_store/providers/home_provider.dart';
import 'package:grocery_store/ui/home_page/widgets/banner_item.dart';
import 'package:grocery_store/ui/home_page/widgets/bestselling_items.dart';
import 'package:grocery_store/ui/home_page/widgets/exclusive_items.dart';
import 'package:grocery_store/ui/home_page/widgets/recommended_grocery.dart';
import 'package:provider/provider.dart';

import '../no_internet.dart';

class HomePage extends StatefulWidget {
  const HomePage({Key? key}) : super(key: key);

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  late String address;
  late List<Placemark> placemark;
  bool isLoadingLocation = false;

  Future<Position> _determinePosition() async {
    bool serviceEnabled;
    LocationPermission permission;
    serviceEnabled = await Geolocator.isLocationServiceEnabled();
    if (!serviceEnabled) {
      await Geolocator.openLocationSettings();
      return Future.error('Location services are disabled.');
    }

    permission = await Geolocator.checkPermission();
    if (permission == LocationPermission.denied) {
      permission = await Geolocator.requestPermission();
      if (permission == LocationPermission.denied) {
        return Future.error('Location permissions are denied');
      }
    }

    if (permission == LocationPermission.deniedForever) {
      return Future.error(
          'Location permissions are permanently denied, we cannot request permissions.');
    }
    return await Geolocator.getCurrentPosition();
  }

  @override
  void initState() {
    setState(() {
      isLoadingLocation = true;
    });
    Future.delayed(Duration.zero).then((value) async {
      Position position = await _determinePosition();
      placemark =
          await placemarkFromCoordinates(position.latitude, position.longitude);
    }).then((value) {
      address =
          "${placemark[0].subAdministrativeArea}, ${placemark[0].administrativeArea}";
      setState(() {
        isLoadingLocation = false;
      });
    });
    super.initState();
  }

  @override
  void didChangeDependencies() {
    Provider.of<HomeProvider>(context, listen: false)
        .checkInternet()
        .then((value) {
    }).catchError((error) {
      Navigator.pushReplacementNamed(context, NoInternet.routeName);
    });
    super.didChangeDependencies();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        elevation: 0,
        title: Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            const Icon(Icons.location_on),
            Text(
              isLoadingLocation ? "Loading..." : address,
              style: Theme.of(context).textTheme.titleMedium,
            ),
          ],
        ),
      ),
      body: SingleChildScrollView(
              physics: const BouncingScrollPhysics(),
              child: Column(
                children: const [
                  BannerItem(),
                  ExclusiveItems(),
                  BestSellingItems(),
                  RecommendedGrocery(),
                ],
              ),
            ),
    );
  }
}
