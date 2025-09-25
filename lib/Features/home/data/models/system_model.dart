import 'package:sadeematask/Features/home/data/models/stage_model.dart';

import '../../domain/entities/system_entity.dart';

class SystemModel extends SystemEntity {
  int id;
  String? name;
  String ?img;
  String? createdAt;
  String? updatedAt;
  List<StageModel>? stages;

  SystemModel({
   required this.id,
    this.name,
    this.img,
    this.createdAt,
    this.updatedAt,
    this.stages,
  }) : super(id: id,);

  factory SystemModel.fromJson(Map<String, dynamic> json) {
    return SystemModel(
      id: json['id'],
      name: json['name'],
      img: json['img'].toString(),
      createdAt: json['created_at'],
      updatedAt: json['updated_at'],
      stages: (json['stages'] as List?)
          ?.map((v) => StageModel.fromJson(v))
          .toList(),
    );
  }

  Map<String, dynamic> toJson() => {
    'id': id,
    'name': name,
    'img': img,
    'created_at': createdAt,
    'updated_at': updatedAt,
    'stages': stages?.map((v) => v.toJson()).toList(),
  };

  @override
  String toString() {
    return 'SystemModel{id: $id, name: $name, img: $img}';
  }
}
