part of 'notification_cubit.dart';

@freezed
class NotificationState with _$NotificationState {
  const factory NotificationState.initial() = _Initial;
  const factory NotificationState.loading() = _Loading;
  const factory NotificationState.success(
    NotificationEntity notificationEntity,
  ) = _Success;
  const factory NotificationState.error(NetworkExceptions networkExceptions) =
      _Error;
}
