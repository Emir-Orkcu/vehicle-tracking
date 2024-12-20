import 'dart:io';

class FileModel {
  int? id;
  String? fileTitle;
  String? filePath;
  String? devicePath;
  File? file;

  FileModel({this.id, this.filePath, this.fileTitle, this.devicePath,this.file});

  FileModel.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    filePath = json['filePath'];
    fileTitle = json['fileTitle'];
    file = json['file'];
  }

  static List<FileModel> fromJsonList(List data) {
    if (data.isEmpty) return [];
    List<FileModel> items = [];
    print(data);
    for (var i in data) {
      items.add(FileModel.fromJson(i));
    }
    return items;
  }
  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['id'] = id;
    data['filePath'] = filePath;
    data['fileTitle'] = fileTitle;
    return data;
  }
}
