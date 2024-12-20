class LoginModel {
  List<dynamic>? errors;
  int? code;
  int? count;
  String? message;
  Data? data;
  String? email;
  String? password;
  int? appCode;
  int? tenantCode;
  Device? device;

  LoginModel(
      {this.device,
      this.errors,
      this.appCode,
      this.tenantCode,
      this.code,
      this.count,
      this.message,
      this.data,
      this.email,
      this.password});

  LoginModel.fromJson(Map<String, dynamic> json) {
    errors = json['errors'];
    code = json['code'];
    count = json['count'];
    message = json['message'];
    data = json['data'] != null ? Data.fromJson(json['data']) : null;
  }

  Map<String, dynamic> toLogin() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['username'] = email;
    data['appCode'] = appCode;
    data['tenatCode'] = tenantCode;
    data['password'] = password;
    if (device != null) {
      data['device'] = device!.toJson();
    }
    return data;
  }
}

class Device {
  String? deviceId;

  Device({this.deviceId});

  Device.fromJson(Map<String, dynamic> json) {
    deviceId = json['deviceId'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['deviceId'] = deviceId;
    return data;
  }
}

class Data {
  Auth? auth;
  TenantInfoDTO? tenantInfoDTO;
  bool? isCode;

  Data({this.auth, this.tenantInfoDTO, this.isCode});

  Data.fromJson(Map<String, dynamic> json) {
    auth = json['auth'] != null ? Auth.fromJson(json['auth']) : null;
    tenantInfoDTO = json['tenantInfoDTO'] != null
        ? TenantInfoDTO.fromJson(json['tenantInfoDTO'])
        : null;
    isCode = json['isCode'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    if (auth != null) {
      data['auth'] = auth!.toJson();
    }
    if (tenantInfoDTO != null) {
      data['tenantInfoDTO'] = tenantInfoDTO!.toJson();
    }
    data['isCode'] = isCode;
    return data;
  }
}

class Auth {
  String? id;
  String? name;
  String? lastName;
  String? username;
  String? token;
  String? email;
  String? phone;
  String? tenantId;
  String? lastLogin;
  String? phoneCode;
  String? expiryDate;
  List<Skills>? skills;

  Auth(
      {this.id,
      this.name,
      this.lastName,
      this.username,
      this.token,
      this.email,
      this.phone,
      this.tenantId,
      this.lastLogin,
      this.phoneCode,
      this.expiryDate,
      this.skills});

  Auth.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    name = json['name'];
    lastName = json['lastName'];
    username = json['username'];
    token = json['token'];
    email = json['email'];
    phone = json['phone'];
    tenantId = json['tenantId'];
    lastLogin = json['lastLogin'];
    phoneCode = json['phoneCode'];
    expiryDate = json['expiryDate'];
    if (json['skills'] != null) {
      skills = <Skills>[];
      json['skills'].forEach((v) {
        skills!.add(Skills.fromJson(v));
      });
    }
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['id'] = id;
    data['name'] = name;
    data['lastName'] = lastName;
    data['username'] = username;
    data['token'] = token;
    data['email'] = email;
    data['phone'] = phone;
    data['tenantId'] = tenantId;
    data['lastLogin'] = lastLogin;
    data['phoneCode'] = phoneCode;
    data['expiryDate'] = expiryDate;
    if (skills != null) {
      data['skills'] = skills!.map((v) => v.toJson()).toList();
    }
    return data;
  }
}

class Skills {
  String? id;
  String? title;
  bool? isUser;
  int? count;

  Skills({this.id, this.title, this.isUser, this.count});

  Skills.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    title = json['title'];
    isUser = json['isUser'];
    count = json['count'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['id'] = id;
    data['title'] = title;
    data['isUser'] = isUser;
    data['count'] = count;
    return data;
  }
}

class TenantInfoDTO {
  bool? isStartPhoto;
  bool? isEndPhoto;

  TenantInfoDTO({this.isStartPhoto, this.isEndPhoto});

  TenantInfoDTO.fromJson(Map<String, dynamic> json) {
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
