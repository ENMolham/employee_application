import 'package:dartz/dartz.dart';
import 'package:employee_application/Core/error/network_exceptions.dart';
import 'package:employee_application/Features/User/transactions_page/Data/Model/transactions_page_entity.dart';

abstract class BaseReposotrytransactionsPage {
  Future<Either<NetworkExceptions, TransactionsPageEntity>> transactionsPage(
    String? search,
    String? selectedStatus,
    String? selectedDay,
    String? selectedMonth,
    String? selectedYear,
  );
}
