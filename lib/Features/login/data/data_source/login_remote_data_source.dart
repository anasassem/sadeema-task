import '../../../../core/utils/api_service.dart';
import '../../domain/entities/user.dart';
import '../models/user_model.dart';

abstract class LoginRemoteDataSource {
  Future<UserEntity> login({
    required String phoneOrEmail,
    required String password,
    required String notiId,
    required String mobileId,
    required String mobileType,
    required String type,
  });
}

class LoginRemoteDataSourceImpl extends LoginRemoteDataSource {
  final ApiService apiService;

  LoginRemoteDataSourceImpl(this.apiService);

  @override
  Future<UserEntity> login({
    required String phoneOrEmail,
    required String password,
    required String notiId,
    required String mobileId,
    required String mobileType,
    required String type,
  }) async {
    var response = await apiService.post(
      endPoint: "login",
      data: {
        "email_or_phone": phoneOrEmail,
        "password": password,
        "noti_id": notiId,
        "mobile_id": mobileId,
        "mobile_type": mobileType,
        "type": type,
      },
    );

    return LoginData.fromJson(
      response["data"]["login_data"],
      token: response["data"]["token"],
    );
  }
}
