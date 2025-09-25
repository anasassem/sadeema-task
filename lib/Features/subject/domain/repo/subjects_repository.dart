import 'package:dartz/dartz.dart';

import '../../../../core/erros/failure.dart';
import '../entities/subject_entity.dart';

abstract class SubjectsRepository {
  Future<Either<Failure, List<SubjectEntity>>> getSubjects({
    required int termId,
    required int childId,
    int? pathId,
  });
}
