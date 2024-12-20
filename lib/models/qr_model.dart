class QrModel {
  List<dynamic>? errors;
  int? code;
  int? count;
  String? message;
  Data? data;

  QrModel({this.errors, this.code, this.count, this.message, this.data});

  QrModel.fromJson(Map<String, dynamic> json) {
    errors = json['errors'];
    code = json['code'];
    count = json['count'];
    message = json['message'];
    data = json['data'] != null ? Data.fromJson(json['data']) : null;
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['errors'] = errors;
    data['code'] = code;
    data['count'] = count;
    data['message'] = message;
    if (this.data != null) {
      data['data'] = this.data!.toJson();
    }
    return data;
  }
}

class Data {
  String? id;
  String? tenantId;
  String? createdDate;
  String? updatedDate;
  String? brand;
  String? brandYear;
  String? plateNumber;
  String? licenseDate;
  String? userId;
  String? insuranceDate;
  String? photo;

  Data(
      {this.id,
      this.tenantId,
      this.userId,
      this.createdDate,
      this.updatedDate,
      this.brand,
      this.brandYear,
      this.plateNumber,
      this.licenseDate,
      this.insuranceDate,
      this.photo});

  Data.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    tenantId = json['tenantId'];
    userId = json['driverId'];
    createdDate = json['createdDate'];
    updatedDate = json['updatedDate'];
    brand = json['brand'];
    brandYear = json['brandYear'];
    plateNumber = json['plateNumber'];
    licenseDate = json['licenseDate'];
    insuranceDate = json['insuranceDate'];
    photo = json['photo'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['id'] = id;
    data['tenantId'] = tenantId;
    data['userId'] = userId;
    data['createdDate'] = createdDate;
    data['updatedDate'] = updatedDate;
    data['brand'] = brand;
    data['brandYear'] = brandYear;
    data['plateNumber'] = plateNumber;
    data['licenseDate'] = licenseDate;
    data['insuranceDate'] = insuranceDate;
    data['photo'] = photo;
    return data;
  }
}
