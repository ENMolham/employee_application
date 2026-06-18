part of 'detailes_transactions_page_cubit.dart';

@freezed
class DetailesTransactionsPageState with _$DetailesTransactionsPageState {
  const factory DetailesTransactionsPageState.initial() = _Initial;
  const factory DetailesTransactionsPageState.loading() = _Loading;
  const factory DetailesTransactionsPageState.success(
    DetailesTransactionsPageEntity detailesTransactionsPageEntity,
  ) = _Success;
  const factory DetailesTransactionsPageState.error(
    NetworkExceptions networkExceptions,
  ) = _Error;
}
