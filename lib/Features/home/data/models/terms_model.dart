import '../../domain/entities/term_entity.dart';

class TermsModel  extends TermEntity{
  int id;
  String? name;
  int? price;
  Null? img;
  int? termNum;
  int? systemId;
  int? stageId;
  int? classroomId;
  String? createdAt;
  String? updatedAt;
  int? pathsCount;

  TermsModel(
      {required this.id,
        this.name,
        this.price,
        this.img,
        this.termNum,
        this.systemId,
        this.stageId,
        this.classroomId,
        this.createdAt,
        this.updatedAt,
        this.pathsCount}) : super(id: id);

  TermsModel.fromJson(Map<String, dynamic> json)
      : id = json['id'] as int? ?? 0,
        name = json['name']?.toString(),
        price = json['price'],
        img = json['img'],
        termNum = json['term_num'],
        systemId = json['system_id'],
        stageId = json['stage_id'],
        classroomId = json['classroom_id'],
        createdAt = json['created_at']?.toString(),
        updatedAt = json['updated_at']?.toString(),
        pathsCount = json['paths_count'],
        super(id: json['id'] as int? ?? 0);

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = this.id;
    data['name'] = this.name;
    data['price'] = this.price;
    data['img'] = this.img;
    data['term_num'] = this.termNum;
    data['system_id'] = this.systemId;
    data['stage_id'] = this.stageId;
    data['classroom_id'] = this.classroomId;
    data['created_at'] = this.createdAt;
    data['updated_at'] = this.updatedAt;
    data['paths_count'] = this.pathsCount;
    return data;
  }
}