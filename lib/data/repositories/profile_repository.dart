import 'package:get/get.dart';
import 'package:salamah/app/config/global_var.dart';
import 'package:salamah/app/models/tickets.dart';
import 'package:salamah/app/models/user.dart';

import '../provider/network/api_endpoint.dart';
import '../provider/network/api_provider.dart';

class RequestRepository{
  late APIProvider apiClient;

  RequestRepository() {
    apiClient = APIProvider();
  }

  Future request(double lat,double long) async {
    Map<String, dynamic> data = await apiClient.basePostAPI(
      "",
      fullUrl: ApiEndPoints.requestUrl,
      {
        "latitude": lat,
        "longitude": long
      },
      false,
      loading: true,
      Get.context,
    );
    return data;
  }

  Future getPoliceStations() async {
    Map<String, dynamic> data = await apiClient.baseGetAPI(
      ApiEndPoints.getPoliceStations,
      {},
      false,
      loading: true,
      Get.context,
    );
    return data;
  }


  Future getFireStations() async {
    Map<String, dynamic> data = await apiClient.baseGetAPI(
      ApiEndPoints.getFireStations,
      {},
      false,
      loading: true,
      Get.context,
    );
    return data;
  }

  Future getHospitals() async {
    Map<String, dynamic> data = await apiClient.baseGetAPI(
      ApiEndPoints.getHospitals,
      {},
      false,
      loading: true,
      Get.context,
    );
    return data;
  }


  Future getAllPoliceOfficers() async {
    Map<String, dynamic> data = await apiClient.baseGetAPI(
      ApiEndPoints.policeOfficers,
      {},
      false,
      loading: true,
      Get.context,
    );
    return data;
  }
  Future getAllTickets() async {
    Map<String, dynamic> data = await apiClient.baseGetAPI(
      ApiEndPoints.getAllTickets,
      {},
      false,
      loading: true,
      Get.context,
    );
    return data;
  }

  Future getPendingTickets() async {
    Map<String, dynamic> data = await apiClient.baseGetAPI(
      ApiEndPoints.getPendingTickets,
      {},
      false,
      loading: true,
      Get.context,
    );
    return data;
  }

  Future updateHospitals({status,id}) async {
    Map<String, dynamic> data = await apiClient.basePutAPI(
        "${ApiEndPoints.updateHospital}",
        {
          "id": id,
          "status": status
        },
        false,
        Get.context,
        loading: true
    );
    return data;
  }

  Future updatePoliceStation({status,id}) async {
    Map<String, dynamic> data = await apiClient.basePutAPI(
        "${ApiEndPoints.updatePoliceStation}",
        {
          "id": id,
          "status": status
        },
        false,
        Get.context,
        loading: true
    );
    return data;
  }


  Future assignPoliceStation({status,id}) async {
    Map<String, dynamic> data = await apiClient.basePostAPI(
        "${ApiEndPoints.assignPoliceStation}",
        {
          "user": id,
          "police_station": "$status"
        },
        false,
        Get.context,
        loading: true
    );
    return data;
  }

  Future updatePoliceOfficer({email,status}) async {
    Map<String, dynamic> data = await apiClient.basePutAPI(
        "${ApiEndPoints.updatePoliceOfficer}",
        {
          "email": email,
          "is_approved": status
        },
        false,
        Get.context,
        loading: true
    );
    return data;
  }

  Future updateFireStation({status,id}) async {
    Map<String, dynamic> data = await apiClient.basePutAPI(
        "${ApiEndPoints.updateFireStation}",
        {
          "id": id,
          "status": status
        },
        false,
        Get.context,
        loading: true
    );
    return data;
  }

  Future registerUser(UserProfile userProfile) async {
    Map<String, dynamic> data = await apiClient.basePostAPI(
        ApiEndPoints.registerUser,
        userProfile.toJson(),
        false,
        Get.context,
        loading: true
    );
    return data;
  }


  Future login({email,pass}) async {
    Map<String, dynamic> data = await apiClient.basePostAPI(
        ApiEndPoints.login,
        {
          "email":email,
          "password":pass
        },
        false,
        Get.context,
        loading: true
    );
    return data;
  }

  Future addTicket(Tickets ticket, {bool? loading}) async {
    Map<String, dynamic> data = await apiClient.basePostAPI(
        ApiEndPoints.addTicket,
        ticket.toJson(),
        true,
        Get.context,
        loading: loading ?? false
    );
    return data;
  }

  Future getUserTicket({type}) async {
    Map<String, dynamic> data = await apiClient.basePostAPI(
      ApiEndPoints.getUserTicket,
      {
        "type_choice":type
      },
      true,
      loading: true,
      Get.context,
    );
    return data;
  }

  Future getUser() async {
    Map<String, dynamic> data = await apiClient.baseGetAPI(
      ApiEndPoints.getUser,
      {},
      true,
      loading: false,
      Get.context,
    );
    return data;
  }

  Future updateTicketStatus({status,id}) async {
    Map<String, dynamic> data = await apiClient.basePutAPI(
        ApiEndPoints.updateTicketStatus,
        {
          "id": id,
          "completed": true
        },
        false,
        Get.context,
        loading: true
    );
    return data;
  }
  Future cancelTicketStatus({id,reason}) async {
    Map<String, dynamic> data = await apiClient.basePutAPI(
        ApiEndPoints.updateTicketStatus,
        {
          "id": id,
          "cancel": true,
          "reason":reason
        },
        false,
        Get.context,
        loading: true
    );
    return data;
  }


  Future getPoliceOfficerTicket() async {
    Map<String, dynamic> data = await apiClient.baseGetAPI(
      ApiEndPoints.getPoliceOfficersTicket,
      {},
      true,
      loading: true,
      Get.context,
    );
    return data;
  }

  Future onlineStatus({email,status}) async {
    Map<String, dynamic> data = await apiClient.basePutAPI(
        "${ApiEndPoints.updatePoliceOfficer}",
        {
          "email": email,
          "is_online": status
        },
        false,
        Get.context,
        loading: true
    );
    return data;
  }

  Future attendTicket({id}) async {
    Map<String, dynamic> data = await apiClient.basePutAPI(
        ApiEndPoints.updateTicketStatus,
        {
          "id": id,
          "attend_id":Globals.userProfile?.user_id
        },
        false,
        Get.context,
        loading: true
    );
    return data;
  }


  Future unAssignPoliceStation({id}) async {
    Map<String, dynamic> data = await apiClient.baseDeleteAPI(
        "${ApiEndPoints.unAssignPoliceStation}",
        {
          "id": id,
        },
        false,
        Get.context,
        loading: true
    );
    return data;
  }




}