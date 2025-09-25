part of 'home_cubit.dart';



abstract class HomeState extends Equatable {
  const HomeState();

  @override
  List<Object?> get props => [];
}

class HomeInitial extends HomeState {}

class HomeLoading extends HomeState {}

class HomeError extends HomeState {
  final String message;

  const HomeError(this.message);

  @override
  List<Object> get props => [message];
}

// Step 1: Education Systems
class SystemsLoaded extends HomeState {
  final List<SystemEntity> systems;

  const SystemsLoaded(this.systems);

  @override
  List<Object> get props => [systems];
}

// Step 2: Educational Stages
class StagesLoaded extends HomeState {
  final List<StageEntity> stages;
  final SystemEntity selectedSystem;

  const StagesLoaded(
      this.stages, {
        required this.selectedSystem,
      });

  @override
  List<Object> get props => [stages, selectedSystem];
}

// Step 3: Classrooms/Grades
class ClassroomsLoaded extends HomeState {
  final List<ClassroomEntity> classrooms;
  final SystemEntity selectedSystem;
  final StageEntity selectedStage;

  const ClassroomsLoaded(
      this.classrooms, {
        required this.selectedSystem,
        required this.selectedStage,
      });

  @override
  List<Object> get props => [classrooms, selectedSystem, selectedStage];
}

// Step 4: Academic Terms
class TermsLoaded extends HomeState {
  final List<TermEntity> terms;
  final SystemEntity selectedSystem;
  final StageEntity selectedStage;
  final ClassroomEntity selectedClassroom;

  const TermsLoaded(
      this.terms, {
        required this.selectedSystem,
        required this.selectedStage,
        required this.selectedClassroom,
      });

  @override
  List<Object> get props => [terms, selectedSystem, selectedStage, selectedClassroom];
}

// Step 5: Educational Tracks (Only for Secondary Education)
class TracksLoaded extends HomeState {
  final List<TrackEntity> tracks;
  final SystemEntity selectedSystem;
  final StageEntity selectedStage;
  final ClassroomEntity selectedClassroom;
  final TermEntity selectedTerm;

  const TracksLoaded(
      this.tracks, {
        required this.selectedSystem,
        required this.selectedStage,
        required this.selectedClassroom,
        required this.selectedTerm,
      });

  @override
  List<Object> get props => [tracks, selectedSystem, selectedStage, selectedClassroom, selectedTerm];
}

// Navigation Complete State
class NavigationComplete extends HomeState {
  final SystemEntity selectedSystem;
  final StageEntity selectedStage;
  final ClassroomEntity selectedClassroom;
  final TermEntity selectedTerm;
  final TrackEntity? selectedTrack; // Optional for non-secondary education

  const NavigationComplete({
    required this.selectedSystem,
    required this.selectedStage,
    required this.selectedClassroom,
    required this.selectedTerm,
    this.selectedTrack,
  });

  @override
  List<Object?> get props => [
    selectedSystem,
    selectedStage,
    selectedClassroom,
    selectedTerm,
    selectedTrack,
  ];
}