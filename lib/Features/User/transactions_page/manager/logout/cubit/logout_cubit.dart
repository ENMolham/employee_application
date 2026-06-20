import 'dart:async';

import 'package:employee_application/Core/error/network_exceptions.dart';
import 'package:employee_application/Core/utils/shared_preference_utils.dart';
import 'package:employee_application/Features/User/transactions_page/manager/logout/Data/Model/logout_entity.dart';
import 'package:employee_application/Features/User/transactions_page/manager/logout/Data/Repostry/basereposotry_logout.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:injectable/injectable.dart';

part 'logout_state.dart';
part 'logout_cubit.freezed.dart';

@injectable
class LogOutCubit extends Cubit<LogOutState> {
  LogOutCubit(this._baseReposotrylogOut, this._sharedPreferencesUtils)
    : super(const LogOutState.initial());

  final BaseReposotrylogOut _baseReposotrylogOut;
  final SharedPreferencesUtils _sharedPreferencesUtils;

  Future<void> emitlogOut() async {
    emit(const LogOutState.loading());
    if (isClosed) return;
    final response = await _baseReposotrylogOut.logOut();
    response.fold((l) => emit(LogOutState.error(l)), (r) {
      _sharedPreferencesUtils.removeToken();
      _sharedPreferencesUtils.removeUserName();
      _sharedPreferencesUtils.removeImageUrl();
      _sharedPreferencesUtils.removeGovernmentEntity();
      emit(LogOutState.success(r));
    });
  }

  Future<void> fakEmitlogOut() async {
    emit(const LogOutState.loading());
    if (isClosed) return;
    await Future.delayed(const Duration(milliseconds: 1500));
    _sharedPreferencesUtils.removeToken();
    _sharedPreferencesUtils.removeUserName();
    _sharedPreferencesUtils.removeImageUrl();
    _sharedPreferencesUtils.removeGovernmentEntity();
    emit(LogOutState.success(LogOutEntity(message: "تم تسجيل الخروج بنجاح")));
    return;
  }
}
