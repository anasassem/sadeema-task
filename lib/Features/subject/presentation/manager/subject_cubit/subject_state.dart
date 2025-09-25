part of 'subject_cubit.dart';

@immutable
abstract class SubjectsState extends Equatable {
  const SubjectsState();

  @override
  List<Object?> get props => [];
}

class SubjectsInitial extends SubjectsState {
  const SubjectsInitial();
}

class SubjectsLoading extends SubjectsState {
  const SubjectsLoading();
}

class SubjectsLoaded extends SubjectsState {
  final List<SubjectEntity> subjects;

  const SubjectsLoaded({required this.subjects});

  @override
  List<Object?> get props => [subjects];
}

class SubjectsError extends SubjectsState {
  final String message;

  const SubjectsError({required this.message});

  @override
  List<Object?> get props => [message];
}