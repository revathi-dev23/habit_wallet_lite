// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'account_aggregator_models.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

_$AADataImpl _$$AADataImplFromJson(Map<String, dynamic> json) => _$AADataImpl(
  account: AAAccount.fromJson(json['Account'] as Map<String, dynamic>),
);

Map<String, dynamic> _$$AADataImplToJson(_$AADataImpl instance) =>
    <String, dynamic>{'Account': instance.account};

_$AAAccountImpl _$$AAAccountImplFromJson(Map<String, dynamic> json) =>
    _$AAAccountImpl(
      type: json['type'] as String,
      maskedAccNumber: json['maskedAccNumber'] as String,
      version: json['version'] as String,
      profile: AAProfile.fromJson(json['Profile'] as Map<String, dynamic>),
      summary: AASummary.fromJson(json['Summary'] as Map<String, dynamic>),
      transactions: AATransactions.fromJson(
        json['Transactions'] as Map<String, dynamic>,
      ),
    );

Map<String, dynamic> _$$AAAccountImplToJson(_$AAAccountImpl instance) =>
    <String, dynamic>{
      'type': instance.type,
      'maskedAccNumber': instance.maskedAccNumber,
      'version': instance.version,
      'Profile': instance.profile,
      'Summary': instance.summary,
      'Transactions': instance.transactions,
    };

_$AAProfileImpl _$$AAProfileImplFromJson(Map<String, dynamic> json) =>
    _$AAProfileImpl(
      holders: AAHolders.fromJson(json['Holders'] as Map<String, dynamic>),
    );

Map<String, dynamic> _$$AAProfileImplToJson(_$AAProfileImpl instance) =>
    <String, dynamic>{'Holders': instance.holders};

_$AAHoldersImpl _$$AAHoldersImplFromJson(Map<String, dynamic> json) =>
    _$AAHoldersImpl(
      type: json['type'] as String,
      holder: AAHolder.fromJson(json['Holder'] as Map<String, dynamic>),
    );

Map<String, dynamic> _$$AAHoldersImplToJson(_$AAHoldersImpl instance) =>
    <String, dynamic>{'type': instance.type, 'Holder': instance.holder};

_$AAHolderImpl _$$AAHolderImplFromJson(Map<String, dynamic> json) =>
    _$AAHolderImpl(
      name: json['name'] as String,
      mobile: json['mobile'] as String,
      address: json['address'] as String,
      email: json['email'] as String,
      pan: json['pan'] as String,
    );

Map<String, dynamic> _$$AAHolderImplToJson(_$AAHolderImpl instance) =>
    <String, dynamic>{
      'name': instance.name,
      'mobile': instance.mobile,
      'address': instance.address,
      'email': instance.email,
      'pan': instance.pan,
    };

_$AASummaryImpl _$$AASummaryImplFromJson(Map<String, dynamic> json) =>
    _$AASummaryImpl(
      currentBalance: json['currentBalance'] as String,
      currency: json['currency'] as String,
      type: json['type'] as String,
      ifscCode: json['ifscCode'] as String,
      pending:
          json['Pending'] == null
              ? null
              : AAPending.fromJson(json['Pending'] as Map<String, dynamic>),
    );

Map<String, dynamic> _$$AASummaryImplToJson(_$AASummaryImpl instance) =>
    <String, dynamic>{
      'currentBalance': instance.currentBalance,
      'currency': instance.currency,
      'type': instance.type,
      'ifscCode': instance.ifscCode,
      'Pending': instance.pending,
    };

_$AAPendingImpl _$$AAPendingImplFromJson(Map<String, dynamic> json) =>
    _$AAPendingImpl(
      transactionType: json['transactionType'] as String,
      amount: json['amount'] as String,
    );

Map<String, dynamic> _$$AAPendingImplToJson(_$AAPendingImpl instance) =>
    <String, dynamic>{
      'transactionType': instance.transactionType,
      'amount': instance.amount,
    };

_$AATransactionsImpl _$$AATransactionsImplFromJson(Map<String, dynamic> json) =>
    _$AATransactionsImpl(
      startDate: json['startDate'] as String,
      endDate: json['endDate'] as String,
      transactionList:
          (json['Transaction'] as List<dynamic>)
              .map((e) => AATransaction.fromJson(e as Map<String, dynamic>))
              .toList(),
    );

Map<String, dynamic> _$$AATransactionsImplToJson(
  _$AATransactionsImpl instance,
) => <String, dynamic>{
  'startDate': instance.startDate,
  'endDate': instance.endDate,
  'Transaction': instance.transactionList,
};

_$AATransactionImpl _$$AATransactionImplFromJson(Map<String, dynamic> json) =>
    _$AATransactionImpl(
      type: json['type'] as String,
      mode: json['mode'] as String,
      amount: json['amount'] as String,
      currentBalance: json['currentBalance'] as String,
      transactionTimestamp: json['transactionTimestamp'] as String,
      narration: json['narration'] as String,
      txnId: json['txnId'] as String,
    );

Map<String, dynamic> _$$AATransactionImplToJson(_$AATransactionImpl instance) =>
    <String, dynamic>{
      'type': instance.type,
      'mode': instance.mode,
      'amount': instance.amount,
      'currentBalance': instance.currentBalance,
      'transactionTimestamp': instance.transactionTimestamp,
      'narration': instance.narration,
      'txnId': instance.txnId,
    };
