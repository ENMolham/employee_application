import 'package:employee_application/Core/api/api_consumer.dart';
import 'package:employee_application/Core/api/end_points.dart';
import 'package:employee_application/Features/User/detailes_transactions_page/Data/Model/detailes_transactions_page_entity.dart';
import 'package:injectable/injectable.dart';

abstract class DetailesTransactionsPageWebService {
  Future<DetailesTransactionsPageEntity> detailesTransactionsPage(
    String idTransaction,
  );
}

@Singleton(as: DetailesTransactionsPageWebService)
class DetailesTransactionsPageWebServiceImpl
    implements DetailesTransactionsPageWebService {
  final ApiConsumer _apiConsumer;

  DetailesTransactionsPageWebServiceImpl(this._apiConsumer);

  @override
  Future<DetailesTransactionsPageEntity> detailesTransactionsPage(
    String idTransaction,
  ) async {
    final response = await _apiConsumer.post(
      "${EndPoints.detailesTransactionsPageUrl}$idTransaction",
    );
    return DetailesTransactionsPageEntity.fromJson(response);
  }
}
