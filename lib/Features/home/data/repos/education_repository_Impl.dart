import 'package:dartz/dartz.dart';
import 'package:dio/dio.dart';

import '../../../../core/erros/failure.dart';
import '../../../../core/network/network_info.dart';
import '../../domain/entities/class_room_entity.dart';
import '../../domain/entities/stage_entity.dart';
import '../../domain/entities/system_entity.dart';
import '../../domain/entities/term_entity.dart';
import '../../domain/entities/track_entity.dart';
import '../../domain/repos/educational_repo.dart';
import '../data_source/education_remote_data_source.dart';

class EducationRepositoryImpl implements EducationRepository {
  final EducationRemoteDataSource remoteDataSource;
  final NetworkInfo networkInfo;

  EducationRepositoryImpl({
    required this.remoteDataSource,
    required this.networkInfo,
  });

  @override
  Future<Either<Failure, List<SystemEntity>>> getSystems() async {
    if (await networkInfo.isConnected) {
      try {
        final systems = await remoteDataSource.getSystems();
        return Right(systems);
      } catch (e) {
        if (e is DioException) {
          return Left(ServerFailure(e.message!));
        } else {
          return Left(ServerFailure(e.toString()));
        }
      }
    } else {
      return Left(NetworkFailure('No internet connection'));
    }
  }

  @override
  Future<Either<Failure, List<StageEntity>>> getStages(int systemId) async {
    if (await networkInfo.isConnected) {
      try {
        final stages = await remoteDataSource.getStages(systemId);
        return Right(stages);
      } catch (e) {
        if (e is DioException) {
          return Left(ServerFailure(e.message!));
        } else {
          return Left(ServerFailure(e.toString()));
        }
      }
    } else {
      return Left(NetworkFailure('No internet connection'));
    }
  }

  @override
  Future<Either<Failure, List<ClassroomEntity>>> getClassrooms({
    required int systemId,
    required int stageId,
  }) async {
    if (await networkInfo.isConnected) {
      try {
        final classrooms = await remoteDataSource.getClassrooms(
          systemId: systemId,
          stageId: stageId,
        );
        return Right(classrooms);
      } catch (e) {
        if (e is DioException) {
          return Left(ServerFailure(e.message!));
        } else {
          return Left(ServerFailure(e.toString()));
        }
      }
    } else {
      return Left(NetworkFailure('No internet connection'));
    }
  }

  @override
  Future<Either<Failure, List<TermEntity>>> getTerms({
    required int systemId,
    required int stageId,
    required int classroomId,
  }) async {
    if (await networkInfo.isConnected) {
      try {
        final terms = await remoteDataSource.getTerms(
          systemId: systemId,
          stageId: stageId,
          classroomId: classroomId,
        );
        return Right(terms);
      } catch (e) {
        if (e is DioException) {
          return Left(ServerFailure(e.message!));
        } else {
          return Left(ServerFailure(e.toString()));
        }
      }
    } else {
      return Left(NetworkFailure('No internet connection'));
    }
  }

  @override
  Future<Either<Failure, List<TrackEntity>>> getTracks({
    required int systemId,
    required int stageId,
    required int classroomId,
    required int termId,
  }) async {
    if (await networkInfo.isConnected) {
      try {
        final tracks = await remoteDataSource.getTracks(
          systemId: systemId,
          stageId: stageId,
          classroomId: classroomId,
          termId: termId,
        );
        return Right(tracks);
      } catch (e) {
        if (e is DioException) {
          return Left(ServerFailure(e.message!));
        } else {
          return Left(ServerFailure(e.toString()));
        }
      }
    } else {
      return Left(NetworkFailure('No internet connection'));
    }
  }
}
