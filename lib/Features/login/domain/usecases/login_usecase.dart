import 'package:dartz/dartz.dart';

import 'package:sadeematask/core/erros/failure.dart';

import '../entities/user.dart';
import '../repositories/login_repository.dart';

class LoginUseCase {
  final LoginRepository repository;

  LoginUseCase(this.repository);

  Future<Either<Failure, UserEntity>> call({
    required String phoneOrEmail,
    required String password,
    required String notiId,
    required String mobileId,
    required String mobileType,
    required String type,
  }) {
    return repository.login(
      mobileId: mobileId,
      mobileType: mobileType,
      notiId: notiId,
      phoneOrEmail: phoneOrEmail,
      type: type,
      password: password,
    );
  }
}
