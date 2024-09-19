import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:geolocator/geolocator.dart';
import 'package:get/get.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:permission_handler/permission_handler.dart';
import 'package:salamah/app/config/global_var.dart';
import 'package:salamah/app/models/api_firetruck.dart';
import 'package:salamah/app/models/api_hospitals.dart';
import 'package:salamah/app/models/api_police_station.dart';
import 'package:salamah/app/models/fire_station.dart';
import 'package:salamah/app/models/hospital.dart';
import 'package:salamah/app/models/model_log.dart';
import 'package:salamah/app/models/police_station.dart';
import 'package:salamah/app/models/tickets.dart';
import 'package:salamah/app/routes/app_pages.dart';
import 'package:salamah/app/shared_widgets/Text.dart';
import 'package:salamah/app/utils/utils.dart';
import 'package:salamah/data/repositories/profile_repository.dart';
import 'package:shared_preferences/shared_preferences.dart';

class LandingController extends GetxController {

  RequestRepository requestRepository = RequestRepository();
  final FirebaseFirestore firestore = FirebaseFirestore.instance;
  RxList<Hospitals> hospitals = <Hospitals>[].obs;
  RxList<FireStation> fireStations = <FireStation>[].obs;
  RxList<PoliceStation> policeStations = <PoliceStation>[].obs;
  RxList<PoliceStationAPI> policeStationsApiData = <PoliceStationAPI>[].obs;
  RxList<HospitalsAPI> hospitalsApiData = <HospitalsAPI>[].obs;
  RxList<FireTruckAPI> firetruckApiData = <FireTruckAPI>[].obs;
  var selectedIndex = 0.obs;
  var isRequesting = false.obs;
  var isCalling = false.obs;
  var isLoading = true.obs;

  var currentLocation = const LatLng(29.3759, 47.9774).obs;
  var markers = <Marker>{}.obs;

  GoogleMapController? mapController;

  @override
  void onInit() {
    super.onInit();
    getCurrentLocation().then((_) {
      getPoliceStation();
      getFireStationStation();
      getHospitals();
    });
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


  void updateMarker(LatLng position) {
    markers.clear();
    markers.add(
      Marker(
        markerId: const MarkerId('dynamicMarker'),
        position: position,
      ),
    );
  }

  void changeSelectedIndex(int index) {
    selectedIndex.value = index;
  }

  void onRequestNow() {
    request();
  }

  Future<void> request() async {
    Map<String, dynamic>? response;
    try {
      response = await requestRepository.request(currentLocation.value.latitude, currentLocation.value.longitude);
      if (response != null && response['statusCode'] == 200) {
        hospitalsApiData.value = (response["body"]['Closest Hospitals'] as List).map((e) => HospitalsAPI.fromJson(e)).toList();
        firetruckApiData.value = (response["body"]['Closest Fire Stations'] as List).map((e) => FireTruckAPI.fromJson(e)).toList();
        policeStationsApiData.value = (response["body"]['Closest Police Stations'] as List).map((e) => PoliceStationAPI.fromJson(e)).toList();
        updateOnlineStatus(policeStationsApiData.value);
        await requestRepository.modelLogs(
            ModelLogs(
              lat: currentLocation.value.latitude,
              long: currentLocation.value.longitude,
              response: response,
            )
        );
      } else if (response != null && response['success'] == false) {
        Utils.showToast(message: response['message']);
      } else {
        Utils.showToast(message: "Please try Again Later".tr);
      }
    } on Exception catch (e) {
      Get.log('Request Error: ${e.toString()}');
    }
  }

  void onCall112() {
    isCalling.value = true;
    Future.delayed(const Duration(seconds: 2), () {
      isCalling.value = false;
      Get.snackbar('Info', 'Calling 112...');
    });
  }

  Future<void> getCurrentLocation() async {
    await Permission.locationWhenInUse.request();

    bool serviceEnabled = await Geolocator.isLocationServiceEnabled();
    if (!serviceEnabled) {
      print('Location services are disabled. Defaulting to Kuwait City.');
      isLoading.value = false;
      return;
    }

    LocationPermission permission = await Geolocator.checkPermission();
    if (permission == LocationPermission.denied || permission == LocationPermission.deniedForever) {
      permission = await Geolocator.requestPermission();
      if (permission != LocationPermission.whileInUse && permission != LocationPermission.always) {
        print('Location permissions are denied. Defaulting to Kuwait City.');
        isLoading.value = false;
        return;
      }
    }

    try {
      Position position = await Geolocator.getCurrentPosition(desiredAccuracy: LocationAccuracy.high);
      currentLocation.value = LatLng(position.latitude, position.longitude);
    } catch (e) {
      print('Failed to get location: $e. Defaulting to Kuwait City.');
      currentLocation.value = const LatLng(29.3759, 47.9774);
    } finally {
      // Update the map marker and location
      updateMarker(currentLocation.value);
      isLoading.value = false;

      mapController?.animateCamera(CameraUpdate.newCameraPosition(
        CameraPosition(target: currentLocation.value, zoom: 14),
      ));
    }
  }


  void logout()async {
    final SharedPreferences prefs = await SharedPreferences.getInstance();
    await prefs.clear();
    Get.offAndToNamed(Routes.LOGIN);
  }

  void showDeleteAccountDialog() {
    showDialog(
      context: Get.context!,
      builder: (BuildContext context) {
        return AlertDialog(
          title: const MyText(title: "Delete Account"),
          content: const MyText(title: "Are you sure you want to delete your account?"),
          actions: [
            TextButton(
              child: const MyText(title: "Cancel"),
              onPressed: () {
                Get.back();
              },
            ),
            TextButton(
              child: const MyText(title: "Delete"),
              onPressed: () {
               logout();
               Utils.showToast(message: "You are account has been deleted.");
              },
            ),
          ],
        );
      },
    );
  }



  Future<void> updateOnlineStatus(List<PoliceStationAPI> apiStations) async {
    for (var apiStation in apiStations) {
      if (apiStation.police_station_name == null) continue;

      var matchingStation = policeStations.firstWhere(
            (station) => station.police_station_name == apiStation.police_station_name && station.status == true,
        orElse: () => PoliceStation(police_station_name: 'Unknown', status: false),
      );

      if (matchingStation.status == true) {
        await addTickets(apiStation, matchingStation);
        break;
      }
    }
    Get.toNamed(Routes.TRAVEL,arguments: selectedIndex.value+1);

  }

  Future<void> addTickets(PoliceStationAPI apiStation, PoliceStation matchingStation) async {
    var response;
    try {
      response = await requestRepository.addTicket(
          Tickets(
              ETA: apiStation.eta,
              distance: apiStation.distance,
              police_station_id: matchingStation.id,
              police_station_name: matchingStation.police_station_name,
              user_lat: currentLocation.value.latitude,
              user_long: currentLocation.value.longitude,
              police_lat: apiStation.latitude,
              police_long: apiStation.longitude,
              type:"ACCIDENT",
              gender: "${Globals.userProfile?.gender}",
              completed: false
          ),
        loading: true
      );
      if(selectedIndex.value == 1){
        addAmbulance(hospitalsApiData.value);
      }else if(selectedIndex.value == 2){
        await addAmbulance(hospitalsApiData.value);
        await addFireTruck(firetruckApiData.value);
      }
    } on Exception catch (e) {
      Get.log('Sign Up ${e.toString()}');
    }
  }


  Future<void> addAmbulance(List<HospitalsAPI> apiStations) async {
    for (var apiStation in apiStations) {
      if (apiStation.police_station_name == null) continue;

      var matchingStation = hospitals.firstWhere(
            (station) => station.name == apiStation.police_station_name && station.status == true,
        orElse: () => Hospitals(name: 'Unknown', status: false),
      );

      if (matchingStation.status == true && (selectedIndex.value == 1 ||  selectedIndex.value ==2)) {
        await requestRepository.addTicket(
            Tickets(
                ETA: apiStation.eta,
                distance: apiStation.distance,
                hospital_id: matchingStation.id,
                hospital_name: matchingStation.name,
                user_lat: currentLocation.value.latitude,
                user_long: currentLocation.value.longitude,
                police_lat: apiStation.latitude,
                police_long: apiStation.longitude,
                gender: "${Globals.userProfile?.gender}",
                type:"AMBULANCE",
                completed: false
            )
        );
        break;
      }
    }
  }

  Future<void> addFireTruck(List<FireTruckAPI> apiStations) async {
    for (var apiStation in apiStations) {
      if (apiStation.police_station_name == null) continue;

      var matchingStation = fireStations.firstWhere(
            (station) => station.fire_station_name == apiStation.police_station_name && station.status == true,
        orElse: () => FireStation(fire_station_name: 'Unknown', status: false),
      );

      if (matchingStation.status == true && selectedIndex.value == 2) {
        await requestRepository.addTicket(
            Tickets(
                ETA: apiStation.eta,
                distance: apiStation.distance,
                firetruck_id: matchingStation.id,
                user_lat: currentLocation.value.latitude,
                user_long: currentLocation.value.longitude,
                police_lat: apiStation.latitude,
                fire_station_name: matchingStation.fire_station_name,
                gender: "${Globals.userProfile?.gender}",
                police_long: apiStation.longitude,
                type:"FIRETRUCK",
                completed: false
            )
        );
        break;
      }
    }
  }
}
