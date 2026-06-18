import 'package:dartz/dartz.dart';
import 'package:employee_application/Core/Network/network_info.dart';
import 'package:employee_application/Core/error/network_exceptions.dart';
import 'package:employee_application/Features/User/detailes_transactions_page/manager/add_repliy/Data/Model/add_repliy_entity.dart';
import 'package:employee_application/Features/User/detailes_transactions_page/manager/add_repliy/Data/Repostry/basereposotry_add_repliy.dart';
import 'package:employee_application/Features/User/detailes_transactions_page/manager/add_repliy/Data/Web%20Service/add_repliy_webservice.dart';
import 'package:file_picker/file_picker.dart';
import 'package:injectable/injectable.dart';

@Singleton(as: BaseReposotryaddRepliy)
class AddRepliyReposotryImpl implements BaseReposotryaddRepliy {
  final NetworkInfo _networkInfo;
  final AddRepliyWebService _addRepliyWebService;

  AddRepliyReposotryImpl({
    required NetworkInfo networkInfo,
    required AddRepliyWebService addRepliyWebService,
  }) : _networkInfo = networkInfo,
       _addRepliyWebService = addRepliyWebService;

  @override
  Future<Either<NetworkExceptions, AddRepliyEntity>> addRepliy(
    String idTransaction,
    List<PlatformFile>? files,
    String? text,
  ) async {
    if (await _networkInfo.isConnected) {
      try {
        final response = await _addRepliyWebService.addRepliy(
          idTransaction,

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
