import 'package:dartz/dartz.dart';
import 'package:employee_application/Core/error/network_exceptions.dart';
import 'package:employee_application/Features/User/detailes_transactions_page/manager/add_repliy/Data/Model/add_repliy_entity.dart';
import 'package:file_picker/file_picker.dart';

abstract class BaseReposotryaddRepliy {
  Future<Either<NetworkExceptions, AddRepliyEntity>> addRepliy(
    String idTransaction,
    List<PlatformFile>? files,
    String? text,
  );
}
