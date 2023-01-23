import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:get/get.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:grocery_store/layouts/widgets/final_var.dart';
import 'package:geocoding/geocoding.dart' as decode;
import 'package:location/location.dart';
import 'package:rounded_loading_button/rounded_loading_button.dart';

class SelectLocation extends StatefulWidget {
  const SelectLocation({Key? key}) : super(key: key);

  @override
  State<SelectLocation> createState() => _SelectLocationState();
}

class _SelectLocationState extends State<SelectLocation> {
  LatLng _location = const LatLng(33, 44);
  String placemarks = 'un selected';
  GoogleMapController? _mapController;
  final RoundedLoadingButtonController _btncontroller =
      RoundedLoadingButtonController();

  Future getUserLocation() async {
    Location location = Location();

    PermissionStatus _permissionGranted = await location.hasPermission();
    if (_permissionGranted == PermissionStatus.denied) {
      _permissionGranted = await location.requestPermission();
      if (_permissionGranted != PermissionStatus.granted) {
        return;
      }
    }

    LocationData _locationData = await location.getLocation();
    List<decode.Placemark> pleaces = await decode.placemarkFromCoordinates(
        _locationData.latitude!, _locationData.longitude!);
    setState(
      () {
        _location = LatLng(_locationData.latitude!, _locationData.longitude!);
        if (_mapController != null) {
          _mapController!.moveCamera(
            CameraUpdate.newCameraPosition(
              CameraPosition(
                target: _location,
                zoom: 14,
              ),
            ),
          );
          placemarks = pleaces.first.name!;
        }
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Stack(
        children: [
          Positioned(
            left: 0,
            right: 0,
            bottom: 0,
            top: 0,
            child: SizedBox(
              width: double.infinity,
              height: double.infinity,
              child: GoogleMap(
                onMapCreated: (controller) {
                  _mapController = controller;
                },
                initialCameraPosition: CameraPosition(
                  target: _location,
                  zoom: 14,
                ),
                onTap: (location) {
                  setState(() {
                    _location = location;
                  });
                },
                onCameraMove: (pos) async {
                  setState(() {
                    _location = pos.target;
                  });
                },
                myLocationButtonEnabled: true,
                myLocationEnabled: true,
                markers: <Marker>{
                  Marker(
                    infoWindow: InfoWindow(title: placemarks),
                    markerId: const MarkerId('location'),
                    position: _location,
                    onTap: () async {
                      var a = await decode.placemarkFromCoordinates(
                          _location.latitude, _location.longitude);
                      setState(() {
                        placemarks = a.first.street!;
                      });
                    },
                  ),
                },
              ),
            ),
          ),
          Positioned(
            bottom: 10,
            left: 0,
            right: 0,
            child: SizedBox(
              width: double.infinity,
              child: RoundedLoadingButton(
                color: color,
                controller: _btncontroller,
                onPressed: () {
                  Get.back<LatLng>(result: _location);
                },
                child: const Text('Set Location'),
              ),
            ),
          )
        ],
      ),
    );
  }

  @override
  void initState() {
    getUserLocation();
    super.initState();
  }
}
