class CarPhotoModel {
  List<dynamic>? errors;
  int? code;
  int? count;
  String? message;
  Data? data;

  CarPhotoModel({this.errors, this.code, this.count, this.message, this.data});

  CarPhotoModel.fromJson(Map<String, dynamic> json) {
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
  String? brand;
  String? brandYear;
  String? plateNumber;
  String? licenseDate;
  String? insuranceDate;
  String? photo;

  Data(
      {this.brand,
      this.brandYear,
      this.plateNumber,
      this.licenseDate,
      this.insuranceDate,
      this.photo});

  Data.fromJson(Map<String, dynamic> json) {
    brand = json['brand'];
    brandYear = json['brandYear'];
    plateNumber = json['plateNumber'];
    licenseDate = json['licenseDate'];
    insuranceDate = json['insuranceDate'];
    photo = json['photo'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['brand'] = brand;
    data['brandYear'] = brandYear;
    data['plateNumber'] = plateNumber;
    data['licenseDate'] = licenseDate;
    data['insuranceDate'] = insuranceDate;
    data['photo'] = photo;
    return data;
  }
}
