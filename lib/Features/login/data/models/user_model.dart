import 'package:sadeematask/Features/login/domain/entities/user.dart';

class LoginModel {
  final bool? status;
  final String? message;
  final String? errors;
  final Data? data;

  LoginModel({
    this.status,
    this.message,
    this.errors,
    this.data,
  });

  factory LoginModel.fromJson(Map<String, dynamic> json) {
    return LoginModel(
      status: json['status'],
      message: json['message'],
      errors: json['errors'],
      data: json['data'] != null ? Data.fromJson(json['data']) : null,
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'status': status,
      'message': message,
      'errors': errors,
      if (data != null) 'data': data!.toJson(),
    };
  }
}

class Data {
  final String? token;
  final LoginData? loginData;

  Data({this.token, this.loginData});

  factory Data.fromJson(Map<String, dynamic> json) {
    return Data(
      token: json['token'],
      loginData: json['login_data'] != null
          ? LoginData.fromJson(json['login_data'], token: json['token'])
          : null,
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'token': token,
      if (loginData != null) 'login_data': loginData!.toJson(),
    };
  }
}

class LoginData extends UserEntity {
  final String? name;
  final String? email;
  final bool? isVip;
  final int? references;
  final int? points;
  final int? attendanceWeeks;
  final int? phoneVerified;
  final String? countryCode;
  final int? fakeNumber;
  final String? gender;
  final String? img;
  final String? socialId;
  final String? username;
  final String? lock;
  final String? lockMessage;
  final int? systemId;
  final int? stageId;
  final int? classroomId;
  final int? termId;
  final String? pathId;
  final String? institutionId;
  final String? createdAt;
  final String? updatedAt;
  final System? system;
  final System? stage;
  final System? classroom;
  final System? term;

  LoginData({
    required int id,
    required String phone,
    required String type,
    required String mobileId,
    required String mobileType,
    required String token,
    this.name,
    this.email,
    this.isVip,
    this.references,
    this.points,
    this.attendanceWeeks,
    this.phoneVerified,
    this.countryCode,
    this.fakeNumber,
    this.gender,
    this.img,
    this.socialId,
    this.username,
    this.lock,
    this.lockMessage,
    this.systemId,
    this.stageId,
    this.classroomId,
    this.termId,
    this.pathId,
    this.institutionId,
    this.createdAt,
    this.updatedAt,
    this.system,
    this.stage,
    this.classroom,
    this.term,
  }) : super(
    id: id,
    phoneOrEmail: phone,
    token: token,
    notiId: '',
    mobileId: mobileId,
    mobileType: mobileType,
    type: type,
  );

  factory LoginData.fromJson(Map<String, dynamic> json, {required String? token}) {
    return LoginData(
      id: json['id'],
      phone: json['phone'],
      type: json['type'],
      mobileId: json['mobile_id'],
      mobileType: json['mobile_type'],
      token: token ?? "",
      name: json['name'],
      email: json['email'],
      isVip: json['is_vip'],
      references: json['references'],
      points: json['points'],
      attendanceWeeks: json['attendance_weeks'],
      phoneVerified: json['phone_verified'],
      countryCode: json['country_code'],
      fakeNumber: json['fake_number'],
      gender: json['gender'],
      img: json['img'],
      socialId: json['social_id'],
      username: json['username'],
      lock: json['lock'],
      lockMessage: json['lock_message'],
      systemId: json['system_id'],
      stageId: json['stage_id'],
      classroomId: json['classroom_id'],
      termId: json['term_id'],
      pathId: json['path_id'],
      institutionId: json['institution_id'],
      createdAt: json['created_at'],
      updatedAt: json['updated_at'],
      system: json['system'] != null ? System.fromJson(json['system']) : null,
      stage: json['stage'] != null ? System.fromJson(json['stage']) : null,
      classroom: json['classroom'] != null ? System.fromJson(json['classroom']) : null,
      term: json['term'] != null ? System.fromJson(json['term']) : null,
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'phone': phoneOrEmail,
      'type': type,
      'mobile_id': mobileId,
      'mobile_type': mobileType,
      'token': token,
      'name': name,
      'email': email,
      'is_vip': isVip,
      'references': references,
      'points': points,
      'attendance_weeks': attendanceWeeks,
      'phone_verified': phoneVerified,
      'country_code': countryCode,
      'fake_number': fakeNumber,
      'gender': gender,
      'img': img,
      'social_id': socialId,
      'username': username,
      'lock': lock,
      'lock_message': lockMessage,
      'system_id': systemId,
      'stage_id': stageId,
      'classroom_id': classroomId,
      'term_id': termId,
      'path_id': pathId,
      'institution_id': institutionId,
      'created_at': createdAt,
      'updated_at': updatedAt,
      if (system != null) 'system': system!.toJson(),
      if (stage != null) 'stage': stage!.toJson(),
      if (classroom != null) 'classroom': classroom!.toJson(),
      if (term != null) 'term': term!.toJson(),
    };
  }
}

class System {
  final int? id;
  final String? name;

  System({this.id, this.name});

  factory System.fromJson(Map<String, dynamic> json) {
    return System(
      id: json['id'],
      name: json['name'],
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'name': name,
    };
  }
}
