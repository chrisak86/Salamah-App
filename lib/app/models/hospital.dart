class Hospitals {
  int? id;
  String? name;
  double? lat;
  double? long;
  String? location;
  bool? status;

  Hospitals(
      {
        this.id,
        this.status,
        this.lat,
        this.location,
        this.name,
        this.long
      });

  Hospitals.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    status = json['status'];
    lat = json['latitude'];
    location = json['location'];
    name = json['hospital_name'];
    long = json['longitude'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['id'] = id;
    data['status'] = status;
    data['long'] = long;
    data['location'] = location;
    data['name'] = name;
    data['lat'] = lat;
    return data;
  }
}