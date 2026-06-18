part of 'transactions_page_cubit.dart';

@freezed
class TransactionsPageState with _$TransactionsPageState {
  const factory TransactionsPageState.initial() = _Initial;
  const factory TransactionsPageState.loading() = _Loading;
  const factory TransactionsPageState.success(
    TransactionsPageEntity transactionsPageEntity,
  ) = _Success;
  const factory TransactionsPageState.error(
    NetworkExceptions networkExceptions,
  ) = _Error;
}
