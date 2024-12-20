// ignore_for_file: prefer_typing_uninitialized_variables

class ActivationModel {
  var errors;
  int? code;
  int? count;
  String? message;
  Data? data;

  ActivationModel(
      {this.errors, this.code, this.count, this.message, this.data});

  ActivationModel.fromJson(Map<String, dynamic> json) {
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
  bool? isStartPhoto;
  bool? isEndPhoto;

  Data({this.isStartPhoto, this.isEndPhoto});

  Data.fromJson(Map<String, dynamic> json) {
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
