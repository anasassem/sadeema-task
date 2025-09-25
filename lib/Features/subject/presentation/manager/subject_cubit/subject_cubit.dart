import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:meta/meta.dart';

import '../../../domain/entities/subject_entity.dart';
import '../../../domain/usecases/get_subjects_usecase.dart';

part 'subject_state.dart';

class SubjectsCubit extends Cubit<SubjectsState> {
  final GetSubjectsUseCase _getSubjectsUseCase;

  SubjectsCubit({required GetSubjectsUseCase getSubjectsUseCase})
    : _getSubjectsUseCase = getSubjectsUseCase,
      super(const SubjectsInitial());

  // تحميل المواد
  Future<void> loadSubjects({required int termId, required int childId, int ?pathId}) async {
    emit(const SubjectsLoading());

    final result = await _getSubjectsUseCase(termId: termId, childId: childId,pathId: pathId);

    result.fold(
      (failure) {
        emit(SubjectsError(message: failure.message));
      },
      (subjects) {
        emit(SubjectsLoaded(subjects: subjects));
      },
    );
  }
}
