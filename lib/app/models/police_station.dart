class PoliceStation {
  int? id;
  String? police_station_name;
  double? latitude;
  double? longitude;
  String? location;
  bool? status;

  PoliceStation(
      {
        this.id,
        this.status,
        this.longitude,
        this.location,
        this.police_station_name,
        this.latitude
      });

  PoliceStation.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    status = json['status'] ;
    longitude = json['longitude'];
    location = json['location'];
    police_station_name = json['police_station_name'];
    latitude = json['latitude'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['id'] = id;
    data['status'] = status;
    data['longitude'] = longitude;
    data['location'] = location;
    data['police_station_name'] = police_station_name;
    data['latitude'] = latitude;
    return data;
  }
}