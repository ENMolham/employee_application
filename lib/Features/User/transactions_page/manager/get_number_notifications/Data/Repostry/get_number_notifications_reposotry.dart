import 'package:employee_application/Core/Network/network_info.dart';
import 'package:employee_application/Core/error/network_exceptions.dart';
import 'package:dartz/dartz.dart';
import 'package:employee_application/Features/User/transactions_page/manager/get_number_notifications/Data/Model/get_number_notifications_entity.dart';
import 'package:employee_application/Features/User/transactions_page/manager/get_number_notifications/Data/Repostry/basereposotry_get_number_notifications.dart';
import 'package:employee_application/Features/User/transactions_page/manager/get_number_notifications/Data/Web%20Service/get_number_notifications_webservice.dart';
import 'package:injectable/injectable.dart';

@Singleton(as: BaseReposotrygetNumberNotifications)
class GetNumberNotificationsReposotryImpl
    implements BaseReposotrygetNumberNotifications {
  final NetworkInfo _networkInfo;
  final GetNumberNotificationsWebService _getNumberNotificationsWebService;

  GetNumberNotificationsReposotryImpl({
    required NetworkInfo networkInfo,
    required GetNumberNotificationsWebService getNumberNotificationsWebService,
  }) : _networkInfo = networkInfo,
       _getNumberNotificationsWebService = getNumberNotificationsWebService;

  @override
  Future<Either<NetworkExceptions, GetNumberNotificationsEntity>>
  getNumberNotifications() async {
    if (await _networkInfo.isConnected) {
      try {
        final response = await _getNumberNotificationsWebService
            .getNumberNotifications();
        return Right(response);
      } catch (e) {
        return Left(NetworkExceptions.getException(e));
      }
    } else {
      return const Left(NetworkExceptions.noInternetConnection());
    }
  }
}
