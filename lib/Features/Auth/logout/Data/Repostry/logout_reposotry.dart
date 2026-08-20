import 'package:dartz/dartz.dart';
import 'package:employee_application/Core/Network/network_info.dart';
import 'package:employee_application/Core/error/network_exceptions.dart';
import 'package:employee_application/Features/Auth/logout/Data/Model/logout_entity.dart';
import 'package:employee_application/Features/Auth/logout/Data/Repostry/basereposotry_logout.dart';
import 'package:employee_application/Features/Auth/logout/Data/Web%20Service/logout_webservice.dart';
import 'package:injectable/injectable.dart';

@Singleton(as: BaseReposotrylogOut)
class LogOutReposotryImpl implements BaseReposotrylogOut {
  final NetworkInfo _networkInfo;
  final LogOutWebService _logOutWebService;

  LogOutReposotryImpl({
    required NetworkInfo networkInfo,
    required LogOutWebService logOutWebService,
  }) : _networkInfo = networkInfo,
       _logOutWebService = logOutWebService;

  @override
  Future<Either<NetworkExceptions, LogOutEntity>> logOut() async {
    if (await _networkInfo.isConnected) {
      try {
        final response = await _logOutWebService.logOut();
        return Right(response);
      } catch (e) {
        return Left(NetworkExceptions.getException(e));
      }
    } else {
      return const Left(NetworkExceptions.noInternetConnection());
    }
  }
}
