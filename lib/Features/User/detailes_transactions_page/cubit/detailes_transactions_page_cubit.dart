import 'dart:async';

import 'package:employee_application/Core/error/network_exceptions.dart';
import 'package:employee_application/Features/User/detailes_transactions_page/Data/Model/detailes_transactions_page_entity.dart';
import 'package:employee_application/Features/User/detailes_transactions_page/Data/Repostry/basereposotry_detailes_transactions_page.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:injectable/injectable.dart';

part 'detailes_transactions_page_state.dart';
part 'detailes_transactions_page_cubit.freezed.dart';

@injectable
class DetailesTransactionsPageCubit
    extends Cubit<DetailesTransactionsPageState> {
  DetailesTransactionsPageCubit(this._baseReposotrydetailesTransactionsPage)
    : super(const DetailesTransactionsPageState.initial());

  final BaseReposotrydetailesTransactionsPage
  _baseReposotrydetailesTransactionsPage;

  Future<void> emitdetailesTransactionsPage(String idTransaction) async {
    emit(const DetailesTransactionsPageState.loading());
    if (isClosed) return;
    final response = await _baseReposotrydetailesTransactionsPage
        .detailesTransactionsPage(idTransaction);
    response.fold((l) => emit(DetailesTransactionsPageState.error(l)), (r) {
      emit(DetailesTransactionsPageState.success(r));
    });
  }
}
