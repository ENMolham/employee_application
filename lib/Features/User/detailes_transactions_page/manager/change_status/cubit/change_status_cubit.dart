import 'dart:async';

import 'package:employee_application/Core/error/network_exceptions.dart';
import 'package:employee_application/Features/User/detailes_transactions_page/manager/change_status/Data/Model/change_status_entity.dart';
import 'package:employee_application/Features/User/detailes_transactions_page/manager/change_status/Data/Repostry/basereposotry_change_status.dart';
import 'package:file_picker/file_picker.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:injectable/injectable.dart';

part 'change_status_state.dart';
part 'change_status_cubit.freezed.dart';

@injectable
class ChangeStatusCubit extends Cubit<ChangeStatusState> {
  ChangeStatusCubit(this._baseReposotrychangeStatus)
    : super(const ChangeStatusState.initial());

  final BaseReposotrychangeStatus _baseReposotrychangeStatus;

  Future<void> emitchangeStatus(
    String idTransaction,
    String newStatus,
    List<PlatformFile>? files,
    String? text,
  ) async {
    emit(const ChangeStatusState.loading());
    if (isClosed) return;
    final response = await _baseReposotrychangeStatus.changeStatus(
      idTransaction,
      newStatus,
      files,
      text,
    );
    response.fold((l) => emit(ChangeStatusState.error(l)), (r) {
      emit(ChangeStatusState.success(r));
    });
  }

  Future<void> fakEmitchangeStatus(
    String idTransaction,
    String newStatus,
    List<PlatformFile>? files,
    String? text,
  ) async {
    emit(const ChangeStatusState.loading());
    if (isClosed) return;
    await Future.delayed(const Duration(milliseconds: 1500));
    emit(
      ChangeStatusState.success(
        ChangeStatusEntity(message: "تم تغير الحالة بنجاح"),
      ),
    );
    return;
  }
}
