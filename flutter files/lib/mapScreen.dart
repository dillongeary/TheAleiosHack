import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_map/flutter_map.dart';
import 'package:flutter_map/plugin_api.dart';
import 'package:latlong2/latlong.dart';
class mapScreen extends StatefulWidget {


mapScreen(
{Key? key})
    : super(key: key);

@override
State<mapScreen> createState() => mapScreenState();
}

class mapScreenState extends State<mapScreen> {

  @override
  Widget build(BuildContext context) {
    return Scaffold();
  }
    /*
    return FlutterMap(
      options: MapOptions(
        center: LatLng(51.509364, -0.128928),
        zoom: 9.2,
      ),
      nonRotatedChildren: [
        AttributionWidget.defaultWidget(
          source: 'OpenStreetMap contributors',
          onSourceTapped: null,
        ),
      ],

      children: [
        TileLayer(
          urlTemplate: 'https://tile.openstreetmap.org/{z}/{x}/{y}.png',
          userAgentPackageName: 'com.example.app',
        ),
      ],
    );


  }

     */

}


