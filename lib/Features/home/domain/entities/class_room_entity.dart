import 'package:equatable/equatable.dart';

import '../../data/models/class_room_model.dart';

class ClassroomEntity extends Equatable {
  final int id;
  final String? name;
  final int? grade;
  final String? description;
  final List<Paths>? path;

  const ClassroomEntity({
    required this.id,
    this.name,
    this.grade,
    this.description,
    this.path,
  });

  @override
  List<Object?> get props => [id, name, grade, description];
}