import 'package:dartz/dartz.dart';
import 'package:employee_application/Core/error/network_exceptions.dart';
import 'package:employee_application/Features/User/notification_page/Data/Model/notification_entity.dart';

abstract class BaseReposotrynotification {
  Future<Either<NetworkExceptions, NotificationEntity>> notification();
}
