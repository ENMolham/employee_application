import 'package:dartz/dartz.dart';
import 'package:employee_application/Core/Network/network_info.dart';
import 'package:employee_application/Core/error/network_exceptions.dart';
import 'package:employee_application/Features/User/detailes_transactions_page/manager/change_status/Data/Model/change_status_entity.dart';
import 'package:employee_application/Features/User/detailes_transactions_page/manager/change_status/Data/Repostry/basereposotry_change_status.dart';
import 'package:employee_application/Features/User/detailes_transactions_page/manager/change_status/Data/Web%20Service/change_status_webservice.dart';
import 'package:file_picker/file_picker.dart';
import 'package:injectable/injectable.dart';

@Singleton(as: BaseReposotrychangeStatus)
class ChangeStatusReposotryImpl implements BaseReposotrychangeStatus {
  final NetworkInfo _networkInfo;
  final ChangeStatusWebService _changeStatusWebService;

  ChangeStatusReposotryImpl({
    required NetworkInfo networkInfo,
    required ChangeStatusWebService changeStatusWebService,
  }) : _networkInfo = networkInfo,
       _changeStatusWebService = changeStatusWebService;

  @override
  Future<Either<NetworkExceptions, ChangeStatusEntity>> changeStatus(
    String idTransaction,
    String newStatus,
    List<PlatformFile>? files,
    String? text,
  ) async {
    if (await _networkInfo.isConnected) {
      try {
        final response = await _changeStatusWebService.changeStatus(
          idTransaction,
          newStatus,
          files,
          text,
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
