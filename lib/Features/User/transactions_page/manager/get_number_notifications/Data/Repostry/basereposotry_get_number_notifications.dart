import 'package:employee_application/Core/error/network_exceptions.dart';
import 'package:dartz/dartz.dart';
import 'package:employee_application/Features/User/transactions_page/manager/get_number_notifications/Data/Model/get_number_notifications_entity.dart';

abstract class BaseReposotrygetNumberNotifications {
  Future<Either<NetworkExceptions, GetNumberNotificationsEntity>>
  getNumberNotifications();
}
