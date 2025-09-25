import '../../../../core/api/api_consumer.dart';
import '../../../../core/api/end_point.dart';
import '../../../../core/erros/exceptions.dart';
import '../../domain/entities/subject_entity.dart';
import '../models/subject_model.dart';

abstract class SubjectsRemoteDataSource {
  Future<List<SubjectEntity>> getSubjects({
    required int termId,
    required int childId,
    int? pathId,
  });
}

class SubjectsRemoteDataSourceImpl implements SubjectsRemoteDataSource {
  final ApiConsumer apiConsumer;

  SubjectsRemoteDataSourceImpl(this.apiConsumer);

  @override
  Future<List<SubjectEntity>> getSubjects({
    required int termId,
    required int childId,
    int? pathId,
  }) async {
    try {
      final response = await apiConsumer.post(
        EndPoints.subjects,
        data: {
          "term_id": termId,
          "child_id": childId,
          if (pathId != null) "path_id": pathId,
        },
      );

      final subjectsList = response['data']["required"] as List<dynamic>;

      return subjectsList
          .map((json) => SubjectModel.fromJson(json as Map<String, dynamic>))
          .toList(); // ده هيبقى List<SubjectModel> => List<SubjectEntity>
    } catch (e) {
      throw ServerException('Failed to fetch subjects: ${e.toString()}');
    }
  }
}
