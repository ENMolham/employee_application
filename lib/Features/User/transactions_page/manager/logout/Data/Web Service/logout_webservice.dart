import 'package:employee_application/Core/api/api_consumer.dart';
import 'package:employee_application/Core/api/end_points.dart';
import 'package:employee_application/Features/User/transactions_page/manager/logout/Data/Model/logout_entity.dart';
import 'package:injectable/injectable.dart';

abstract class LogOutWebService {
  Future<LogOutEntity> logOut();
}

@Singleton(as: LogOutWebService)
class LogOutWebServiceImpl implements LogOutWebService {
  final ApiConsumer _apiConsumer;

  LogOutWebServiceImpl(this._apiConsumer);

  @override
  Future<LogOutEntity> logOut() async {
    final response = await _apiConsumer.get(EndPoints.logOutUrl);
    return LogOutEntity.fromJson(response);
  }
}
