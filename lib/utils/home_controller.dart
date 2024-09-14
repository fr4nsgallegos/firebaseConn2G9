import 'package:firebaseconn2g9/utils/map_style.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';

class HomeController {
  void onMapCreated(GoogleMapController mapController) {
    mapController.setMapStyle(mapStyle);
  }
}
