// import 'dart:developer';
// import 'package:cloud_firestore/cloud_firestore.dart';
// import 'package:firebase_auth/firebase_auth.dart';
// import 'package:firebase_database/firebase_database.dart';
//
//
// //ErrorCodes
// // 400-> FirebaseAuthException
// // No Internet 250
// // 200 SUCCESS
// abstract class FirebaseProvider {
//   Future<DataResponse> addUser(
//       UserModel data, String id
//       );
//
//   Future<DataResponse> checkGHDetail(
//       String id,
//       );
//   Future<dynamic> sendData(
//       GHModel data, String docId
//       );
//
//   Future<DataResponse> getGHData();
//
//   Future<DataResponse> login(
//       Map<String, dynamic> data,
//       );
//
//   Future<String> patchUser(Map<String, dynamic> newdata, String id);
//
// /*  Future<DataResponse> updateWebsiteStatus(
//       email, int status, String websiteDomain);*/
//   Future<DataResponse> deleteOffer(String id);
//   Future<DataResponse> getUser(String id);
//   Future<DataResponse> getUserByPhone(String email);
//
// }
//
// class FirebaseProviderImpl implements FirebaseProvider {
//   final FirebaseAuth _firebaseAuth = FirebaseAuth.instance;
//   final FirebaseFirestore _firebaseFirestore = FirebaseFirestore.instance;
//   // String WEBSITE_COLLECTIONS = "websites";
//   // String WITHDRAWAL_COLLECTIONS = "withdrawls";
//   // String TASKOFFERS_COLLECTION = "taskoffers";
//   String User_COLLECTION = "Users";
//   String GH_Detail = "gh_details";
//
//   @override
//   Future<DataResponse> login(Map<String, dynamic> data) async {
//     late DataResponse response;
//
//     await _firebaseAuth
//         .signInWithEmailAndPassword(
//         email: data["email"], password: data["password"])
//         .then((value) => response =
//         DataResponse<UserCredential>(responseCode: 200, data: value))
//         .onError((FirebaseException error, stackTrace) => response =
//         DataResponse<UserCredential>(
//             responseCode: 400, errorCode: error.code));
//     return response;
//   }
//
//   @override
//   Future<DataResponse> addUser(UserModel data,String id) async {
//     late DataResponse response;
//     await _firebaseFirestore
//         .collection(User_COLLECTION).doc(id).set({
//       'firstName': data.firstName,
//       'lastName': data.lastName,
//       'phoneNumber': data.phoneNumber,
//       'imageUrl': data.imgUrl,
//       'id':id
//     }).then((value) {
//       return response=DataResponse(
//         responseCode: 200,
//         data: 'User added Successfuly',
//       );
//     })
//         .onError((FirebaseException error, stackTrace) =>
//         DataResponse<UserCredential>(
//             responseCode: 400, errorCode: error.code));
//     return response;
//   }
//
//
//   @override
//   Future<String> sendData(GHModel data, String docId) async {
//     String id= docId;
//
//     await _firebaseFirestore.collection(GH_Detail).doc(id).set(data.toJson());
//
//     return "true";
//
//   }
//
//
//   @override
//   Future<DataResponse> checkGHDetail(String id) async {
//     late DataResponse response;
//
//     await _firebaseFirestore
//         .collection(GH_Detail).doc( id)
//         .get()
//         .then((value)
//     {
//       print('then.............:${value.exists}');
//       return
//         response = DataResponse(
//             responseCode: 200,
//             data:value.exists
//         );
//     }).onError((FirebaseException error, stackTrace) => response =
//         DataResponse<List<GHModel>>(responseCode: 400, errorCode: error.code));
//     return response;
//   }
//
//   @override
//   Future<DataResponse> getGHData() async {
//     // final docRef = _firebaseFirestore.collection(GH_Detail).get();
//     late DataResponse response;
//     await _firebaseFirestore
//         .collection(GH_Detail).where('userId',isEqualTo: Globals.userId )
//         .get()
//         .then((value)
//     {
//       print('helooooooooo:${value.docs.last.data()}');
//       return response = DataResponse<List<GHModel>>(
//             responseCode: 200,
//             data: value.docs
//                 .map((e) {
//               print(e.data());
//               return
//                 GHModel.fromJson(e.data());
//             })
//                 .toList());
//
//     }).onError((FirebaseException error, stackTrace) => response =
//         DataResponse<List<GHModel>>(responseCode: 400, errorCode: error.code));
//     return response;
//   }
//
//   @override
//   Future<String> patchUser(Map<String, dynamic> data, String id) async {
// try{
//   await _firebaseFirestore.collection(User_COLLECTION).doc(id).update({
//     "firstName":data['firstName'],
//     "lastName":data['lastName'],
//     "imageUrl":data['imageUrl']
//   });
//
//   return "True";
// }catch (e){
//   print('data not updated............:$e');
//   return "false";
// }
//   }
//
//
//   @override
//   Future<DataResponse> deleteOffer(String id) async {
//     late DataResponse response;
//     await _firebaseFirestore
//         .collection(User_COLLECTION)
//         .doc(id).delete()
//         .then((value) =>response =  DataResponse(responseCode: 200))
//         .onError((FirebaseException error, stackTrace) => response =
//         DataResponse(responseCode: 400, errorCode: error.code));
//     return response;
//   }
//
//   @override
//   Future<DataResponse> getUser(String id) async {
//     late DataResponse response;
//     await _firebaseFirestore
//         .collection(User_COLLECTION).doc(id)
//         .get()
//         .then((value)
//     {
//       print('searched user data..........:${value.data()}');
//       return
//         response = DataResponse<UserModel>(
//             responseCode: 200,
//             data: UserModel.fromJson(value.data()!));
//     }).onError((FirebaseException error, stackTrace) => response =
//         DataResponse<UserModel>(responseCode: 400, errorCode: error.code));
//     return response;
//   }
//
//   @override
//   Future<DataResponse> getUserByPhone(String phone) async {
//     late DataResponse response;
//     await _firebaseFirestore
//         .collection(User_COLLECTION).where('phone',isEqualTo: phone)
//         .get()
//         .then((value)
//     {
//
//       print(value.docs.first.data());
//       return
//         response = DataResponse<UserModel>(
//             responseCode: 200,
//             data: UserModel.fromJson(value.docs.first.data())
//         );
//     }).onError((FirebaseException error, stackTrace) => response =
//         DataResponse<UserModel>(responseCode: 400, errorCode: error.code));
//     return response;
//   }
//
//
// }
