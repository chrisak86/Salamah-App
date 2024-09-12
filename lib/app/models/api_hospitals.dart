
class HospitalsAPI {
  String? rank;
  String? police_station_name;
  double? latitude;
  double? longitude;
  String? eta;
  String? distance;

  HospitalsAPI(
      {
        this.rank,
        this.longitude,
        this.police_station_name,
        this.latitude,
        this.distance,
        this.eta,
      });

  HospitalsAPI.fromJson(Map<String, dynamic> json) {
    rank = json['Proximity Rank'];
    longitude = json['Longitude'];
    police_station_name = json['Closest Hospital Names'];
    latitude = json['Latitude'];
    distance = json['Distance'];
    eta = json['ETA'];
  }

}

