import 'dart:async';
import 'package:data_base/config/app_color.dart';
import 'package:data_base/utils/data_base.dart';
import 'package:data_base/utils/shared_prefs.dart';
import "package:geolocator/geolocator.dart";
import 'package:flutter/material.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';

class MapView extends StatefulWidget {
  const MapView({super.key, required this.service, this.list});
  // ignore: prefer_typing_uninitialized_variables
  final list;
  final ItemService service;

  @override
  State<MapView> createState() => _MapViewState();
}

class _MapViewState extends State<MapView> {
  late GoogleMapController mapController;
  String userId = "";
  int id = 0;
  final DateTime _dateTime = DateTime.now();
  final Set<Polyline> _polyline = {};
  LatLng _currentPosition = const LatLng(11.171829, 78.861669);

  // ignore: no_leading_underscores_for_local_identifiers
  onAdd(String lat, String long, int _id, String dateTime) {
    debugPrint('Adding $id');
    if (widget.service.addData(_id, userId, lat, long, dateTime)) {
      debugPrint('Added $dateTime');
    } else {
      debugPrint('Something went wrong while adding $lat');
    }
  }

  void _onMapCreated(GoogleMapController controller) {
    mapController = controller;
  }

  Set<Marker> infoMarker = {};

  googleMap() {
    return GoogleMap(
      myLocationEnabled: true,
      myLocationButtonEnabled: true,
      zoomControlsEnabled: false,
      compassEnabled: true,
      polylines: _polyline,
      onMapCreated: _onMapCreated,
      initialCameraPosition: CameraPosition(
        target: _currentPosition,
        zoom: 10.0,
      ),
      markers: infoMarker,
      onLongPress: (arg) {},
    );
  }

  getLocation() async {
    LocationPermission requestPermission;
    requestPermission = await Geolocator.requestPermission();

    LocationPermission permission = await Geolocator.checkPermission();
    if (permission == LocationPermission.denied ||
        permission == LocationPermission.deniedForever) {
      requestPermission;
    } else {
      Position position = await Geolocator.getCurrentPosition(
          desiredAccuracy: LocationAccuracy.high);
      double lat = position.latitude;
      double long = position.longitude;

      LatLng location = LatLng(lat, long);

      setState(() {
        _currentPosition = location;
        mapController.animateCamera(CameraUpdate.newCameraPosition(
            CameraPosition(target: location, zoom: 16)));
      });
    }
  }

  @override
  void initState() {
    super.initState();

    getLocation();
    setState(() {
      userId = SharedPrefs.getUserToken ?? "";
      // ignore: unused_local_variable
      Timer mytimer = Timer.periodic(const Duration(seconds: 5), (timer) async {
        Position position = await Geolocator.getCurrentPosition(
            desiredAccuracy: LocationAccuracy.high);
        double lat = position.latitude;
        double long = position.longitude;
        id = widget.service.getDatum().length;
        onAdd("$lat", "$long", id + 1, "$_dateTime");
      });
    });
  }

  @override
  Widget build(BuildContext context) {
    return Stack(
      children: [
        googleMap(),
        Positioned(
          right: 30,
          bottom: 30,
          child: Card(
            shadowColor: AppColor.black,
            elevation: 50,
            color: AppColor.white,
            child: IconButton(
                onPressed: () async {
                  Position position = await Geolocator.getCurrentPosition(
                      desiredAccuracy: LocationAccuracy.high);
                  double lat = position.latitude;
                  double long = position.longitude;
                  id = widget.service.getDatum().length;
                  onAdd("$lat", "$long", id + 1, "$_dateTime");
                },
                icon: const Icon(
                  Icons.add_location_alt,
                  color: AppColor.buttonColor,
                )),
          ),
        ),
      ],
    );
  }
}
