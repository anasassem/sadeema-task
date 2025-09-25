import 'package:dartz/dartz.dart';

import '../../../../core/erros/failure.dart';
import '../entities/user.dart';

abstract class LoginRepository {
  Future<Either<Failure, UserEntity>> login({
    required String phoneOrEmail,
    required String password,
    required String notiId,
    required String mobileId,
    required String mobileType,
    required String type,
  });
}
