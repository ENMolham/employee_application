import 'dart:async';

import 'package:employee_application/Core/error/network_exceptions.dart';
import 'package:employee_application/Features/User/transactions_page/Data/Model/transactions_page_entity.dart';
import 'package:employee_application/Features/User/transactions_page/Data/Repostry/basereposotry_transactions_page.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:injectable/injectable.dart';

part 'transactions_page_state.dart';
part 'transactions_page_cubit.freezed.dart';

@injectable
class TransactionsPageCubit extends Cubit<TransactionsPageState> {
  TransactionsPageCubit(this._baseReposotrytransactionsPage)
    : super(const TransactionsPageState.initial());

  final BaseReposotrytransactionsPage _baseReposotrytransactionsPage;

  Future<void> emittransactionsPage(
    String? search,
    String? selectedStatus,
    String? selectedDay,
    String? selectedMonth,
    String? selectedYear,
  ) async {
    emit(const TransactionsPageState.loading());
    if (isClosed) return;
    final response = await _baseReposotrytransactionsPage.transactionsPage(
      search,
      selectedStatus,
      selectedDay,
      selectedMonth,
      selectedYear,
    );
    response.fold((l) => emit(TransactionsPageState.error(l)), (r) {
      emit(TransactionsPageState.success(r));
    });
  }
}
