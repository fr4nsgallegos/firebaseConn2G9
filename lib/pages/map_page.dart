import 'package:flutter/material.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';

class MapPage extends StatefulWidget {
  @override
  State<MapPage> createState() => _MapPageState();
}

class _MapPageState extends State<MapPage> {
  Set<Marker> _markers = {};
  BitmapDescriptor? _customMarker;

  Future<void> _setCustomMarker() async {
    _customMarker = await BitmapDescriptor.fromAssetImage(
        ImageConfiguration(
          size: Size(100, 100),
        ),
        "assets/markers/orange.png");

    _markers.add(
      Marker(
        markerId: MarkerId("002"),
        position: LatLng(
          -12.156056726143506,
          -76.97245352927253,
        ),
        icon: _customMarker!,
      ),
    );
    setState(() {});
  }

  @override
  void initState() {
    super.initState();
    _setCustomMarker();
  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        floatingActionButton: FloatingActionButton(onPressed: () {
          _markers.forEach((e) => print(e));
        }),
        body: GoogleMap(
          initialCameraPosition: CameraPosition(
            target: LatLng(
              -12.156056726143506,
              -76.97245352927253,
            ),
            zoom: 18,
          ),
          onTap: (LatLng position) {
            print(position);
            _markers.add(
              Marker(
                markerId: MarkerId(
                  _markers.length.toString(),
                ),
                position: position,
              ),
            );
            setState(() {});
          },
          markers: _markers,
          //  {
          //   Marker(
          //     markerId: MarkerId("01"),
          //     position: LatLng(
          //       -12.156056726143506,
          //       -76.97245352927253,
          //     ),
          //   ),
          // },
        ),
      ),
    );
  }
}
