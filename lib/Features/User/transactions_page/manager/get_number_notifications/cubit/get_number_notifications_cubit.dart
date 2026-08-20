import 'dart:async';

import 'package:employee_application/Core/error/network_exceptions.dart';
import 'package:employee_application/Features/User/transactions_page/manager/get_number_notifications/Data/Model/get_number_notifications_entity.dart';
import 'package:employee_application/Features/User/transactions_page/manager/get_number_notifications/Data/Repostry/basereposotry_get_number_notifications.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:injectable/injectable.dart';

part 'get_number_notifications_state.dart';
part 'get_number_notifications_cubit.freezed.dart';

@injectable
class GetNumberNotificationsCubit extends Cubit<GetNumberNotificationsState> {
  GetNumberNotificationsCubit(this._baseReposotrygetNumberNotifications)
    : super(const GetNumberNotificationsState.initial());

  final BaseReposotrygetNumberNotifications
  _baseReposotrygetNumberNotifications;

  Future<void> emitgetNumberNotifications() async {
    emit(const GetNumberNotificationsState.loading());
    if (isClosed) return;
    final response = await _baseReposotrygetNumberNotifications
        .getNumberNotifications();

    response.fold((l) => emit(GetNumberNotificationsState.error(l)), (r) {
      emit(GetNumberNotificationsState.success(r));
    });
  }
}
