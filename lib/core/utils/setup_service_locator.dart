import 'package:dio/dio.dart';
import 'package:get_it/get_it.dart';
import 'package:internet_connection_checker/internet_connection_checker.dart';

import 'package:sadeematask/Features/home/presentation/manager/home_cubit/home_cubit.dart';

import '../../Features/home/data/data_source/education_remote_data_source.dart';
import '../../Features/home/data/repos/education_repository_Impl.dart';
import '../../Features/home/domain/repos/educational_repo.dart';

import '../../Features/home/domain/usecases/get_class_room_use_case.dart';
import '../../Features/home/domain/usecases/get_stage_use_case.dart';
import '../../Features/home/domain/usecases/get_system_use_case.dart';
import '../../Features/home/domain/usecases/get_terms_use_case.dart';
import '../../Features/home/domain/usecases/get_tracks_use_case.dart';
import '../../Features/login/data/data_source/login_remote_data_source.dart';
import '../../Features/login/data/repositories/login_repository_impl.dart';
import '../../Features/login/domain/usecases/login_usecase.dart';
import '../../Features/login/presentation/manager/login_cubit/login_cubit.dart';
import '../../Features/subject/data/data_source/subjects_remote_data_source.dart';
import '../../Features/subject/data/repo/subjects_repository_impl.dart';
import '../../Features/subject/domain/repo/subjects_repository.dart';
import '../../Features/subject/domain/usecases/get_subjects_usecase.dart';
import '../../Features/subject/presentation/manager/subject_cubit/subject_cubit.dart';
import '../api/api_consumer.dart';
import '../api/dio_consumer.dart';
import '../network/network_info.dart';
import 'api_service.dart';

final sl = GetIt.instance;

Future<void> init() async {
  sl.registerFactory<LoginCubit>(
    () => LoginCubit(LoginUseCase(sl.get<LoginRepositoryImpl>())),
  );

  sl.registerFactory(
    () => HomeCubit(
      getSystemsUseCase: sl(),
      getStagesUseCase: sl(),
      getClassroomsUseCase: sl(),
      getTermsUseCase: sl(),
      getTracksUseCase: sl(),
    ),
  );
  sl.registerFactory<SubjectsCubit>(
    () => SubjectsCubit(getSubjectsUseCase: sl()),
  );
  sl.registerSingleton<ApiService>(ApiService(Dio()));

  sl.registerSingleton<LoginRepositoryImpl>(
    LoginRepositoryImpl(
      loginRemoteDataSource: LoginRemoteDataSourceImpl(sl.get<ApiService>()),
    ),
  );
  // Use cases
  sl.registerLazySingleton(() => GetSystemsUseCase(sl()));
  sl.registerLazySingleton(() => GetStagesUseCase(sl()));
  sl.registerLazySingleton(() => GetClassroomsUseCase(sl()));
  sl.registerLazySingleton(() => GetTermsUseCase(sl()));
  sl.registerLazySingleton(() => GetTracksUseCase(sl()));
  sl.registerLazySingleton(() => GetSubjectsUseCase(sl()));

  // Repository
  sl.registerLazySingleton<EducationRepository>(
    () => EducationRepositoryImpl(remoteDataSource: sl(), networkInfo: sl()),
  );
  sl.registerLazySingleton<SubjectsRepository>(
    () => SubjectsRepositoryImpl(remoteDataSource: sl(), networkInfo: sl()),
  );

  // Data sources
  sl.registerLazySingleton<EducationRemoteDataSource>(
    () => EducationRemoteDataSourceImpl(sl()),
  );
  sl.registerLazySingleton<SubjectsRemoteDataSource>(
    () => SubjectsRemoteDataSourceImpl(sl()),
  );

  //! Core
  // sl.registerLazySingleton<NetworkInfo>(() => NetworkInfoImpl(sl()));
  sl.registerLazySingleton<NetworkInfo>(() => FakeNetworkInfo());
  sl.registerLazySingleton<ApiConsumer>(() => DioConsumer(sl()));

  //! External
  sl.registerLazySingleton(() => Dio());
  sl.registerLazySingleton<InternetConnectionChecker>(
    () => InternetConnectionChecker.createInstance(),
  );
}
