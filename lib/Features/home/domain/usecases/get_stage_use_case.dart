import 'package:dartz/dartz.dart';

import '../../../../core/erros/failure.dart';
import '../entities/stage_entity.dart';
import '../repos/educational_repo.dart';

class GetStagesUseCase {
  final EducationRepository repository;

  GetStagesUseCase(this.repository);

  Future<Either<Failure, List<StageEntity>>> call(int systemId) async {
    return await repository.getStages(systemId);
  }
}