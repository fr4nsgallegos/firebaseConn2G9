import 'dart:convert';

const _mapStyle = [
  {
    "featureType": "landscape",
    "stylers": [
      {"hue": "#00dd00"}
    ]
  },
  {
    "featureType": "road",
    "stylers": [
      {"hue": "#dd0000"}
    ]
  },
  {
    "featureType": "water",
    "stylers": [
      {"hue": "#000040"}
    ]
  },
  {
    "featureType": "poi.park",
    "stylers": [
      {"visibility": "off"}
    ]
  },
  {
    "featureType": "road.arterial",
    "stylers": [
      {"hue": "#ffff00"}
    ]
  },
  {
    "featureType": "road.local",
    "stylers": [
      {"visibility": "off"}
    ]
  }
];

final mapStyle = jsonEncode(_mapStyle);
