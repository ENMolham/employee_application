import 'package:dartz/dartz.dart';
import 'package:employee_application/Core/error/network_exceptions.dart';
import 'package:employee_application/Features/Auth/login/Data/Model/login_entity.dart';

abstract class BaseReposotryLogin {
  Future<Either<NetworkExceptions, LoginEntity>> login(
    String login,
    String password,
    String deviceToken,
  );
}
