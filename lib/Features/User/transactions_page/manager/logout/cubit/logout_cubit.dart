import 'dart:async';

import 'package:employee_application/Core/error/network_exceptions.dart';
import 'package:employee_application/Features/User/transactions_page/manager/logout/Data/Model/logout_entity.dart';
import 'package:employee_application/Features/User/transactions_page/manager/logout/Data/Repostry/basereposotry_logout.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:injectable/injectable.dart';

part 'logout_state.dart';
part 'logout_cubit.freezed.dart';

@injectable
class LogOutCubit extends Cubit<LogOutState> {
  LogOutCubit(this._baseReposotrylogOut) : super(const LogOutState.initial());

  final BaseReposotrylogOut _baseReposotrylogOut;

  Future<void> emitlogOut() async {
    emit(const LogOutState.loading());
    if (isClosed) return;
    final response = await _baseReposotrylogOut.logOut();
    response.fold((l) => emit(LogOutState.error(l)), (r) {
      emit(LogOutState.success(r));
    });
  }

  Future<void> fakEmitlogOut() async {
    emit(const LogOutState.loading());
    if (isClosed) return;
    await Future.delayed(const Duration(milliseconds: 1500));
    emit(LogOutState.success(LogOutEntity(message: "تم ارسال الرد بنجاح")));
    return;
  }
}
