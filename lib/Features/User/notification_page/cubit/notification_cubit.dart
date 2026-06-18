import 'dart:async';

import 'package:employee_application/Core/error/network_exceptions.dart';
import 'package:employee_application/Features/User/notification_page/Data/Model/notification_entity.dart';
import 'package:employee_application/Features/User/notification_page/Data/Repostry/basereposotry_notification.dart';
import 'package:employee_application/trash/fak_notification_entity.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:injectable/injectable.dart';

part 'notification_state.dart';
part 'notification_cubit.freezed.dart';

@injectable
class NotificationCubit extends Cubit<NotificationState> {
  NotificationCubit(this._baseReposotrynotification)
    : super(const NotificationState.initial());

  final BaseReposotrynotification _baseReposotrynotification;

  Future<void> emitnotification() async {
    emit(const NotificationState.loading());
    final response = await _baseReposotrynotification.notification();
    if (isClosed) return;
    response.fold((l) => emit(NotificationState.error(l)), (r) {
      emit(NotificationState.success(r));
    });
  }

  Future<void> fakEmitnotification() async {
    emit(const NotificationState.loading());
    if (isClosed) return;
    await Future.delayed(const Duration(milliseconds: 1500));
    emit(NotificationState.success(faknotificationEntity));
    return;
  }
}
