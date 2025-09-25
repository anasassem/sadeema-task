import 'package:equatable/equatable.dart';
import 'package:sadeematask/Features/home/domain/entities/stage_entity.dart';

class SystemEntity extends Equatable {
  final int id;
  final String? name;
  final String? description;
  final String? type; // public, private, international

  const SystemEntity({
    required this.id,
    this.name,
    this.description,
    this.type,
  });

  @override
  List<Object?> get props => [id, name, description, type];
}