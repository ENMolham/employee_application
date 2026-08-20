part of 'get_number_notifications_cubit.dart';

@freezed
class GetNumberNotificationsState with _$GetNumberNotificationsState {
  const factory GetNumberNotificationsState.initial() = _Initial;
  const factory GetNumberNotificationsState.loading() = _Loading;
  const factory GetNumberNotificationsState.success(
    GetNumberNotificationsEntity getNumberNotificationsEntity,
  ) = _Success;
  const factory GetNumberNotificationsState.error(
    NetworkExceptions networkExceptions,
  ) = _Error;
}
