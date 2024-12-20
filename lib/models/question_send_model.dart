class QuestionSendModel {
  List<dynamic>? errors;
  int? code;
  int? count;
  String? message;
  String? data;

  QuestionSendModel(
      {this.errors, this.code, this.count, this.message, this.data});

  QuestionSendModel.fromJson(Map<String, dynamic> json) {
    errors = json['errors'];
    code = json['code'];
    count = json['count'];
    message = json['message'];
    data = json['data'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['errors'] = errors;
    data['code'] = code;
    data['count'] = count;
    data['message'] = message;
    data['data'] = this.data;
    return data;
  }
}