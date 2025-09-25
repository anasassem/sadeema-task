import 'package:sadeematask/core/api/api_consumer.dart';
import 'package:sadeematask/core/utils/api_service.dart';

import '../../../../core/api/end_point.dart';
import '../../../../core/erros/failure.dart';
import '../../domain/entities/class_room_entity.dart';
import '../../domain/entities/stage_entity.dart';
import '../../domain/entities/system_entity.dart';
import '../../domain/entities/term_entity.dart';
import '../../domain/entities/track_entity.dart';
import '../models/class_room_model.dart';
import '../models/stage_model.dart';
import '../models/system_model.dart';
import '../models/terms_model.dart';
import '../models/track_model.dart';

abstract class EducationRemoteDataSource {
  Future<List<SystemEntity>> getSystems();

  Future<List<StageEntity>> getStages(int systemId);

  Future<List<ClassroomEntity>> getClassrooms({
    required int systemId,
    required int stageId,
  });

  Future<List<TermEntity>> getTerms({
    required int systemId,
    required int stageId,
    required int classroomId,
  });

  Future<List<TrackEntity>> getTracks({
    required int systemId,
    required int stageId,
    required int classroomId,
    required int termId,
  });
}

class EducationRemoteDataSourceImpl implements EducationRemoteDataSource {
  final ApiConsumer apiConsumer;

  EducationRemoteDataSourceImpl(this.apiConsumer);

  @override
  Future<List<SystemEntity>> getSystems() async {
    try {
      final response = await apiConsumer.post(EndPoints.systems);
      final List<dynamic> systemsList = response['data'];
      return systemsList.map((json) => SystemModel.fromJson(json)).toList();
    } catch (e) {
      throw ServerFailure(e.toString());
    }
  }

  @override
  Future<List<StageEntity>> getStages(int systemId) async {
    try {
      final response = await apiConsumer.post(
        EndPoints.stages,
        data: {'system_id': systemId},
      );
      final List<dynamic> stagesList = response['data'];
      return stagesList.map((json) => StageModel.fromJson(json)).toList();
    } catch (e) {
      throw ServerFailure(e.toString());
    }
  }

  @override
  Future<List<ClassroomEntity>> getClassrooms({
    required int systemId,
    required int stageId,
  }) async {
    try {
      final response = await apiConsumer.post(
        EndPoints.classrooms,
        data: {'stage_id': stageId},
      );
      final List<dynamic> classroomsList = response['data'];
      return classroomsList
          .map((json) => ClassRoomModel.fromJson(json))
          .toList();
    } catch (e) {
      throw ServerFailure(e.toString());
    }
  }

  @override
  Future<List<TermEntity>> getTerms({
    required int systemId,
    required int stageId,
    required int classroomId,
  }) async {
    try {
      final response = await apiConsumer.post(
        EndPoints.terms,
        data: {'classroom_id': classroomId},
      );
      final List<dynamic> termsList = response['data'];
      return termsList.map((json) => TermsModel.fromJson(json)).toList();
    } catch (e) {
      throw ServerFailure(e.toString());
    }
  }

  @override
  Future<List<TrackEntity>> getTracks({
    required int systemId,
    required int stageId,
    required int classroomId,
    required int termId,
  }) async {
    try {
      final response = await apiConsumer.post(
        EndPoints.tracks,
        data: {"classroom_id": classroomId},
      );
      final List<dynamic> tracksList = response['data'];
      return tracksList.map((json) => TrackModel.fromJson(json)).toList();
    } catch (e) {
      throw ServerFailure(e.toString());
    }
  }
}
