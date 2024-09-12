class PoliceOfficer {
  String? user_id;
  String? civilId;
  String? email;
  String? gender;
  String? name;
  String? type;
  bool? isOnline;
  bool? isApproved;
  List<dynamic>? policeStations;




  PoliceOfficer({
        this.name,
        this.isOnline,
        this.user_id,
        this.isApproved,
        this.type,
        this.civilId,
        this.email,
        this.gender,
        this.policeStations
      });

  PoliceOfficer.fromJson(Map<String, dynamic> json) {
    name = json['name'];
    isOnline = json['isOnline'];
    user_id = json['user_id'];
    isApproved = json['isApproved'];
    type = json['type'];
    civilId = json['civilId'];
    email = json['email'];
    gender = json['gender'];
    policeStations = json['policeStations']!=null ?  json['policeStations'].cast<String>() : [];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['name'] = name;
    data['isOnline'] = isOnline;
    data['user_id'] = user_id;
    data['isApproved'] = isApproved;
    data['type'] = type;
    data['civilId'] = civilId;
    data['email'] = email;
    data['gender'] = gender;
    data['policeStations'] = policeStations;
    return data;
  }
}