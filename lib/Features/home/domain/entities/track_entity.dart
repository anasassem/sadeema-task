import 'package:equatable/equatable.dart';

class TrackEntity extends Equatable {
  final int id;
  final String? name;
  final String? type; // scientific, literary, administrative
  final String? description;

  const TrackEntity({
    required this.id,
    this.name,
    this.type,
    this.description,
  });

  @override
  List<Object?> get props => [id, name, type, description];
}