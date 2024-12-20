class QuestionModel {
  List<dynamic>? errors;
  int? code;
  int? count;
  String? message;
  List<Data>? data;

  QuestionModel(
      {
      this.errors,
      this.code,
      this.count,
      this.message,
      this.data});

  QuestionModel.fromJson(Map<String, dynamic> json) {
    errors = json['errors'];
    code = json['code'];
    count = json['count'];
    message = json['message'];
    if (json['data'] != null) {
      data = <Data>[];
      json['data'].forEach((v) {
        data!.add(Data.fromJson(v));
      });
    }
  }

  Map<String, dynamic> toSendQuestionAndAnswer() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['questionId'] = errors;
    data['answerId'] = code;
    return data;
  }
}

class Data {
  String? id;
  String? questions;
  List<String>? answers;
  List<String>? answersId;

  Data({this.id, this.questions, this.answers, this.answersId});

  Data.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    questions = json['questions'];
    answers = json['answers'].cast<String>();
    answersId = json['answersId'].cast<String>();
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['id'] = id;
    data['questions'] = questions;
    data['answers'] = answers;
    data['answersId'] = answersId;
    return data;
  }
}

