// ignore_for_file: file_names

class IsActiveModel {
  List<dynamic>? errors;
  int? code;
  int? count;
  String? message;
  Data? data;

  IsActiveModel({this.errors, this.code, this.count, this.message, this.data});

  IsActiveModel.fromJson(Map<String, dynamic> json) {
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
  TenentInfo? tenentInfo;
  bool? isActive;

  Data({this.tenentInfo, this.isActive});

  Data.fromJson(Map<String, dynamic> json) {
    tenentInfo = json['tenentInfo'] != null
        ? TenentInfo.fromJson(json['tenentInfo'])
        : null;
    isActive = json['isActive'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    if (tenentInfo != null) {
      data['tenentInfo'] = tenentInfo!.toJson();
    }
    data['isActive'] = isActive;
    return data;
  }
}

class TenentInfo {
  bool? isStartPhoto;
  bool? isEndPhoto;

  TenentInfo({this.isStartPhoto, this.isEndPhoto});

  TenentInfo.fromJson(Map<String, dynamic> json) {
    isStartPhoto = json['isStartPhoto'];
    isEndPhoto = json['isEndPhoto'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['isStartPhoto'] = isStartPhoto;
    data['isEndPhoto'] = isEndPhoto;
    return data;
  }
}
