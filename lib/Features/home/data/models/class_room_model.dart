import '../../domain/entities/class_room_entity.dart';

class ClassRoomModel extends ClassroomEntity {
  final int id;
  final String? name;
  final String? img;
  final String? discount;
  final int? systemId;
  final int? stageId;
  final String? createdAt;
  final String? updatedAt;
  final List<Paths>? paths;

  const ClassRoomModel({
    required this.id,
    this.name,
    this.img,
    this.paths,
    this.discount,
    this.systemId,
    this.stageId,
    this.createdAt,
    this.updatedAt,
  }) : super(id: id, path: paths);

  factory ClassRoomModel.fromJson(Map<String, dynamic> json) {
    return ClassRoomModel(
      id: json["id"] is int ? json["id"] : int.parse(json["id"].toString()),
      name: json["name"],
      img: json["img"],
      discount: json["discount"]?.toString(),
      systemId: json["system_id"] is int
          ? json["system_id"]
          : int.tryParse(json["system_id"].toString()),
      stageId: json["stage_id"] is int
          ? json["stage_id"]
          : int.tryParse(json["stage_id"].toString()),
      createdAt: json["created_at"],
      updatedAt: json["updated_at"],
      paths: (json["paths"] as List<dynamic>?)
          ?.map((e) => Paths.fromJson(e))
          .toList() ??
          [],
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'name': name,
      'img': img,
      'discount': discount,
      'system_id': systemId,
      'stage_id': stageId,
      'created_at': createdAt,
      'updated_at': updatedAt,
      'paths': paths?.map((e) => e.toJson()).toList(),
    };
  }
}

class Paths {
  int id;
  String name;
  int systemId;
  int stageId;
  int classroomId;
  int termId;
  String createdAt;
  String updatedAt;

  Paths({
    required this.id,
    required this.name,
    required this.systemId,
    required this.stageId,
    required this.classroomId,
    required this.termId,
    required this.createdAt,
    required this.updatedAt,
  });

  factory Paths.fromJson(Map<String, dynamic> json) {
    return Paths(
      id: json['id'],
      name: json['name'],
      systemId: json['system_id'],
      stageId: json['stage_id'],
      classroomId: json['classroom_id'],
      termId: json['term_id'],
      createdAt: json['created_at'],
      updatedAt: json['updated_at'],
    );
  }

  Map<String, dynamic> toJson() => {
    'id': id,
    'name': name,
    'system_id': systemId,
    'stage_id': stageId,
    'classroom_id': classroomId,
    'term_id': termId,
    'created_at': createdAt,
    'updated_at': updatedAt,
  };
}