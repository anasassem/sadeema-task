import 'package:equatable/equatable.dart';

class TermEntity extends Equatable {
  final int id;
  final String? name;
  final int? termNumber; // 1, 2, 3
  final DateTime? startDate;
  final DateTime? endDate;

  const TermEntity({
    required this.id,
    this.name,
    this.termNumber,
    this.startDate,
    this.endDate,
  });

  @override
  List<Object?> get props => [id, name, termNumber, startDate, endDate];
}