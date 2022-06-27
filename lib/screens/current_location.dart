import 'dart:collection';

import 'package:dagnosis_and_prediction/db/db_helper.dart';
import 'package:dagnosis_and_prediction/model/registration_model.dart';
import 'package:flutter/material.dart';
import 'package:geolocator/geolocator.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';

class MyCurrentLocation extends StatefulWidget {
  final String email;
  const MyCurrentLocation({Key? key, required this.email}) : super(key: key);

  @override
  _CurrentLocationScreenState createState() => _CurrentLocationScreenState();
}

class _CurrentLocationScreenState extends State<MyCurrentLocation> {
  late GoogleMapController googleMapController;
  String? latitude;
  String? longitude;

  var myMarkers = HashSet<Marker>(); // Markers

  getLatlong() async {
    //print("ddddddddddddddddddddddd");
    Registration? userlocation = await DBHelper.getuserLocation(widget.email);
    latitude = userlocation?.latitude;
    longitude = userlocation?.longitude;
    return userlocation;
  }

  @override
  void initState() {
    super.initState();
    getLatlong();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("User current location"),
        centerTitle: true,
      ),
      body: FutureBuilder(
          future: getLatlong(),
          builder: (context, snapshot) {
            print('eeeeeeeee$latitude');
            if (snapshot.hasData) {
              return GoogleMap(
                initialCameraPosition: CameraPosition(
                  target: LatLng(
                    // 29.982743,
                    // 31.153599,
                    double.parse(latitude!),
                    double.parse(longitude!),
                  ),
                  zoom: 16,
                ),
                onMapCreated: (GoogleMapController googleMapController) {
                  setState(
                    () {
                      myMarkers.add(
                        Marker(
                          markerId: const MarkerId('1'),
                          position: LatLng(
                            double.parse(latitude!),
                            double.parse(longitude!),
                          ),
                        ),
                      );
                    },
                  );
                },
                markers: myMarkers,
              );
            }
            return const Center(
              child: CircularProgressIndicator(),
            );
          }),
    );
  }

  Future<Position> _determinePosition() async {
    bool serviceEnabled;
    LocationPermission permission;

    serviceEnabled = await Geolocator.isLocationServiceEnabled();

    if (!serviceEnabled) {
      return Future.error('Location services are disabled');
    }

    permission = await Geolocator.checkPermission();

    if (permission == LocationPermission.denied) {
      permission = await Geolocator.requestPermission();

      if (permission == LocationPermission.denied) {
        return Future.error("Location permission denied");
      }
    }

    if (permission == LocationPermission.deniedForever) {
      return Future.error('Location permissions are permanently denied');
    }

    Position position = await Geolocator.getCurrentPosition();

    return position;
  }
}
