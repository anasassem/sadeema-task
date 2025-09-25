import 'package:dartz/dartz.dart';
import '../../../../core/erros/exceptions.dart';
import '../../../../core/erros/failure.dart';
import '../../../../core/network/network_info.dart';

import '../../domain/entities/subject_entity.dart';
import '../../domain/repo/subjects_repository.dart';
import '../data_source/subjects_remote_data_source.dart';

class SubjectsRepositoryImpl implements SubjectsRepository {
  final SubjectsRemoteDataSource remoteDataSource;
  final NetworkInfo networkInfo;

  SubjectsRepositoryImpl({
    required this.remoteDataSource,
    required this.networkInfo,
  });

  @override
  Future<Either<Failure, List<SubjectEntity>>> getSubjects({
    required int termId,
    required int childId,
    int? pathId,
  }) async {
    if (await networkInfo.isConnected) {
      try {
        final subjects = await remoteDataSource.getSubjects(
          childId: childId,
          termId: termId,
          pathId: pathId,
        );
        return Right(subjects);
      } on ServerException catch (e) {
        return Left(ServerFailure(e.message));
      }
    } else {
      return Left(NetworkFailure('لا يوجد اتصال بالإنترنت'));
    }
  }
}
