
class FireTruckAPI {
  String? rank;
  String? police_station_name;
  double? latitude;
  double? longitude;
  String? eta;
  String? distance;

  FireTruckAPI(
      {
        this.rank,
        this.longitude,
        this.police_station_name,
        this.latitude,
        this.distance,
        this.eta,
      });

  FireTruckAPI.fromJson(Map<String, dynamic> json) {
    rank = json['Proximity Rank'];
    longitude = json['Longitude'];
    police_station_name = json['Closest Fire Station Names'];
    latitude = json['Latitude'];
    distance = json['Distance'];
    eta = json['ETA'];
  }

}

