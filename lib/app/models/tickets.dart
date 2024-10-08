class Tickets {
  int? id;
  String? ETA;
  int? attend_id;
  bool? completed;
  bool? cancel;
  String? reason;
  String? gender;
  String? distance;
  double? police_lat;
  double? police_long;
  int? police_station_id;
  String? type;
  String? officer_name;
  String? police_station_name;
  String? fire_station_name;
  String? hospital_name;
  String? created_at;
  String? updated_at;
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
        this.created_at,
        this.updated_at,
        this.police_station_name,
        this.fire_station_name,
        this.hospital_name,
        this.type,
        this.cancel,
        this.reason,
        this.hospital_id,
        this.firetruck_id,
        this.attend_id,
        this.completed,
        this.officer_name,
        this.ETA,
        this.police_lat,
        this.gender,
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
    gender = json['gender'];
    police_lat = json['dest_lat'];
    police_long = json['dest_long'];
    police_station_id = json['police_station_id'];
    type = json['type_choice'];
    cancel = json['cancel'];
    reason = json['reason'];
    officer_name = json['officer_name'];
    created_at = json['created_at'];
    updated_at = json['updated_at'];
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
    data['gender'] = gender;
    data['cancel'] = cancel;
    data['reason'] = reason;
    data['attend_id'] = attend_id;
    data['completed'] = completed;
    data['officer_name'] = officer_name;
    data['created_at'] = created_at;
    data['updated_at'] = updated_at;
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