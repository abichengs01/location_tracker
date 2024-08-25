import 'package:data_base/config/app_color.dart';
import 'package:data_base/config/app_const.dart';
import 'package:data_base/utils/data_base.dart';
import 'package:flutter/material.dart';
import 'package:geolocator/geolocator.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:intl/intl.dart';

class PolylinePage extends StatefulWidget {
  const PolylinePage({super.key, required this.service, required this.data});
  final ItemService service;
  // ignore: prefer_typing_uninitialized_variables
  final data;

  @override
  State<PolylinePage> createState() => _PolylinePageState();
}

class _PolylinePageState extends State<PolylinePage> {
  final Set<Polyline> _polyline = {};
  final LatLng _currentPosition = const LatLng(11.171829, 78.861669);
  late GoogleMapController mapController;
  List<LatLng> latLong = [];

  void _onMapCreated(GoogleMapController controller) {
    mapController = controller;
  }

  Set<Marker> infoMarker = {};

  googleMap() {
    return GoogleMap(
      myLocationEnabled: true,
      myLocationButtonEnabled: false,
      zoomControlsEnabled: false,
      compassEnabled: true,
      polylines: _polyline,
      onMapCreated: _onMapCreated,
      initialCameraPosition: CameraPosition(
        target: _currentPosition,
        zoom: 5.0,
      ),
      markers: infoMarker,
      onLongPress: (arg) {},
    );
  }

  marker() {
    for (var i in widget.data) {
      latLong.add(LatLng(double.parse(i.lat), double.parse(i.long)));

      _polyline.add(Polyline(
        polylineId: const PolylineId('1'),
        points: latLong,
        color: Colors.green,
      ));

      infoMarker.add(Marker(
        markerId: MarkerId("${i.id}"),
        position: LatLng(double.parse(i.lat), double.parse(i.long)),
        infoWindow: InfoWindow(
          title: DateFormat('dd-MM-yyyy  hh:mm a')
              .format(DateTime.parse(i.dateTime)),
        ),
      ));
    }
  }

  getlocation() async {
    Position position = await Geolocator.getCurrentPosition(
        desiredAccuracy: LocationAccuracy.high);
    double lat = position.latitude;
    double long = position.longitude;
    LatLng location = LatLng(lat, long);
    setState(() {
      mapController.animateCamera(CameraUpdate.newCameraPosition(
          CameraPosition(target: location, zoom: 10)));
    });
  }

  @override
  void initState() {
    super.initState();
    // ignore: unused_local_variable
    for (var i in widget.data) {
      marker();
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      floatingActionButton: FloatingActionButton(
        backgroundColor: AppColor.white,
        onPressed: () {
          getlocation();
        },
        child: const Icon(Icons.my_location_outlined),
      ),
      appBar: PreferredSize(
          preferredSize:
              Size.fromHeight(MediaQuery.of(context).size.height * 0.04),
          child: AppBar(
            title: const Text(AppString.appName),
          )),
      body: SizedBox(
        width: MediaQuery.of(context).size.width,
        height: MediaQuery.of(context).size.height * 0.94,
        child: Column(
          children: [Expanded(child: googleMap())],
        ),
      ),
    );
  }
}
