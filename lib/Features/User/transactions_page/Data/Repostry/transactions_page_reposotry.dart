import 'package:dartz/dartz.dart';
import 'package:employee_application/Core/Network/network_info.dart';
import 'package:employee_application/Core/error/network_exceptions.dart';
import 'package:employee_application/Features/User/transactions_page/Data/Model/transactions_page_entity.dart';
import 'package:employee_application/Features/User/transactions_page/Data/Repostry/basereposotry_transactions_page.dart';
import 'package:employee_application/Features/User/transactions_page/Data/Web%20Service/transactions_page_webservice.dart';
import 'package:injectable/injectable.dart';

@Singleton(as: BaseReposotrytransactionsPage)
class TransactionsPageReposotryImpl implements BaseReposotrytransactionsPage {
  final NetworkInfo _networkInfo;
  final TransactionsPageWebService _transactionsPageWebService;

  TransactionsPageReposotryImpl({
    required NetworkInfo networkInfo,
    required TransactionsPageWebService transactionsPageWebService,
  }) : _networkInfo = networkInfo,
       _transactionsPageWebService = transactionsPageWebService;

  @override
  Future<Either<NetworkExceptions, TransactionsPageEntity>> transactionsPage(
    String? search,
    String? selectedStatus,
    String? selectedDay,
    String? selectedMonth,
    String? selectedYear,
  ) async {
    if (await _networkInfo.isConnected) {
      try {
        final response = await _transactionsPageWebService.transactionsPage(
          search,
          selectedStatus,
          selectedDay,
          selectedMonth,
          selectedYear,
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
