import 'package:dartz/dartz.dart';
import '../../../../core/erros/failure.dart';
import '../entities/class_room_entity.dart';
import '../entities/system_entity.dart';
import '../entities/stage_entity.dart';
import '../entities/term_entity.dart';
import '../entities/track_entity.dart';

abstract class EducationRepository {
  Future<Either<Failure, List<SystemEntity>>> getSystems();

  Future<Either<Failure, List<StageEntity>>> getStages(int systemId);

  Future<Either<Failure, List<ClassroomEntity>>> getClassrooms({
    required int systemId,
    required int stageId,
  });

  Future<Either<Failure, List<TermEntity>>> getTerms({
    required int systemId,
    required int stageId,
    required int classroomId,
  });

  Future<Either<Failure, List<TrackEntity>>> getTracks({
    required int systemId,
    required int stageId,
    required int classroomId,
    required int termId,
  });
}