part of 'add_repliy_cubit.dart';

@freezed
class AddRepliyState with _$AddRepliyState {
  const factory AddRepliyState.initial() = _Initial;
  const factory AddRepliyState.loading() = _Loading;
  const factory AddRepliyState.success(AddRepliyEntity addRepliyEntity) =
      _Success;
  const factory AddRepliyState.error(NetworkExceptions networkExceptions) =
      _Error;
}
