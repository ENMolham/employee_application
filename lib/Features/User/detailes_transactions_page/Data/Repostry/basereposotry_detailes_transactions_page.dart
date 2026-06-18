import 'package:dartz/dartz.dart';
import 'package:employee_application/Core/error/network_exceptions.dart';
import 'package:employee_application/Features/User/detailes_transactions_page/Data/Model/detailes_transactions_page_entity.dart';

abstract class BaseReposotrydetailesTransactionsPage {
  Future<Either<NetworkExceptions, DetailesTransactionsPageEntity>>
  detailesTransactionsPage(String idTransaction);
}
