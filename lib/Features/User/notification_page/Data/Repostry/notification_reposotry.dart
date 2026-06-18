import 'package:dartz/dartz.dart';
import 'package:employee_application/Core/Network/network_info.dart';
import 'package:employee_application/Core/error/network_exceptions.dart';
import 'package:employee_application/Features/User/notification_page/Data/Model/notification_entity.dart';
import 'package:employee_application/Features/User/notification_page/Data/Repostry/basereposotry_notification.dart';
import 'package:employee_application/Features/User/notification_page/Data/Web%20Service/notification_webservice.dart';
import 'package:injectable/injectable.dart';

@Singleton(as: BaseReposotrynotification)
class NotificationReposotryImpl implements BaseReposotrynotification {
  final NetworkInfo _networkInfo;
  final NotificationWebService _notificationWebService;

  NotificationReposotryImpl({
    required NetworkInfo networkInfo,
    required NotificationWebService notificationWebService,
  }) : _networkInfo = networkInfo,
       _notificationWebService = notificationWebService;

  @override
  Future<Either<NetworkExceptions, NotificationEntity>> notification() async {
    if (await _networkInfo.isConnected) {
      try {
        final response = await _notificationWebService.notification();
        return Right(response);
      } catch (e) {
        return Left(NetworkExceptions.getException(e));
      }
    } else {
      return const Left(NetworkExceptions.noInternetConnection());
    }
  }
}
