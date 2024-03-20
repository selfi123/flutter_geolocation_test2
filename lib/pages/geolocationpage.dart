import 'package:geocoding/geocoding.dart';
import 'package:geolocator/geolocator.dart';

class GeolocationApp {
  Position? _currentLocation;
  late bool servicePermission = false;
  late LocationPermission permission;

  Future<void> getCurrentLocation() async {
    servicePermission = await Geolocator.isLocationServiceEnabled();
    if (!servicePermission) {
      print("Service disabled");
    }
    permission = await Geolocator.checkPermission();
    if (permission == LocationPermission.denied) {
      permission = await Geolocator.requestPermission();
    }
    try {
      _currentLocation = await Geolocator.getCurrentPosition();
      await _getAddressFromCoordinates();
    } catch (e) {
      print("Error getting location: $e");
      throw Exception("Failed to get current location");
    }
  }

  Future<void> _getAddressFromCoordinates() async {
    try {
      List<Placemark> placemarks = await placemarkFromCoordinates(
        _currentLocation!.latitude,
        _currentLocation!.longitude,
      );
      Placemark place = placemarks[0];
      print("${place.locality}, ${place.country}");
    } catch (e) {
      print(e);
    }
  }
}
