class ReportModel {
  int? reportId;
  int? userId;
  String? reportsType;
  String? address;
  String? number;
  String? latitude;
  String? longitude;
  String? archive64;
  String? captedSound;
  String? reportStatus;
  String? reportDate;

  ReportModel({
    this.reportId,
    this.userId,
    this.reportsType,
    this.address,
    this.number,
    this.latitude,
    this.longitude,
    this.archive64,
    this.captedSound,
    this.reportStatus,
    this.reportDate,
  });

  ReportModel.fromJson(Map<String, dynamic> json) {
    reportId = json['report_id'];
    userId = json['user_id'];
    reportsType = json['reports_type'];
    address = json['address'];
    number = json['number'];
    latitude = json['latitude'];
    longitude = json['longitude'];
    archive64 = json['archive_64'];
    captedSound = json['capted_sound'];
    reportStatus = json['report_status'];
    reportDate = json['report_date'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['report_id'] = reportId;
    data['user_id'] = userId;
    data['reports_type'] = reportsType;
    data['address'] = address;
    data['number'] = number;
    data['latitude'] = latitude;
    data['longitude'] = longitude;
    data['archive_64'] = archive64;
    data['capted_sound'] = captedSound;
    data['report_status'] = reportStatus;
    data['report_date'] = reportDate;
    return data;
  }
}
