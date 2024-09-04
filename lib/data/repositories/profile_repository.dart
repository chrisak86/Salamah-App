import 'package:get/get.dart';

import '../provider/network/api_endpoint.dart';
import '../provider/network/api_provider.dart';

class ProfileRepository{
  late APIProvider apiClient;

  ProfileRepository() {
    apiClient = APIProvider();
  }

  Future updateProfile() async {
    Map<String, dynamic>? data = await apiClient.basePostAPI(
      ApiEndPoints.profile,
      {
        "id": 0,
        "avatar": "string",
        "full_name": "string",
        "email": "user@example.com",
        "age": 2,
        "state": "string",
        "zip_code": "string"
      },
      true,
      loading: true,
      Get.context,
    );

    return data;
  }

  Future getUserProfile() async {
    Map<String, dynamic>? data = await apiClient.baseGetAPI(
      ApiEndPoints.profile,
      {},
      true,
      Get.context
    );
    print(data);
    return data;
  }
}