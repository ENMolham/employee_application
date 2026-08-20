import 'package:employee_application/Core/api/api_consumer.dart';
import 'package:employee_application/Core/api/end_points.dart';
import 'package:employee_application/Features/User/transactions_page/manager/get_number_notifications/Data/Model/get_number_notifications_entity.dart';
import 'package:injectable/injectable.dart';

abstract class GetNumberNotificationsWebService {
  Future<GetNumberNotificationsEntity> getNumberNotifications();
}

@Singleton(as: GetNumberNotificationsWebService)
class GetNumberNotificationsWebServiceImpl
    implements GetNumberNotificationsWebService {
  final ApiConsumer _apiConsumer;

  GetNumberNotificationsWebServiceImpl(this._apiConsumer);

  @override
  Future<GetNumberNotificationsEntity> getNumberNotifications() async {
    final response = await _apiConsumer.get(
      EndPoints.getNumberNotificationsUrl,
    );
    return GetNumberNotificationsEntity.fromJson(response);
  }
}
