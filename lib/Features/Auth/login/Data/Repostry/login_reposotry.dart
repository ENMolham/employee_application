import 'package:dartz/dartz.dart';
import 'package:employee_application/Core/Network/network_info.dart';
import 'package:employee_application/Core/error/network_exceptions.dart';
import 'package:employee_application/Features/Auth/login/Data/Model/login_entity.dart';
import 'package:employee_application/Features/Auth/login/Data/Repostry/basereposotry_login.dart';
import 'package:employee_application/Features/Auth/login/Data/Web%20Service/login_webservice.dart';
import 'package:injectable/injectable.dart';

@Singleton(as: BaseReposotryLogin)
class LoginReposotryImpl implements BaseReposotryLogin {
  final NetworkInfo _networkInfo;
  final LoginWebService _loginWebService;

  LoginReposotryImpl({
    required NetworkInfo networkInfo,
    required LoginWebService loginWebService,
  }) : _networkInfo = networkInfo,
       _loginWebService = loginWebService;

  @override
  Future<Either<NetworkExceptions, LoginEntity>> login(
    String login,
    String password,
    String deviceToken,
  ) async {
    if (await _networkInfo.isConnected) {
      try {
        final response = await _loginWebService.login(
          login,
          password,
          deviceToken,
        );
        return Right(response);
      } catch (e) {
        return Left(NetworkExceptions.getException(e));
      }
    } else {
      return const Left(NetworkExceptions.noInternetConnection());
    }
  }
}
