import 'package:dartz/dartz.dart';

import '../../../../core/erros/failure.dart';
import '../entities/term_entity.dart';
import '../repos/educational_repo.dart';

class GetTermsUseCase {
  final EducationRepository repository;

  GetTermsUseCase(this.repository);

  Future<Either<Failure, List<TermEntity>>> call({
    required int systemId,
    required int stageId,
    required int classroomId,
  }) async {
    return await repository.getTerms(
      systemId: systemId,
      stageId: stageId,
      classroomId: classroomId,
    );
  }
}