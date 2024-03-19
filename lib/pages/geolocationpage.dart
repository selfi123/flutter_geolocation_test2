import 'package:flutter/material.dart';
import 'package:geocoding/geocoding.dart';
import 'package:geolocator/geolocator.dart';

class GeolocationApp extends StatefulWidget {
  const GeolocationApp({super.key});

  @override
  State<GeolocationApp> createState() => _GeolocationAppState();
}



class _GeolocationAppState extends State<GeolocationApp> {

  Position? _currentLocation;
  late bool servicePermission = false;
  late LocationPermission permission;
  String _currentAdress = "";

  Future<Position> _getCurrentLocation() async {
    servicePermission = await Geolocator.isLocationServiceEnabled();
    if (!servicePermission) {
      print("Service disabled");
    }
    permission = await Geolocator.checkPermission();
    if (permission == LocationPermission.denied) {
      permission = await Geolocator.requestPermission();
    }
    try {
      return await Geolocator.getCurrentPosition();
    } catch (e) {
      print("Error getting location: $e");
      throw Exception("Failed to get current location"); // Throw an exception
    }
  }

  _getAdrressFromCoordinates() async {
    try {
      List<Placemark>placemarks = await placemarkFromCoordinates(
          _currentLocation!.latitude, _currentLocation!.longitude);
      Placemark place = placemarks[0];
      setState(() {
        _currentAdress = "${place.locality}, ${place.country}";
      });
    }
    catch (e) {
      print(e);
    }
  }



  @override
  Widget build(BuildContext context) {

    return Scaffold(
      appBar: AppBar(
        title: const Text('Geolocation1'),
        centerTitle: true,
        backgroundColor: Colors.blue,
        foregroundColor: Colors.black87,

      ),
      body: Center(child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          const Text("Location coordinates",
            style: TextStyle(
              fontSize: 24,
              fontWeight: FontWeight.bold,
            ),
          ),
          const SizedBox(
            height: 6,
          ),
          Text("Latitude= ${_currentLocation
              ?.latitude} ; Longitude = ${_currentLocation?.longitude}; "),
          const SizedBox(
            height: 30.0,
          ),
          const Text("Location address",
            style: TextStyle(
              fontSize: 24,
              fontWeight: FontWeight.bold,
            ),
          ),
          const SizedBox(
            height: 6,
          ),
          Text("${_currentAdress} "),
          const SizedBox(height: 50.0,),
          ElevatedButton(onPressed: () async {
            _currentLocation = await _getCurrentLocation();
            await _getAdrressFromCoordinates();

            print("${_currentLocation}");
            print("${_currentAdress}");
          }, child: const Text("get location"),

          ),

          ElevatedButton(
            onPressed: () {
              Navigator.pop(context); // Navigate back to HomePage
            },
            child: Text('Go Back'),
          ),
        ],
      )),
    );
  }
}