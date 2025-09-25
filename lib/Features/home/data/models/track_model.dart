import '../../domain/entities/track_entity.dart';

class TrackModel extends TrackEntity {
  const TrackModel({
    required int id,
    String? name,
    int? systemId,
    int? stageId,
    int? classroomId,
    int? termId,
    String? createdAt,
    String? updatedAt,
  }) : super(
    id: id,
    name: name,
  );

  factory TrackModel.fromJson(Map<String, dynamic> json) {
    return TrackModel(
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


}