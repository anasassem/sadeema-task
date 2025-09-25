import '../../domain/entities/subject_entity.dart';

class SubjectModel extends SubjectEntity {
  final int id;
  final String name;
  final String img;
  final String colorHex;
  final bool isUnit;
  final int price;
  final int teacherPrice;
  final int oldPrice;
  final String type;
  final int systemId;
  final int stageId;
  final int classRoomId;
  final int termId;
  final int? pathId;
  final String createdAt;
  final String updatedAt;
  final int trueAnswersCount;
  final int falseAnswersCount;
  final int lessonsCount;
  final int finishesLessonsCount;
  final bool isSubscribe;

  const SubjectModel({
    required this.id,
    required this.name,
    required this.img,
    required this.colorHex,
    required this.isUnit,
    required this.price,
    required this.teacherPrice,
    required this.oldPrice,
    required this.type,
    required this.systemId,
    required this.stageId,
    required this.classRoomId,
    required this.termId,
    this.pathId,
    required this.createdAt,
    required this.updatedAt,
    required this.trueAnswersCount,
    required this.falseAnswersCount,
    required this.lessonsCount,
    required this.finishesLessonsCount,
    required this.isSubscribe,
  }) : super(
    id: id,
    name: name,
    img: img,
    termId: termId,
    oldPrice: oldPrice,
    price: price,
    colorHex: colorHex,
    systemId: systemId,
    classRoomId: classRoomId,
    pathId: pathId,
    type: type,
  );

  factory SubjectModel.fromJson(Map<String, dynamic> json) {
    return SubjectModel(
      id: json['id'],
      name: json['name'] ?? '',
      img: json['img'] ?? '',
      colorHex: json['color'] ?? '',
      isUnit: json['is_unit'] ?? false,
      price: json['price'] ?? 0,
      teacherPrice: json['teacher_price'] ?? 0,
      oldPrice: json['old_price'] ?? 0,
      type: json['type'] ?? '',
      systemId: json['system_id'] ?? 0,
      stageId: json['stage_id'] ?? 0,
      classRoomId: json['classroom_id'] ?? 0,
      termId: json['term_id'] ?? 0,
      pathId: json['path_id'],
      createdAt: json['created_at'] ?? '',
      updatedAt: json['updated_at'] ?? '',
      trueAnswersCount: json['true_answers_count'] ?? 0,
      falseAnswersCount: json['false_answers_count'] ?? 0,
      lessonsCount: json['lessons_count'] ?? 0,
      finishesLessonsCount: json['finishes_lessons_count'] ?? 0,
      isSubscribe: json['is_subscribe'] ?? false,
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'name': name,
      'img': img,
      'color': color,
      'is_unit': isUnit,
      'price': price,
      'teacher_price': teacherPrice,
      'old_price': oldPrice,
      'type': type,
      'system_id': systemId,
      'stage_id': stageId,
      'classroom_id': classRoomId,
      'term_id': termId,
      'path_id': pathId,
      'created_at': createdAt,
      'updated_at': updatedAt,
      'true_answers_count': trueAnswersCount,
      'false_answers_count': falseAnswersCount,
      'lessons_count': lessonsCount,
      'finishes_lessons_count': finishesLessonsCount,
      'is_subscribe': isSubscribe,
    };
  }
}
