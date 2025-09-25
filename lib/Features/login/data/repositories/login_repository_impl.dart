import 'package:dartz/dartz.dart';
import 'package:dio/dio.dart';

import 'package:sadeematask/core/erros/failure.dart';

import '../../domain/entities/user.dart';
import '../../domain/repositories/login_repository.dart';
import '../data_source/login_remote_data_source.dart';

class LoginRepositoryImpl extends LoginRepository {
  final LoginRemoteDataSource loginRemoteDataSource;

  LoginRepositoryImpl({required this.loginRemoteDataSource});

  @override
  Future<Either<Failure, UserEntity>> login({
    required String phoneOrEmail,
    required String password,
    required String notiId,
    required String mobileId,
    required String mobileType,
    required String type,
  }) async {
    try {
      var login = await loginRemoteDataSource.login(
        mobileId: mobileId,
        mobileType: mobileType,
        notiId: notiId,
        phoneOrEmail: phoneOrEmail,
        type: type,
        password: password
      );
      return right(login);
    } catch (e) {
      if (e is DioException) {
        return left(ServerFailure.fromDioError(e));
      } else {
        return left(ServerFailure(e.toString()));
      }
    }
  }
}
