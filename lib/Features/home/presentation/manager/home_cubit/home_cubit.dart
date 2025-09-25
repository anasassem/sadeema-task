import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import '../../../domain/entities/class_room_entity.dart';
import '../../../domain/entities/stage_entity.dart';
import '../../../domain/entities/system_entity.dart';
import '../../../domain/entities/term_entity.dart';
import '../../../domain/entities/track_entity.dart';
import '../../../domain/usecases/get_class_room_use_case.dart';
import '../../../domain/usecases/get_stage_use_case.dart';
import '../../../domain/usecases/get_system_use_case.dart';
import '../../../domain/usecases/get_terms_use_case.dart';
import '../../../domain/usecases/get_tracks_use_case.dart';

part 'home_state.dart';

class HomeCubit extends Cubit<HomeState> {
  final GetSystemsUseCase _getSystemsUseCase;
  final GetStagesUseCase _getStagesUseCase;
  final GetClassroomsUseCase _getClassroomsUseCase;
  final GetTermsUseCase _getTermsUseCase;
  final GetTracksUseCase _getTracksUseCase;

  final List<HomeState> _navigationHistory = [];

  SystemEntity? _selectedSystem;
  StageEntity? _selectedStage;
  ClassroomEntity? _selectedClassroom;
  TermEntity? _selectedTerm;
  TrackEntity? _selectedTrack;

  HomeCubit({
    required GetSystemsUseCase getSystemsUseCase,
    required GetStagesUseCase getStagesUseCase,
    required GetClassroomsUseCase getClassroomsUseCase,
    required GetTermsUseCase getTermsUseCase,
    required GetTracksUseCase getTracksUseCase,
  }) : _getSystemsUseCase = getSystemsUseCase,
       _getStagesUseCase = getStagesUseCase,
       _getClassroomsUseCase = getClassroomsUseCase,
       _getTermsUseCase = getTermsUseCase,
       _getTracksUseCase = getTracksUseCase,
       super(HomeInitial()) {
    loadSystems();
  }

  // Load Systems (Step 1)
  Future<void> loadSystems() async {
    emit(HomeLoading());

    final result = await _getSystemsUseCase();
    result.fold(
      (failure) => emit(HomeError(failure.message)),
      (systems) => emit(SystemsLoaded(systems)),
    );
  }

  Future<void> selectSystem(SystemEntity system) async {
    _selectedSystem = system;
    _addToHistory(state);

    emit(HomeLoading());

    final result = await _getStagesUseCase(system.id);
    result.fold(
      (failure) => emit(HomeError(failure.message)),
      (stages) => emit(StagesLoaded(stages, selectedSystem: system)),
    );
  }

  Future<void> selectStage(StageEntity stage) async {
    _selectedStage = stage;
    _addToHistory(state);

    emit(HomeLoading());

    final result = await _getClassroomsUseCase(
      systemId: _selectedSystem!.id,
      stageId: stage.id!,
    );
    result.fold(
      (failure) => emit(HomeError(failure.message)),
      (classrooms) => emit(
        ClassroomsLoaded(
          classrooms,
          selectedSystem: _selectedSystem!,
          selectedStage: stage,
        ),
      ),
    );
  }

  Future<void> selectClassroom(ClassroomEntity classroom) async {
    _selectedClassroom = classroom;
    _addToHistory(state);

    emit(HomeLoading());

    final result = await _getTermsUseCase(
      systemId: _selectedSystem!.id,
      stageId: _selectedStage!.id!,
      classroomId: classroom.id,
    );
    result.fold(
      (failure) => emit(HomeError(failure.message)),
      (terms) => emit(
        TermsLoaded(
          terms,
          selectedSystem: _selectedSystem!,
          selectedStage: _selectedStage!,
          selectedClassroom: classroom,
        ),
      ),
    );
  }

  // Select Term and Handle Next Step (Step 5)
  Future<void> selectTerm(TermEntity term) async {
    _selectedTerm = term;
    _addToHistory(state);

    // Check if we need to show tracks (only for secondary education)
    if (isSecondaryEducation()) {
      emit(HomeLoading());

      final result = await _getTracksUseCase(
        systemId: _selectedSystem!.id,
        stageId: _selectedStage!.id!,
        classroomId: _selectedClassroom!.id,
        termId: term.id,
      );
      result.fold(
        (failure) => emit(HomeError(failure.message)),
        (tracks) => emit(
          TracksLoaded(
            tracks,
            selectedSystem: _selectedSystem!,
            selectedStage: _selectedStage!,
            selectedClassroom: _selectedClassroom!,
            selectedTerm: term,
          ),
        ),
      );
    } else {
      // Complete navigation for non-secondary education
      _completeNavigation();
    }
  }

  Future<void> selectTrack(TrackEntity track) async {
    _selectedTrack = track;
    _completeNavigation();
  }

  void _completeNavigation() {
    emit(
      NavigationComplete(
        selectedSystem: _selectedSystem!,
        selectedStage: _selectedStage!,
        selectedClassroom: _selectedClassroom!,
        selectedTerm: _selectedTerm!,
        selectedTrack: _selectedTrack,
      ),
    );
  }

  void goBack() {
    if (_navigationHistory.isNotEmpty) {
      final previousState = _navigationHistory.removeLast();

      if (previousState is SystemsLoaded) {
        _selectedSystem = null;
        _selectedStage = null;
        _selectedClassroom = null;
        _selectedTerm = null;
        _selectedTrack = null;
      } else if (previousState is StagesLoaded) {
        _selectedStage = null;
        _selectedClassroom = null;
        _selectedTerm = null;
        _selectedTrack = null;
      } else if (previousState is ClassroomsLoaded) {
        _selectedClassroom = null;
        _selectedTerm = null;
        _selectedTrack = null;
      } else if (previousState is TermsLoaded) {
        _selectedTerm = null;
        _selectedTrack = null;
      } else if (previousState is TracksLoaded) {
        _selectedTrack = null;
      }

      emit(previousState);
    }
  }

  void _addToHistory(HomeState currentState) {
    _navigationHistory.add(currentState);
  }

  // Helper Methods
  bool isSecondaryEducation() {
    return _selectedClassroom?.path?.isNotEmpty ?? false;
  }

  void retry() {
    if (state is HomeError) {
      if (_selectedTerm != null) {
        selectTerm(_selectedTerm!);
      } else if (_selectedClassroom != null) {
        selectClassroom(_selectedClassroom!);
      } else if (_selectedStage != null) {
        selectStage(_selectedStage!);
      } else if (_selectedSystem != null) {
        selectSystem(_selectedSystem!);
      } else {
        loadSystems();
      }
    }
  }

  void resetNavigation() {
    _navigationHistory.clear();
    _selectedSystem = null;
    _selectedStage = null;
    _selectedClassroom = null;
    _selectedTerm = null;
    _selectedTrack = null;
    loadSystems();
  }

  SystemEntity? get selectedSystem => _selectedSystem;

  StageEntity? get selectedStage => _selectedStage;

  ClassroomEntity? get selectedClassroom => _selectedClassroom;

  TermEntity? get selectedTerm => _selectedTerm;

  TrackEntity? get selectedTrack => _selectedTrack;
}
