import 'package:dartz/dartz.dart';
import 'package:employee_application/Core/error/network_exceptions.dart';
import 'package:employee_application/Features/User/detailes_transactions_page/manager/change_status/Data/Model/change_status_entity.dart';
import 'package:file_picker/file_picker.dart';

abstract class BaseReposotrychangeStatus {
  Future<Either<NetworkExceptions, ChangeStatusEntity>> changeStatus(
    String idTransaction,
    String newStatus,
    List<PlatformFile>? files,
    String? text,
  );
}
