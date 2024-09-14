class Tickets {
  int? id;
  String? ETA;
  int? attend_id;
  bool? completed;
  String? distance;
  double? police_lat;
  double? police_long;
  int? police_station_id;
  String? type;
  String? police_station_name;
  String? fire_station_name;
  String? hospital_name;
  int? user_id;
  int? firetruck_id;
  int? hospital_id;
  String? user_name;
  double? user_lat;
  double? user_long;

  Tickets(
      {
        this.id,
        this.user_name,
       this.user_id,
        this.distance,
        this.police_station_name,
        this.fire_station_name,
        this.hospital_name,
        this.type,
        this.hospital_id,
        this.firetruck_id,
        this.attend_id,
        this.completed,
        this.ETA,
        this.police_lat,
        this.police_long,
        this.police_station_id,
        this.user_lat,
        this.user_long
      });

  Tickets.fromJson(Map<String, dynamic> json) {

    ETA = json['eta'];
    id = json['id'];
    user_name = json['user_name'];
    attend_id = json['attend_id'];
    completed = json['completed'];
    distance = json['distance'];
    police_lat = json['dest_lat'];
    police_long = json['dest_long'];
    police_station_id = json['police_station_id'];
    type = json['type_choice'];
    user_id = json['user_id'];
    user_lat = json['user_lat'];
    user_long = json['user_long'];
    firetruck_id = json['firetruck_id'];
    hospital_id = json['hospital_id'];
    police_station_name = json['police_station_name'];
    fire_station_name = json['fire_station_name'];
    hospital_name = json['hospital_name'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['id'] = id;
    data['police_station_name'] = police_station_name;
    data['fire_station_name'] = fire_station_name;
    data['hospital_name'] = hospital_name;
    data['user_name'] = user_name;
    data['hospital_id'] = hospital_id;
    data['firetruck_id'] = firetruck_id;
    data['eta'] = ETA;
    data['attend_id'] = attend_id;
    data['completed'] = completed;
    data['distance'] = distance;
    data['dest_lat'] = police_lat;
    data['dest_long'] = police_long;
    data['police_station_id'] = police_station_id;
    data['type_choice'] = type;
    data['user_id'] = user_id;
    data['user_lat'] = user_lat;
    data['user_long'] = user_long;
    data.removeWhere((key, value) =>value == null);
    return data;
  }
}