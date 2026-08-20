import 'dart:async';

import 'package:employee_application/Core/error/network_exceptions.dart';
import 'package:employee_application/Features/User/detailes_transactions_page/manager/add_repliy/Data/Model/add_repliy_entity.dart';
import 'package:employee_application/Features/User/detailes_transactions_page/manager/add_repliy/Data/Repostry/basereposotry_add_repliy.dart';
import 'package:file_picker/file_picker.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:injectable/injectable.dart';

part 'add_repliy_state.dart';
part 'add_repliy_cubit.freezed.dart';

@injectable
class AddRepliyCubit extends Cubit<AddRepliyState> {
  AddRepliyCubit(this._baseReposotryaddRepliy)
    : super(const AddRepliyState.initial());

  final BaseReposotryaddRepliy _baseReposotryaddRepliy;

  Future<void> emitaddRepliy(
    String idTransaction,
    List<PlatformFile>? files,
    String? text,
  ) async {
    emit(const AddRepliyState.loading());
    if (isClosed) return;
    final response = await _baseReposotryaddRepliy.addRepliy(
      idTransaction,
      files,
      text,
    );
    response.fold((l) => emit(AddRepliyState.error(l)), (r) {
      emit(AddRepliyState.success(r));
    });
  }
}
