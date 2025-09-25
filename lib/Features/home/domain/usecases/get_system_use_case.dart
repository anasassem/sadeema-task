import 'package:dartz/dartz.dart';

import '../../../../core/erros/failure.dart';
import '../entities/system_entity.dart';
import '../repos/educational_repo.dart';

class GetSystemsUseCase {
  final EducationRepository repository;

  GetSystemsUseCase(this.repository);

  Future<Either<Failure, List<SystemEntity>>> call() async {
    return await repository.getSystems();
  }
}