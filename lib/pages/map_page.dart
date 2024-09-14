import 'package:flutter/material.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';

class MapPage extends StatelessWidget {
  Set<Marker> _markers = {};
  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
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
                markerId: MarkerId("01"),
                position: position,
              ),
            );
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
