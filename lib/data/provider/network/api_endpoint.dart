class ApiEndPoints{
  static  String get baseUrl => "http://app.salamah.help:8000/api/";
  static  String get requestUrl => "https://8kkapnr1x1.execute-api.us-east-1.amazonaws.com/prod";
  static  String get getPoliceStations => "list-police-station/";
  static  String get getFireStations => "list-fire-station/";
  static  String get getHospitals => "list-hospital/";
  static  String get updateHospital => "update-hospital/";
  static  String get updateFireStation => "update-fire-station/";
  static  String get updateTicketStatus => "update-ticket/";
  static  String get updatePoliceStation => "update-police-station/";
  static  String get assignPoliceStation => "assign-police-station/";
  static  String get unAssignPoliceStation => "delete-police-station/";
  static  String get updatePoliceOfficer => "update-user/";
  static  String get policeOfficers => "police-officer/";
  static  String get getAllTickets => "all-ticket/";
  static  String get getPendingTickets => "pending-ticket/";
  static  String get registerUser => "register/";
  static  String get addTicket => "ticket/";
  static  String get modelLogs => "model-log/";
  static  String get login => "login/";
  static  String get getUser => "get-user/";
  static  String get getUserTicket => "get-ticket/";
  static  String get getPoliceOfficersTicket => "police-ticket/";
}