// ignore_for_file: invalid_annotation_target
import 'package:freezed_annotation/freezed_annotation.dart';

part 'account_aggregator_models.freezed.dart';
part 'account_aggregator_models.g.dart';

@freezed
class AAData with _$AAData {
  const factory AAData({
    @JsonKey(name: 'Account') required AAAccount account,
  }) = _AAData;

  factory AAData.fromJson(Map<String, dynamic> json) => _$AADataFromJson(json);
}

@freezed
class AAAccount with _$AAAccount {
  const factory AAAccount({
    required String type,
    required String maskedAccNumber,
    required String version,
    @JsonKey(name: 'Profile') required AAProfile profile,
    @JsonKey(name: 'Summary') required AASummary summary,
    @JsonKey(name: 'Transactions') required AATransactions transactions,
  }) = _AAAccount;

  factory AAAccount.fromJson(Map<String, dynamic> json) => _$AAAccountFromJson(json);
}

@freezed
class AAProfile with _$AAProfile {
  const factory AAProfile({
    @JsonKey(name: 'Holders') required AAHolders holders,
  }) = _AAProfile;

  factory AAProfile.fromJson(Map<String, dynamic> json) => _$AAProfileFromJson(json);
}

@freezed
class AAHolders with _$AAHolders {
  const factory AAHolders({
    required String type,
    @JsonKey(name: 'Holder') required AAHolder holder,
  }) = _AAHolders;

  factory AAHolders.fromJson(Map<String, dynamic> json) => _$AAHoldersFromJson(json);
}

@freezed
class AAHolder with _$AAHolder {
  const factory AAHolder({
    required String name,
    required String mobile,
    required String address,
    required String email,
    required String pan,
  }) = _AAHolder;

  factory AAHolder.fromJson(Map<String, dynamic> json) => _$AAHolderFromJson(json);
}

@freezed
class AASummary with _$AASummary {
  const factory AASummary({
    required String currentBalance,
    required String currency,
    required String type,
    required String ifscCode,
    @JsonKey(name: 'Pending') required AAPending? pending,
  }) = _AASummary;

  factory AASummary.fromJson(Map<String, dynamic> json) => _$AASummaryFromJson(json);
}

@freezed
class AAPending with _$AAPending {
  const factory AAPending({
    required String transactionType,
    required String amount,
  }) = _AAPending;

  factory AAPending.fromJson(Map<String, dynamic> json) => _$AAPendingFromJson(json);
}

@freezed
class AATransactions with _$AATransactions {
  const factory AATransactions({
    required String startDate,
    required String endDate,
    @JsonKey(name: 'Transaction') required List<AATransaction> transactionList,
  }) = _AATransactions;

  factory AATransactions.fromJson(Map<String, dynamic> json) => _$AATransactionsFromJson(json);
}

@freezed
class AATransaction with _$AATransaction {
  const factory AATransaction({
    required String type,
    required String mode,
    required String amount,
    required String currentBalance,
    required String transactionTimestamp,
    required String narration,
    required String txnId,
  }) = _AATransaction;

  factory AATransaction.fromJson(Map<String, dynamic> json) => _$AATransactionFromJson(json);
}
