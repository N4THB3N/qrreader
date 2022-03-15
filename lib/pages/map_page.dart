import 'dart:async';

import 'package:flutter/material.dart';
import 'package:qrreader/providers/db_provider.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';

class MapPage extends StatefulWidget {
  @override
  State<MapPage> createState() => _MapPageState();
}

class _MapPageState extends State<MapPage> {
  @override
  Widget build(BuildContext context) {
    final ScanModel scan =
        ModalRoute.of(context)?.settings.arguments as ScanModel;

    Completer<GoogleMapController> _controller = Completer();
    MapType mapType = MapType.normal;

    final CameraPosition initialPoint =
        CameraPosition(target: scan.getLatLng(), zoom: 17, tilt: 50);

    // Marcadores
    Set<Marker> markers = new Set<Marker>();
    markers.add(new Marker(
        markerId: MarkerId('geo-location'), position: scan.getLatLng()));

    return Scaffold(
      appBar: AppBar(
        title: const Text('Map'),
        actions: [
          IconButton(
              onPressed: () async {
                final GoogleMapController controller = await _controller.future;
                controller.animateCamera(CameraUpdate.newCameraPosition(
                    CameraPosition(
                        zoom: 17.5, tilt: 50, target: scan.getLatLng())));
              },
              icon: Icon(Icons.location_disabled))
        ],
      ),
      body: GoogleMap(
        markers: markers,
        myLocationButtonEnabled: false,
        mapType: mapType,
        initialCameraPosition: initialPoint,
        onMapCreated: (GoogleMapController controller) {
          _controller.complete(controller);
        },
      ),
      floatingActionButton: FloatingActionButton(
        child: Icon(Icons.layers),
        onPressed: () {
          if (mapType == MapType.normal) {
            mapType = MapType.satellite;
          } else {
            mapType = MapType.normal;
          }

          setState(() {});
        },
      ),
    );
  }
}
