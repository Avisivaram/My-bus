import 'dart:async';

import 'package:firebase_database/firebase_database.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:geolocator/geolocator.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';

class Map extends StatefulWidget{
  @override
  MapState createState() => MapState();
}

class MapState extends State<Map> {
  var iconBase = 'https://maps.google.com/mapfiles/kml/shapes/';
  final TextEditingController _searchController = TextEditingController();
  Completer<GoogleMapController> _controller = Completer();
  GoogleMapController control;
  var geo=Geolocator.getPositionStream(desiredAccuracy: LocationAccuracy.high,distanceFilter: 15);
  LatLng _center = LatLng(45.521563, -122.677433);
  List<Marker> _markers=<Marker>[];
  BitmapDescriptor currentLocation;
  final fb = FirebaseDatabase.instance;
  void _onMapCreated(GoogleMapController controller) {
    control=controller;
    _controller.complete(controller);
    geo.listen((Position position) {
      LatLng current= LatLng(position.latitude,position.longitude);
      control.animateCamera(CameraUpdate.newCameraPosition(CameraPosition(target: current,zoom: 15.0)));
    });
  }
  @override
  void initState() {
    super.initState();
  }
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Stack(
        children: [
          GoogleMap(
            myLocationEnabled: true,
            onMapCreated: _onMapCreated,
            initialCameraPosition: CameraPosition(target: _center, zoom: 15.0,),
              markers: Set<Marker>.of(_markers),
              gestureRecognizers: <Factory<OneSequenceGestureRecognizer>>[
                new Factory<OneSequenceGestureRecognizer>(() => new EagerGestureRecognizer(),),
              ].toSet()
          ),
          Container(
            width: double.infinity,
            margin: EdgeInsets.symmetric(vertical: 50,horizontal: 20),
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(10),
              color: Colors.white,
            ),
            child: Padding(
              padding: EdgeInsets.only(left: 30.0),
              child: TextFormField(
                decoration: InputDecoration(
                    border: InputBorder.none,
                    hintText: "  Search for Buses",
                    suffixIcon: IconButton(
                      color: Color(0xff00466b),
                      onPressed: () {
                        String s=_searchController.text;
                        getData(s);
                      },
                      icon: Icon(Icons.search_outlined),)
                ),
                style: TextStyle(
                    fontSize: 20
                ),
                controller: _searchController,
              ),
            )
          )
        ],
      )
    );
  }
  Future<void> getData(String s) async {
    final ref = fb.reference();
    await ref.child("Location").child(s).once().then((value) {
      setState(() {
        print(value);
      });
    });
  }
}