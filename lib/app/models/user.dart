class UserProfile {
  String? user_id;
  String? name;
  String? civilId;
  String? gender;
  String? email;
  String? type;
  bool? isOnline;
  bool? isApproved;

  UserProfile(
      {this.user_id,
        this.gender,
        this.email,
        this.name,
        this.type,
        this.civilId,
        this.isOnline,
        this.isApproved,
      });

  UserProfile.fromJson(Map<String, dynamic> json) {
    user_id = json['user_id'];
    gender = json['gender'];
    email = json['email'];
    isOnline = json['isOnline'];
    isApproved = json['isApproved'];
    name = json['name'];
    type = json['type'];
    civilId = json['civilId'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['user_id'] = user_id;
    data['gender'] = gender;
    data['email'] = email;
    data['isApproved'] = isApproved;
    data['name'] = name;
    data['isOnline'] = isOnline;
    data['type'] = type;
    data['civilId'] = civilId;
    return data;
  }
}