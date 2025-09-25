import '../../domain/entities/stage_entity.dart';

class StageModel extends StageEntity {
  final int? id;
  final String? name;
  final String? img;
  final String? endYear;
  final int? systemId;
  final String? createdAt;
  final String? updatedAt;

  StageModel({
    this.id,
    this.name,
    this.img,
    this.endYear,
    this.systemId,
    this.createdAt,
    this.updatedAt,
  }) : super(
         id: id,
         name: name,
         img: img,
         endYear: endYear,
         systemId: systemId,
       );

  factory StageModel.fromJson(Map<String, dynamic> json) {
    return StageModel(
      id: json['id'],
      name: json['name'],
      img: json['img'],
      endYear: json['end_year'],
      systemId: json['system_id'],
      createdAt: json['created_at'],
      updatedAt: json['updated_at'],
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'name': name,
      'img': img,
      'end_year': endYear,
      'system_id': systemId,
      'created_at': createdAt,
      'updated_at': updatedAt,
    };
  }

}
