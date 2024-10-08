import 'dart:async';
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
import 'package:salamah/app/routes/app_pages.dart';
import 'package:salamah/app/shared_widgets/Text.dart';
import 'package:salamah/app/utils/utils.dart';
import 'package:salamah/data/repositories/profile_repository.dart';
import 'package:salamah/presentation/victom/landing/controllers/landing_controller.dart';

class TravelTrackingController extends GetxController {

  RxInt index=1.obs;
  RequestRepository requestRepository =RequestRepository();
  GoogleMapController? mapController;
  var polylines = <Polyline>{}.obs;
  var markers = <Marker>[].obs;
  var distance = "".obs;
  var name = "".obs;
  var eta = "".obs;
  late BitmapDescriptor customIcon;
  late BitmapDescriptor icon1;
  LatLng? userData;
  var selectedIndex = 0.obs;
  Tickets? tickets;
  RxBool noTicket=false.obs;
  RxBool first=false.obs;
  RxBool back=true.obs,firstTime=true.obs;
  Timer? fetchTimer;

  @override
  void onInit() async {
    if(Get.arguments!=null){
      index.value=Get.arguments;
      back.value=false;
    }
    super.onInit();
    await getCustomMarker();
     startFetchingTimer();
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

  void startFetchingTimer() {
    fetchTimer?.cancel();
    fetchTimer = Timer.periodic(const Duration(seconds: 5), (timer) async {
      if (tickets==null || tickets?.attend_id == null || tickets?.completed==false) {
        await fetchData("ACCIDENT");
      } else {
        timer.cancel();
      }
    });
  }

  @override
  void onClose() {
    fetchTimer?.cancel();
    super.onClose();
  }

  Future<void> fetchData(String type) async {
    var response;
    try {
      response = await requestRepository.getUserTicket(type: type);
      if (response != null && response["data"] != null && (response["data"] as List).isEmpty) {
        noTicket.value = true;
        Get.offAndToNamed(Routes.LANDING);
        Get.find<LandingController>().initialData();
        completeAllTicket();
        update();
      } else {
        List<Tickets> ticketsList = (response["data"] as List).map((ticket) => Tickets.fromJson(ticket)).toList();
        ticketsList.removeWhere((ticket) => ticket.completed == true ||  ticket.cancel==true);
        update();
        if(ticketsList.isEmpty){
          Get.offAndToNamed(Routes.LANDING);
          Get.find<LandingController>().initialData();
          Utils.showToast(message: "Your request is completed");
          completeAllTicket();
        }else{
          tickets = ticketsList.last;
          if(tickets?.cancel==true){
            noTicket.value = true;
            Get.offAndToNamed(Routes.LANDING);
            Get.find<LandingController>().initialData();
            update();
          }
        }
        if(index.value==1 && tickets?.attend_id!=null && first.isFalse ){
          first.value=true;
          showCustomNotification(Get.context!,tickets!.police_station_name!,tickets!.distance!,tickets!.ETA!);
        }
        update();
      }

      if (tickets!=null && tickets?.id!=null) {
        LatLng policeStationLatLng = LatLng(tickets!.police_lat!, tickets!.police_long!);
        userData = LatLng(tickets!.user_lat!, tickets!.user_long!);
        LatLng userLatLng = LatLng(tickets!.user_lat!, tickets!.user_long!);
        distance.value = tickets?.distance ?? '';
        name.value = tickets?.police_station_name ?? tickets?.hospital_name ?? tickets?.fire_station_name ?? "";
        eta.value = tickets?.ETA ?? '';

        getDirections(userLatLng,policeStationLatLng);
        // polylines.clear();
        // polylines.add(
        //   Polyline(
        //     polylineId: PolylineId('route1'),
        //     points: [userLatLng, policeStationLatLng],
        //     color: AppColors.primary,
        //     width: 5,
        //   ),
        // );
        //
        // update();
        // markers.clear();
        // markers.add(Marker(markerId: MarkerId('user'), position: userLatLng, icon: customIcon));
        // markers.add(Marker(markerId: MarkerId('station'), position: policeStationLatLng, icon: icon1));
        //
        // if (mapController != null) {
        //   LatLngBounds bounds = LatLngBounds(
        //     southwest: LatLng(
        //       min(userLatLng.latitude, policeStationLatLng.latitude),
        //       min(userLatLng.longitude, policeStationLatLng.longitude),
        //     ),
        //     northeast: LatLng(
        //       max(userLatLng.latitude, policeStationLatLng.latitude),
        //       max(userLatLng.longitude, policeStationLatLng.longitude),
        //     ),
        //   );
        //   mapController!.animateCamera(
        //     CameraUpdate.newLatLngBounds(bounds, 50),
        //   );
        // }
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

      print("xxxxxxxxxx${response}");
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
    // Obtain the device's pixel ratio (helps to adjust icon size)
    final ImageConfiguration imageConfig = createLocalImageConfiguration(Get.context!);

    customIcon = await BitmapDescriptor.defaultMarkerWithHue(1);

    icon1 = await BitmapDescriptor.defaultMarkerWithHue(1);

    // Make sure to call update() if you're using a state management solution like GetX
    update();
  }

  void showCustomInputDialog(BuildContext context) {
    TextEditingController textController = TextEditingController(); // Controller for the TextField

    showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: const MyText(title:"Enter Reason"),
          content: TextField(
            controller: textController,
            maxLines: 5,
            decoration: const InputDecoration(
              hintText: "Please type reason here...",
              border: OutlineInputBorder(),
            ),
          ),
          actions: [
            TextButton(
              onPressed: () {
                Navigator.of(context).pop();
              },
              child: const Text("Cancel"),
            ),
            ElevatedButton(
              onPressed: () {
                String inputText = textController.text;
                updateTicketStatus(inputText);
              },
              child: const Text("Submit"),
            ),
          ],
        );
      },
    );
  }



  Future<void> updateTicketStatus(String inputText) async {
    var response;
    try {
      response = await requestRepository.cancelTicketStatus(id: tickets?.id, reason: inputText);
      if (response != null && response['success'] == true) {
        tickets = Tickets.fromJson(response['data']);
        update();
        Utils.showToast(message: "This is cancelled");
        Get.offAndToNamed(Routes.LANDING);
        fetchTimer?.cancel();
        if(back.isTrue) {
          Get.find<LandingController>().initialData();
        }
        switch (selectedIndex.value) {
          case 0:
            if(index.value==3) {
              await cancelTicketsByType("AMBULANCE");
              await cancelTicketsByType("FIRETRUCK");
            }else  if(index.value==2) {
              await cancelTicketsByType("AMBULANCE");
            }
            break;
          case 1:
            if(index.value==3) {
              await cancelTicketsByType("ACCIDENT");
              await cancelTicketsByType("FIRETRUCK");
            }else  if(index.value==2) {
              await cancelTicketsByType("ACCIDENT");
            }
            break;
          case 2:
              await cancelTicketsByType("ACCIDENT");
              await cancelTicketsByType("AMBULANCE");
            break;
        }

        update();
      } else if (response != null && response['success'] == false && response['message'] == 'Invalid page.') {
        update();
      } else {
        update();
      }
    } on Exception catch (e) {
      Get.log('Sign Up ${e.toString()}');
    }
  }
  Future<void> cancelTicketsByType(String type) async {
    var response;
    try {
      response = await requestRepository.getUserTicket(type: type);
      if (response != null && response["data"] != null && (response["data"] as List).isEmpty) {
        noTicket.value = true;
        update();
      } else {
        List<Tickets> ticketsList = (response["data"] as List).map((ticket) => Tickets.fromJson(ticket)).toList();
        ticketsList.removeWhere((ticket) => ticket.completed == true ||  ticket.cancel==true);
        update();
        if(ticketsList.isEmpty){
        }else{
          tickets = ticketsList.last;
          if(tickets?.cancel==true){
          }else{
            cancelAllOther();
          }
        }
        if(index.value==1 && tickets?.attend_id!=null && first.isFalse ){
          first.value=true;
          showCustomNotification(Get.context!,tickets!.police_station_name!,tickets!.distance!,tickets!.ETA!);
        }
        update();
      }
    } catch (e) {
      print('Error cancelling $type tickets: $e');
    }
  }

  Future<void> completeAllTicket() async {
        switch (selectedIndex.value) {
          case 0:
            if(index.value==3) {
              await completeAllTicketByType("AMBULANCE");
              await completeAllTicketByType("FIRETRUCK");
            }else  if(index.value==2) {
              await completeAllTicketByType("AMBULANCE");
            }
            break;
          case 1:
            if(index.value==3) {
              await completeAllTicketByType("ACCIDENT");
              await completeAllTicketByType("FIRETRUCK");
            }else  if(index.value==2) {
              await completeAllTicketByType("ACCIDENT");
            }
            break;
          case 2:
            await completeAllTicketByType("ACCIDENT");
            await completeAllTicketByType("AMBULANCE");
            break;
        }
  }
  Future<void> completeAllTicketByType(String type) async {
    var response;
    try {
      response = await requestRepository.getUserTicket(type: type);
      if (response != null && response["data"] != null && (response["data"] as List).isEmpty) {
        noTicket.value = true;
        update();
      } else {
        List<Tickets> ticketsList = (response["data"] as List).map((ticket) => Tickets.fromJson(ticket)).toList();
        ticketsList.removeWhere((ticket) => ticket.completed == true ||  ticket.cancel==true);
        update();
        if(ticketsList.isEmpty){
        }else{
          tickets = ticketsList.last;
          if(tickets?.completed==true || tickets?.cancel==true ){
          }else{
            completeAllOther();
          }
        }
        update();
      }
    } catch (e) {
      print('Error cancelling $type tickets: $e');
    }
  }

  Future<void> cancelAllOther() async {
    var response;
    try {
      response = await requestRepository.cancelTicketStatus(id: tickets?.id, reason: "");
      if (response != null && response['success'] == true) {
        update();
      } else if (response != null && response['success'] == false && response['message'] == 'Invalid page.') {
        update();
      } else {
        update();
      }
    } on Exception catch (e) {
      Get.log('Sign Up ${e.toString()}');
    }
  }

  Future<void> completeAllOther() async {
    var response;
    try {
      response = await requestRepository.updateTicketStatus(id: tickets?.id);
      if (response != null && response['success'] == true) {
        update();
      } else if (response != null && response['success'] == false && response['message'] == 'Invalid page.') {
        update();
      } else {
        update();
      }
    } on Exception catch (e) {
      Get.log('Sign Up ${e.toString()}');
    }
  }



  void showCustomNotification(BuildContext context, String policeStation, String distance, String eta) {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return Align(
          alignment: Alignment.topCenter,
          child: Material(
            color: Colors.transparent,
            child: Container(
              margin: const EdgeInsets.only(top: 50), // Adjust margin from top
              padding: const EdgeInsets.all(16),
              decoration: BoxDecoration(
                color: Colors.blue,
                borderRadius: BorderRadius.circular(10),
              ),
              width: MediaQuery.of(context).size.width * 0.9,
              child: Column(
                mainAxisSize: MainAxisSize.min,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  MyText(
                    title: "Attendee Police: ${policeStation}",
                  ),
                  const SizedBox(height: 2),
                  MyText(
                    title: "Distance: ${distance}",
                  ),
                  MyText(
                    title: "Time Estimate: ${eta}",
                  ),
                ],
              ),
            ),
          ),
        );
      },
    );
    Future.delayed(Duration(seconds: 3), () {
      Navigator.of(context).pop();
    });
  }


}
