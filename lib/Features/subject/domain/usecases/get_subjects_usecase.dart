import 'package:dartz/dartz.dart';

import '../../../../core/erros/failure.dart';
import '../entities/subject_entity.dart';
import '../repo/subjects_repository.dart';

class GetSubjectsUseCase {
  final SubjectsRepository repository;

  GetSubjectsUseCase(this.repository);

  Future<Either<Failure, List<SubjectEntity>>> call({
    required int termId,
    required int childId,
     int ?pathId,
  }) async {
    return await repository.getSubjects(
      termId: termId,
      childId: childId,
      pathId: pathId,
    );
  }
}
