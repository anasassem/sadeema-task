import 'package:dartz/dartz.dart';

import '../../../../core/erros/failure.dart';
import '../entities/track_entity.dart';
import '../repos/educational_repo.dart';

class GetTracksUseCase {
  final EducationRepository repository;

  GetTracksUseCase(this.repository);

  Future<Either<Failure, List<TrackEntity>>> call({
    required int systemId,
    required int stageId,
    required int classroomId,
    required int termId,
  }) async {
    return await repository.getTracks(
      systemId: systemId,
      stageId: stageId,
      classroomId: classroomId,
      termId: termId,
    );
  }
}
