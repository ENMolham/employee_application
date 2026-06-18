import 'package:dartz/dartz.dart';
import 'package:employee_application/Core/Network/network_info.dart';
import 'package:employee_application/Core/error/network_exceptions.dart';
import 'package:employee_application/Features/User/detailes_transactions_page/Data/Model/detailes_transactions_page_entity.dart';
import 'package:employee_application/Features/User/detailes_transactions_page/Data/Repostry/basereposotry_detailes_transactions_page.dart';
import 'package:employee_application/Features/User/detailes_transactions_page/Data/Web%20Service/detailes_transactions_page_webservice.dart';
import 'package:injectable/injectable.dart';

@Singleton(as: BaseReposotrydetailesTransactionsPage)
class DetailesTransactionsPageReposotryImpl
    implements BaseReposotrydetailesTransactionsPage {
  final NetworkInfo _networkInfo;
  final DetailesTransactionsPageWebService _detailesTransactionsPageWebService;

  DetailesTransactionsPageReposotryImpl({
    required NetworkInfo networkInfo,
    required DetailesTransactionsPageWebService
    detailesTransactionsPageWebService,
  }) : _networkInfo = networkInfo,
       _detailesTransactionsPageWebService = detailesTransactionsPageWebService;

  @override
  Future<Either<NetworkExceptions, DetailesTransactionsPageEntity>>
  detailesTransactionsPage(String idTransaction) async {
    if (await _networkInfo.isConnected) {
      try {
        final response = await _detailesTransactionsPageWebService
            .detailesTransactionsPage(idTransaction);
        return Right(response);
      } catch (e) {
        return Left(NetworkExceptions.getException(e));
      }
    } else {
      return const Left(NetworkExceptions.noInternetConnection());
    }
  }
}
