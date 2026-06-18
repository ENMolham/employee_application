import 'package:employee_application/Core/api/api_consumer.dart'
    show ApiConsumer;
import 'package:employee_application/Core/api/end_points.dart';
import 'package:employee_application/Features/Auth/login/Data/Model/login_entity.dart';
import 'package:injectable/injectable.dart';

abstract class LoginWebService {
  Future<LoginEntity> login(String login, String password, String deviceToken);
}

@Singleton(as: LoginWebService)
class LoginWebServiceImpl implements LoginWebService {
  final ApiConsumer _apiConsumer;

  LoginWebServiceImpl(this._apiConsumer);

  @override
  Future<LoginEntity> login(
    String login,
    String password,
    String deviceToken,
  ) async {
    final response = await _apiConsumer.post(
      EndPoints.loginUrl,
      body: {"login": login, "password": password, "device_name": deviceToken},
    );
    return LoginEntity.fromJson(response);
  }
}
