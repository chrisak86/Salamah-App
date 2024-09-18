class ModelLogs {
  double? lat;
  double? long;
  Map<String, dynamic>? response;

  ModelLogs({
    this.lat,
    this.long,
    this.response,
  });

  ModelLogs.fromJson(Map<String, dynamic> json) {
    lat = json['lat'];
    long = json['lng'];
    response = json['response'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};

    data['lat'] = lat;
    data['lng'] = long;
    data['response'] = response;
    data.removeWhere((key, value) => value == null);
    return data;
  }
}
