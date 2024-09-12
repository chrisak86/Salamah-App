import 'dart:convert';
import 'dart:math';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:salamah/app/config/app_colors.dart';
import 'package:salamah/app/config/global_var.dart';
import 'package:http/http.dart' as http;
import 'package:salamah/app/models/tickets.dart';
import 'package:salamah/app/utils/utils.dart';
import 'package:salamah/data/repositories/profile_repository.dart';

class TravelTrackingController extends GetxController {

  RxInt index=1.obs;
  RequestRepository requestRepository =RequestRepository();
  GoogleMapController? mapController;
  var polylines = <Polyline>{}.obs;
  var markers = <Marker>[].obs;
  var distance = "".obs;
  var eta = "".obs;
  late BitmapDescriptor customIcon;
  late BitmapDescriptor icon1;
  LatLng? userData;
  var selectedIndex = 0.obs;
  Tickets? tickets;
  RxBool noTicket=false.obs;

  @override
  void onInit() async {
    if(Get.arguments!=null){
      index.value=Get.arguments;
    }
    super.onInit();
    await getCustomMarker();
    await fetchData("ACCIDENT");
  }

  void changeSelectedIndex(int index) {
    selectedIndex.value = index;
    switch (index) {
      case 0:
        fetchData("ACCIDENT");
        break;
      case 1:
        fetchData("AMBULANCE");
        break;
      case 2:
        fetchData("FIRETRUCK");
        break;
      default:
        fetchData("ACCIDENT");
    }
  }

  Future<void> fetchData(String type) async {
    var response;
    try {
      response = await requestRepository.getUserTicket(type: type);
      if (response != null && response["data"] != null && (response["data"] as List).isEmpty) {
        noTicket.value = true;
        update();
      } else {
        tickets = Tickets.fromJson(response["data"][0]);
        update();
      }

      if (tickets!=null && tickets?.id!=null) {
        LatLng policeStationLatLng = LatLng(tickets!.police_lat!, tickets!.police_long!);
        userData = LatLng(tickets!.user_lat!, tickets!.user_long!);
        LatLng userLatLng = LatLng(tickets!.user_lat!, tickets!.user_long!);
        distance.value = tickets?.distance ?? '';
        eta.value = tickets?.ETA ?? '';

        polylines.clear();
        polylines.add(
          Polyline(
            polylineId: PolylineId('route1'),
            points: [userLatLng, policeStationLatLng],
            color: AppColors.primary,
            width: 5,
          ),
        );

        update();
        markers.clear();
        markers.add(Marker(markerId: MarkerId('user'), position: userLatLng, icon: customIcon));
        markers.add(Marker(markerId: MarkerId('station'), position: policeStationLatLng, icon: icon1));

        if (mapController != null) {
          LatLngBounds bounds = LatLngBounds(
            southwest: LatLng(
              min(userLatLng.latitude, policeStationLatLng.latitude),
              min(userLatLng.longitude, policeStationLatLng.longitude),
            ),
            northeast: LatLng(
              max(userLatLng.latitude, policeStationLatLng.latitude),
              max(userLatLng.longitude, policeStationLatLng.longitude),
            ),
          );
          mapController!.animateCamera(
            CameraUpdate.newLatLngBounds(bounds, 50),
          );
        }
      }
    } catch (e) {
      print('Error fetching data: $e');
    }
  }

  void onMapCreated(GoogleMapController controller) {
    mapController = controller;
  }

  Future<void> getDirections(LatLng user, LatLng police) async {
    const googleAPI = "AIzaSyBAcfwpFtRaX4MOmWm2Wte2kyA635gbAwo";
    final String url =
        'https://maps.googleapis.com/maps/api/directions/json?origin=${user.latitude},${user.longitude}&destination=${police.latitude},${police.longitude}&key=$googleAPI';
    try {
      final response = await http.get(Uri.parse(url));
      final Map<String, dynamic> data = json.decode(response.body);

      if (data['status'] == 'OK') {
        final List<LatLng> points = _decodePolyline(
          data['routes'][0]['overview_polyline']['points'],
        );
        markers.clear();
        polylines.clear();
        polylines.add(
          Polyline(
            polylineId: PolylineId('route'),
            points: points,
            color: AppColors.primary,
            width: 5,
          ),
        );
        markers.addAll([
          Marker(
            markerId: MarkerId('home'),
            position: LatLng(
              user.latitude,
              user.longitude,
            ),
            icon: customIcon,
          ),
          Marker(
            markerId: MarkerId('police'),
            position: LatLng(
              police.latitude,
              police.longitude,
            ),
            icon: icon1,
          ),
        ]);
        update();
      } else {
        print('Directions API error: ${data['status']}');
      }
    } catch (e) {
      print('Error fetching directions: $e');
    }
  }

  List<LatLng> _decodePolyline(String encoded) {
    List<LatLng> poly = [];
    int index = 0, len = encoded.length;
    int lat = 0, lng = 0;
    while (index < len) {
      int b, shift = 0, result = 0;
      do {
        b = encoded.codeUnitAt(index++) - 63;
        result |= (b & 0x1F) << shift;
        shift += 5;
      } while (b >= 0x20);
      int dlat = (result & 1) != 0 ? ~(result >> 1) : (result >> 1);
      lat += dlat;

      shift = 0;
      result = 0;
      do {
        b = encoded.codeUnitAt(index++) - 63;
        result |= (b & 0x1F) << shift;
        shift += 5;
      } while (b >= 0x20);
      int dlng = (result & 1) != 0 ? ~(result >> 1) : (result >> 1);
      lng += dlng;

      poly.add(LatLng(lat / 1E5, lng / 1E5));
    }

    return poly;
  }

  Future<void> getCustomMarker() async {
    customIcon = await BitmapDescriptor.fromAssetImage(
      const ImageConfiguration(size: Size(15, 15)),
      'assets/icons/home.png',
    );
    icon1 = await BitmapDescriptor.fromAssetImage(
      const ImageConfiguration(size: Size(15, 15)),
      'assets/icons/car.png',
    );
    update();
  }


  Future<void> updateTicketStatus() async {
    var response;
    try {
      response = await requestRepository.updateTicketStatus(id: tickets?.id);
      if (response != null && response['success']==true) {
        tickets=Tickets.fromJson(response['data']);
        update();
        Utils.showToast(message: "Completed");
        update();
      }else if(response != null && response['success']==false &&response['message']=='Invalid page.' ){
        update();
      }else{
        update();
      }
    } on Exception catch (e) {
      Get.log('Sign Up ${e.toString()}');
    }
  }

}
