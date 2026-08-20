part of 'logout_cubit.dart';

@freezed
class LogOutState with _$LogOutState {
  const factory LogOutState.initial() = _Initial;
  const factory LogOutState.loading() = _Loading;
  const factory LogOutState.success(LogOutEntity logOutEntity) = _Success;
  const factory LogOutState.error(NetworkExceptions networkExceptions) = _Error;
}
