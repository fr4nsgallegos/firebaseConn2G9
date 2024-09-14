import 'package:custom_info_window/custom_info_window.dart';
import 'package:flutter/material.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';

class MapPage2 extends StatefulWidget {
  @override
  State<MapPage2> createState() => _MapPage2State();
}

class _MapPage2State extends State<MapPage2> {
  Set<Marker> _markers = {};
  CustomInfoWindowController _customInfoWindowController =
      CustomInfoWindowController();

  Future addMarkers() async {
    Set<Marker> auxMarkers = Set();
    LatLng pos1 = LatLng(-12.156127397452977, -76.97236155069054);
    LatLng pos2 = LatLng(-12.156464160749644, -76.97297716314061);
    LatLng pos3 = LatLng(-12.157171985918293, -76.97173955883682);

    BitmapDescriptor designBit1 = await BitmapDescriptor.fromAssetImage(
        ImageConfiguration(size: Size(94, 94)), "assets/markers/orange.png");
    BitmapDescriptor designBit2 = await BitmapDescriptor.fromAssetImage(
        ImageConfiguration(size: Size(94, 94)), "assets/markers/blue.png");
    BitmapDescriptor designBit3 = await BitmapDescriptor.fromAssetImage(
        ImageConfiguration(size: Size(94, 94)), "assets/markers/green.png");

    auxMarkers.add(
      Marker(
        markerId: MarkerId("1"),
        position: pos1,
        icon: designBit1,
        onTap: () {
          _customInfoWindowController.addInfoWindow!(
            Container(
              height: 200,
              width: 200,
              color: Colors.red,
            ),
            pos1,
          );
        },
      ),
    );
    auxMarkers.add(
      Marker(
        markerId: MarkerId("2"),
        position: pos2,
        icon: designBit2,
      ),
    );

    _markers = auxMarkers;
    setState(() {});
  }

  @override
  void initState() {
    super.initState();
    addMarkers();
  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        floatingActionButton: FloatingActionButton(onPressed: () {
          _markers.forEach((e) => print(e));
        }),
        body: Stack(
          children: [
            GoogleMap(
              onMapCreated: (GoogleMapController controller) {
                _customInfoWindowController.googleMapController = controller;
              },
              initialCameraPosition: CameraPosition(
                target: LatLng(
                  -12.156056726143506,
                  -76.97245352927253,
                ),
                zoom: 18,
              ),
              onTap: (LatLng position) {
                _customInfoWindowController.hideInfoWindow!();
              },
              markers: _markers,
            ),
            CustomInfoWindow(
              controller: _customInfoWindowController,
              width: 200,
              height: 200,
            )
          ],
        ),
      ),
    );
  }
}
