import 'package:bloc/bloc.dart';
import 'package:meta/meta.dart';

import '../../../domain/entities/user.dart';
import '../../../domain/usecases/login_usecase.dart';

part 'login_state.dart';

class LoginCubit extends Cubit<LoginState> {
  final LoginUseCase loginUseCase;

  LoginCubit(this.loginUseCase) : super(LoginInitial());

  Future<void> login({
    required String phoneOrEmail,
    required String password,
    required String notiId,
    required String mobileId,
    required String mobileType,
    required String type,
  }) async {
    final result = await loginUseCase.call(
      mobileId: mobileId,
      mobileType: mobileType,
      notiId: notiId,
      phoneOrEmail: phoneOrEmail,
      type: type,
      password: password,
    );
    emit(LoginLoading());

    result.fold(
      (failure) => emit(LoginFailure(failure.message)),
      (user) => emit(LoginSuccess(user)),
    );
  }
}
