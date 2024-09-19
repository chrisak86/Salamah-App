import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:get/get_rx/get_rx.dart';
import 'package:get/get_rx/src/rx_types/rx_types.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:get/get.dart';
import 'package:salamah/app/models/fire_station.dart';
import 'package:salamah/app/models/hospital.dart';
import 'package:salamah/app/models/police_officer.dart';
import 'package:salamah/app/models/police_station.dart';
import 'package:salamah/app/models/tickets.dart';
import 'package:salamah/app/models/user.dart';
import 'package:salamah/app/shared_widgets/Text.dart';
import 'package:salamah/app/utils/utils.dart';
import 'package:salamah/presentation/web/web_dashboard/views/assign_police.dart';
import 'package:salamah/presentation/web/web_dashboard/views/map_ticket.dart';

import '../../../../data/repositories/profile_repository.dart';

class WebDashboardController extends GetxController {

  RequestRepository requestRepository=RequestRepository();
  final FirebaseFirestore firestore = FirebaseFirestore.instance;
  RxInt selectedIndex = 0.obs;

  RxList<Marker> markers = <Marker>[].obs;
  GoogleMapController? mapController;


  RxList<Tickets> filteredTickets = <Tickets>[].obs;
  RxString selectedStatusFilter = 'all'.obs;
  RxBool isAscending = true.obs;
  RxList<PoliceStation> policeStations=<PoliceStation>[].obs;
  RxList<FireStation> fireStations=<FireStation>[].obs;
  RxList<Hospitals> hospitals=<Hospitals>[].obs;
  RxList<UserProfile> allPolice=<UserProfile>[].obs;
  RxList<Tickets> allTicket=<Tickets>[].obs;
  RxList<Tickets> pendingTicket=<Tickets>[].obs;

  @override
  void onInit() async{
   await getPoliceStation();
   await getFireStationStation();
   await getHospitals();
   await loadMarkers();
   await getAllOfficers();
   await getAllTickets();
   await getAllPendingTickets();
   filterAndSortTickets();
    super.onInit();
  }

  Future getPoliceStation() async {
    policeStations.clear();
    var response;
    try {
      response = await requestRepository.getPoliceStations();
      if (response != null && response['success']==true) {
        var data = response['data'] as List;
        if(data!=[]){
          policeStations.addAll(data.map((e) => PoliceStation.fromJson(e)).toList());
          policeStations.removeWhere((e)=>e.status==false);
        }
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

  Future getFireStationStation() async {
    fireStations.clear();
    var response;
    try {
      response = await requestRepository.getFireStations();
      if (response != null && response['success']==true) {
        var data = response['data'] as List;
        if(data!=[]){
          fireStations.addAll(data.map((e) => FireStation.fromJson(e)).toList());
          fireStations.removeWhere((e)=>e.status==false);
        }
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

  Future getHospitals() async {
    hospitals.clear();
    var response;
    try {
      response = await requestRepository.getHospitals();
      if (response != null && response['success']==true) {
        var data = response['data'] as List;
        if(data!=[]){
          hospitals.addAll(data.map((e) => Hospitals.fromJson(e)).toList());
          hospitals.removeWhere((e)=>e.status==false);
        }
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

  Future getAllOfficers() async {
    allPolice.clear();
    var response;
    try {
      response = await requestRepository.getAllPoliceOfficers();
      if (response != null && response['success']==true) {
        var data = response['data'] as List;
        if(data!=[]){
          allPolice.addAll(data.map((e) => UserProfile.fromJson(e)).toList());
        }
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

  Future getAllTickets() async {
    allTicket.clear();
    var response;
    try {
      response = await requestRepository.getAllTickets();
      if (response != null && response['success']==true) {
        var data = response['data'] as List;
        if(data!=[]){
          allTicket.addAll(data.map((e) => Tickets.fromJson(e)).toList());
        }
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

  Future getAllPendingTickets() async {
    pendingTicket.clear();
    var response;
    try {
      response = await requestRepository.getPendingTickets();
      if (response != null && response['success']==true) {
        var data = response['data'] as List;
        if(data!=[]){
          pendingTicket.addAll(data.map((e) => Tickets.fromJson(e)).toList());
          pendingTicket.removeWhere((element) => element.completed==true || element.cancel==true);
          if(pendingTicket.isNotEmpty){
            await loadTickets('pending',);
          }
        }
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


  Future<void> loadMarkers() async {
    await loadFireStation('fire_station');
    await loadPoliceStation('police_station');
    await loadHospitals('hospitals',);
  }

  Future<void> loadHospitals(String collection) async {
    final tempMarkers = <Marker>[];
    for (var data in hospitals) {
      final icon = await getIconForLocation(collection, data.status ?? true);
      final marker = Marker(
        markerId: MarkerId(data.name.toString()),
        position:   LatLng(data.lat!, data.long!),
        icon: icon,
        infoWindow: InfoWindow(
          title: data.name,
        ),
      );
      tempMarkers.add(marker);
    }
    // Update the markers list
    markers.addAll(tempMarkers);
  }

  Future<void> loadFireStation(String collection) async {
    final tempMarkers = <Marker>[];
    for (var data in fireStations) {
      final icon = await getIconForLocation(collection, data.status ?? true);
      final marker =Marker(
          markerId: MarkerId(data.fire_station_name.toString()),
          position:  LatLng(data.latitude!, data.longitude!),
    icon: icon,
        infoWindow: InfoWindow(
          title:  data.fire_station_name,
        ),
    );
      tempMarkers.add(marker);
    }
    // Update the markers list
    markers.addAll(tempMarkers);
  }

  Future<void> loadPoliceStation(String collection) async {
    final tempMarkers = <Marker>[];
    for (var data in policeStations) {
      final icon = await getIconForLocation(collection, data.status ?? true);
      final marker =Marker(
        markerId: MarkerId(data.police_station_name.toString()),
        position:  LatLng(data.latitude!, data.longitude!),
        icon: icon,
        infoWindow: InfoWindow(
          title:  data.police_station_name,
        ),
      );
      tempMarkers.add(marker);
    }
    // Update the markers list
    markers.addAll(tempMarkers);
  }

  Future<void> loadTickets(String collection) async {
    final tempMarkers = <Marker>[];
    for (var data in pendingTicket) {
      final icon = BitmapDescriptor.defaultMarkerWithHue(1);
      final marker =Marker(
        markerId: MarkerId(data.user_name.toString()),
        position:  LatLng(data.user_lat!, data.user_long!),
        icon: icon,
        infoWindow: InfoWindow(
          title:  data.user_name,
          snippet: 'Police Station: ${data.police_station_name}\nGender: ${data.gender}\nAttendee: ${data.officer_name ?? "No Attendee"}\nDistance : ${data.distance}\nEstimate : ${data.ETA}',

        ),
      );
      tempMarkers.add(marker);
    }
    // Update the markers list
    markers.addAll(tempMarkers);
  }


  Future<void> updateFireStation(FireStation fireStation) async {
    var response;
    try {
      response = await requestRepository.updateFireStation(status:fireStation.status,id: fireStation.id);
      if (response != null && response['success']==true) {
        var data = PoliceStation.fromJson(response['data']);
        fireStations.firstWhere((e)=>e.id==data.id).status=data.status;
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

  Future<void> updatePoliceStation(PoliceStation policeStation) async {
    var response;
    try {
      response = await requestRepository.updatePoliceStation(status:policeStation.status,id: policeStation.id);
      if (response != null && response['success']==true) {
        var data = PoliceStation.fromJson(response['data']);
        policeStations.firstWhere((e)=>e.id==data.id).status=data.status;
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

  Future<void> updatePoliceOfficer(UserProfile userProfile) async {
    var response;
    try {
      response = await requestRepository.updatePoliceOfficer(email:userProfile.email,status: userProfile.isApproved);
      if (response != null && response['success']==true) {
        var data = UserProfile.fromJson(response['data']);
        allPolice.firstWhere((e)=>e.user_id==data.user_id).isApproved=data.isApproved;
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

  Future<void> updateHospital(Hospitals hospital) async {
    var response;
    try {
      response = await requestRepository.updateHospitals(status:hospital.status,id: hospital.id);
      if (response != null && response['success']==true) {
        var data = Hospitals.fromJson(response['data']);
          hospitals.firstWhere((e)=>e.id==data.id).status=data.status;
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

  void showAssignPoliceDialog(BuildContext context, int policeId, List policeStation) {
    showDialog(
      context: context,
      builder: (context) {
        return AssignPoliceStationDialog(policeId: policeId, policeStation: policeStation);
      },
    );
  }

  Future<void> assignPoliceStation({id,policeStation}) async {
    var response;
    try {
      response = await requestRepository.assignPoliceStation(status:policeStation,id: id);
      if (response != null && response['success']==true) {
        allPolice.firstWhere((e)=>e.user_id==id).policeStations=policeStation;
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

  void showTickets(BuildContext context) {
    showModalBottomSheet(
      context: context,
      builder: (context) => TicketsPanel(),
    );
  }

  Future<BitmapDescriptor> getIconForLocation(String type, bool status) async {
    String assetPath;

    switch (type) {
      case 'hospitals':
        assetPath = status ? 'assets/icons/hos.png' : 'assets/icons/dis_hos.png';
        break;
      case 'police_station':
        assetPath = status ? 'assets/icons/police.png' : 'assets/icons/dis_police.png';
        break;
      case 'fire_station':
        assetPath = status ? 'assets/icons/amb.png' : 'assets/icons/dos_fir.png';
        break;
       case 'pending':
        assetPath = 'assets/icons/home.png';
        break;
       default:
        assetPath = 'assets/icons/default_icon.png';
    }

    return BitmapDescriptor.fromAssetImage(
      ImageConfiguration(size: Size(40, 40)),
      assetPath,
    );
  }

  Future<void> updateTicketStatus(Tickets tickets) async {
    var response;
    try {
      response = await requestRepository.updateTicketStatus(id: tickets.id);
      if (response != null && response['success']==true) {
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

  void showReasonPopup(BuildContext context, String reasonText) {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: const MyText(title: "Reason"),
          content: MyText(title:reasonText),
          actions: [
            ElevatedButton(
              onPressed: () {
                Navigator.of(context).pop();
              },
              child: const Text("OK"),
            ),
          ],
        );
      },
    );
  }


  void filterAndSortTickets() {
    var filteredList = allTicket.where((ticket) {
      if (selectedStatusFilter.value == 'completed') {
        return ticket.completed == true;
      } else if (selectedStatusFilter.value == 'cancelled') {
        return ticket.cancel == true;
      } else if (selectedStatusFilter.value == 'open') {
        return ticket.completed == false && ticket.cancel == null;
      }
      return true;
    }).toList();

    // Sort tickets by id
    filteredList.sort((a, b) => isAscending.value
        ? a.id!.compareTo(b.id as num)
        : b.id!.compareTo(a.id as num));

    filteredTickets.value = filteredList;
  }


}
