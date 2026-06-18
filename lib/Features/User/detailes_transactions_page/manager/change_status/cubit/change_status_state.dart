part of 'change_status_cubit.dart';

@freezed
class ChangeStatusState with _$ChangeStatusState {
  const factory ChangeStatusState.initial() = _Initial;
  const factory ChangeStatusState.loading() = _Loading;
  const factory ChangeStatusState.success(
    ChangeStatusEntity changeStatusEntity,
  ) = _Success;
  const factory ChangeStatusState.error(NetworkExceptions networkExceptions) =
      _Error;
}
