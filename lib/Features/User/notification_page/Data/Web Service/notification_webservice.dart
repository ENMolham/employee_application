import 'package:employee_application/Core/api/api_consumer.dart';
import 'package:employee_application/Core/api/end_points.dart';
import 'package:employee_application/Features/User/notification_page/Data/Model/notification_entity.dart';
import 'package:injectable/injectable.dart';

abstract class NotificationWebService {
  Future<NotificationEntity> notification();
}

@Singleton(as: NotificationWebService)
class NotificationWebServiceImpl implements NotificationWebService {
  final ApiConsumer _apiConsumer;

  NotificationWebServiceImpl(this._apiConsumer);

  @override
  Future<NotificationEntity> notification() async {
    final response = await _apiConsumer.get(EndPoints.notificationUrl);
    return NotificationEntity.fromJson(response);
  }
}
