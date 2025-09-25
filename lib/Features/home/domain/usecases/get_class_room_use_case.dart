import 'package:dartz/dartz.dart';

import '../../../../core/erros/failure.dart';
import '../entities/class_room_entity.dart';
import '../repos/educational_repo.dart';

class GetClassroomsUseCase {
  final EducationRepository repository;

  GetClassroomsUseCase(this.repository);

  Future<Either<Failure, List<ClassroomEntity>>> call({
    required int systemId,
    required int stageId,
  }) async {
    return await repository.getClassrooms(
      systemId: systemId,
      stageId: stageId,
    );
  }
}