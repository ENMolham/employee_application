import 'package:employee_application/Core/api/api_consumer.dart';
import 'package:employee_application/Core/api/end_points.dart';
import 'package:employee_application/Features/User/transactions_page/Data/Model/transactions_page_entity.dart';
import 'package:injectable/injectable.dart';

abstract class TransactionsPageWebService {
  Future<TransactionsPageEntity> transactionsPage(
    String? search,
    String? selectedStatus,
    String? selectedDay,
    String? selectedMonth,
    String? selectedYear,
  );
}

@Singleton(as: TransactionsPageWebService)
class TransactionsPageWebServiceImpl implements TransactionsPageWebService {
  final ApiConsumer _apiConsumer;

  TransactionsPageWebServiceImpl(this._apiConsumer);

  @override
  Future<TransactionsPageEntity> transactionsPage(
    String? search,
    String? selectedStatus,
    String? selectedDay,
    String? selectedMonth,
    String? selectedYear,
  ) async {
    final body = {
      if (search?.isNotEmpty ?? false) 'search': search,
      if (selectedStatus?.isNotEmpty ?? false) 'selectedStatus': selectedStatus,
      if (selectedDay?.isNotEmpty ?? false) 'selectedDay': selectedDay,
      if (selectedMonth?.isNotEmpty ?? false) 'selectedMonth': selectedMonth,
      if (selectedYear?.isNotEmpty ?? false) 'selectedYear': selectedYear,
    };
    final response = await _apiConsumer.post(
      EndPoints.transactionsPageUrl,
      body: body,
    );
    return TransactionsPageEntity.fromJson(response);
  }
}
