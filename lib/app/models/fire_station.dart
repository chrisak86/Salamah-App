class FireStation {
  int? id;
  String? fire_station_name;
  double? latitude;
  double? longitude;
  String? location;
  bool? status;

  FireStation(
      {
        this.id,
        this.status,
        this.longitude,
        this.location,
        this.fire_station_name,
        this.latitude
      });

  FireStation.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    status = json['status'] ?? false;
    longitude = json['longitude'];
    location = json['location'];
    fire_station_name = json['fire_station_name'];
    latitude = json['latitude'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['id'] = id;
    data['status'] = status;
    data['longitude'] = longitude;
    data['location'] = location;
    data['fire_station_name'] = fire_station_name;
    data['latitude'] = latitude;
    return data;
  }
}