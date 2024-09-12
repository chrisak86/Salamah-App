class UserProfile {
  int? user_id;
  String? name;
  String? civilId;
  String? gender;
  String? email;
  String? type;
  String? password;
  bool? isOnline;
  bool? isApproved;
  List<dynamic>? policeStations;

  UserProfile(
      {this.user_id,
        this.gender,
        this.email,
        this.name,
        this.type,
        this.password,
        this.civilId,
        this.isOnline,
        this.isApproved,
        this.policeStations
      });

  UserProfile.fromJson(Map<String, dynamic> json) {
    user_id = json['id'];
    gender = json['gender'];
    email = json['email'];
    isOnline = json['is_online'];
    isApproved = json['is_approved'];
    name = json['first_name'];
    password = json['password'];
    type = json['user_type'];
    civilId = json['civil_id'];
    policeStations = json['police_station']!=null ?  json['police_station'].cast<int>() : [];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['id'] = user_id;
    data['gender'] = gender;
    data['email'] = email;
    data['is_approved'] = isApproved;
    data['first_name'] = name;
    data['is_online'] = isOnline;
    data['user_type'] = type;
    data['password'] = password;
    data['civil_id'] = civilId;
    data['civil_id'] = civilId;
    data['police_station'] = policeStations;
    return data;
  }
}