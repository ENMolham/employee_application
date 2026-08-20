import 'package:dartz/dartz.dart';
import 'package:employee_application/Core/error/network_exceptions.dart';
import 'package:employee_application/Features/Auth/logout/Data/Model/logout_entity.dart';

abstract class BaseReposotrylogOut {
  Future<Either<NetworkExceptions, LogOutEntity>> logOut();
}
