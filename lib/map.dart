import 'dart:async';
import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_mobx/flutter_mobx.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:hello_lbs_flutter/city.dart';
import 'package:hello_lbs_flutter/searchlocation.dart';
import 'package:mobx/mobx.dart';
import 'package:http/http.dart' as http;
import 'package:sim_info/sim_info.dart';

class MapScreen extends StatefulWidget {

  final List<City> cities;
  MapScreen(this.cities);

  @override
  MapState createState() => MapState();

}

class MapState extends State<MapScreen> {
  Completer<GoogleMapController> _controller = Completer();

  static final CameraPosition fiapPosition = CameraPosition(
    target: LatLng(-23.595157, -46.687052),
    zoom: 14.4746,
  );

  Set<Marker> citiesMarkers = Set();

  final _searchLocation = SearchLocation();

  String mobileCountryCode;
  String mobileNetworkCode;

  @override
  void initState() {
    for (City city in widget.cities){
      citiesMarkers.add(
          Marker(
            markerId: MarkerId(city.name),
            position: LatLng(
              city.latitude,
              city.longitude,
            ), infoWindow: InfoWindow(
              title: city.name,
              snippet: city.state),
          ));
    }

    reaction((_) => _searchLocation.currentLocation, (value) {
      if (_searchLocation.currentLocation != null) {
        List<String> lacCid = _searchLocation.currentLocation.split(",");
        String lac = lacCid[0];
        String cid = lacCid[1];

        _getPosition(lac, cid);
      }
    });

    super.initState();

    _getSimInfo();
  }

  void _getPosition(String lac, String cid) async {
    Map<String, dynamic> body = {
      'cellTowers': [
        {
          'cellId': cid,
          'locationAreaCode': lac,
          'mobileCountryCode': mobileCountryCode,
          'mobileNetworkCode': mobileNetworkCode
        }
      ]
    };

    var url = 'https://www.googleapis.com/geolocation/v1/geolocate?key=AIzaSy...';
    var response = await http.post(
        url,
        headers: {
          "Accept": "application/json",
          "Content-Type": "application/x-www-form-urlencoded"
        },
        body: jsonEncode(body)
    );

    var latitude = json.decode(response.body)["location"]["lat"];
    var longitude = json.decode(response.body)["location"]["lng"];

    CameraPosition myLocation = CameraPosition(
      target: LatLng(
          latitude,
          longitude
      ), zoom: 14.4746,
    );
    _controller.future.then((controller) {
      controller.animateCamera(
          CameraUpdate.newCameraPosition(myLocation));
    });
  }

  void _getSimInfo() async {
    mobileCountryCode = await SimInfo.getMobileCountryCode;
    mobileNetworkCode = await SimInfo.getMobileNetworkCode;
  }

  @override
  Widget build(BuildContext context) {

    return Scaffold(
      body: Column(
        children: <Widget>[
          Expanded(
            child: GoogleMap(
              mapType: MapType.normal,
              initialCameraPosition: fiapPosition,
              onMapCreated: (GoogleMapController controller) {
                _controller.complete(controller);
              },
              markers: citiesMarkers,
            ),
          ),
        ],
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: (){
          _searchLocation.startSearch();
        },
        child: Icon(Icons.gps_fixed),
      ),
    );
  }

}
