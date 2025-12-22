// coverage:ignore-file
// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'account_aggregator_models.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

T _$identity<T>(T value) => value;

final _privateConstructorUsedError = UnsupportedError(
  'It seems like you constructed your class using `MyClass._()`. This constructor is only meant to be used by freezed and you are not supposed to need it nor use it.\nPlease check the documentation here for more information: https://github.com/rrousselGit/freezed#adding-getters-and-methods-to-our-models',
);

AAData _$AADataFromJson(Map<String, dynamic> json) {
  return _AAData.fromJson(json);
}

/// @nodoc
mixin _$AAData {
  @JsonKey(name: 'Account')
  AAAccount get account => throw _privateConstructorUsedError;

  /// Serializes this AAData to a JSON map.
  Map<String, dynamic> toJson() => throw _privateConstructorUsedError;

  /// Create a copy of AAData
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  $AADataCopyWith<AAData> get copyWith => throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $AADataCopyWith<$Res> {
  factory $AADataCopyWith(AAData value, $Res Function(AAData) then) =
      _$AADataCopyWithImpl<$Res, AAData>;
  @useResult
  $Res call({@JsonKey(name: 'Account') AAAccount account});

  $AAAccountCopyWith<$Res> get account;
}

/// @nodoc
class _$AADataCopyWithImpl<$Res, $Val extends AAData>
    implements $AADataCopyWith<$Res> {
  _$AADataCopyWithImpl(this._value, this._then);

  // ignore: unused_field
  final $Val _value;
  // ignore: unused_field
  final $Res Function($Val) _then;

  /// Create a copy of AAData
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({Object? account = null}) {
    return _then(
      _value.copyWith(
            account:
                null == account
                    ? _value.account
                    : account // ignore: cast_nullable_to_non_nullable
                        as AAAccount,
          )
          as $Val,
    );
  }

  /// Create a copy of AAData
  /// with the given fields replaced by the non-null parameter values.
  @override
  @pragma('vm:prefer-inline')
  $AAAccountCopyWith<$Res> get account {
    return $AAAccountCopyWith<$Res>(_value.account, (value) {
      return _then(_value.copyWith(account: value) as $Val);
    });
  }
}

/// @nodoc
abstract class _$$AADataImplCopyWith<$Res> implements $AADataCopyWith<$Res> {
  factory _$$AADataImplCopyWith(
    _$AADataImpl value,
    $Res Function(_$AADataImpl) then,
  ) = __$$AADataImplCopyWithImpl<$Res>;
  @override
  @useResult
  $Res call({@JsonKey(name: 'Account') AAAccount account});

  @override
  $AAAccountCopyWith<$Res> get account;
}

/// @nodoc
class __$$AADataImplCopyWithImpl<$Res>
    extends _$AADataCopyWithImpl<$Res, _$AADataImpl>
    implements _$$AADataImplCopyWith<$Res> {
  __$$AADataImplCopyWithImpl(
    _$AADataImpl _value,
    $Res Function(_$AADataImpl) _then,
  ) : super(_value, _then);

  /// Create a copy of AAData
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({Object? account = null}) {
    return _then(
      _$AADataImpl(
        account:
            null == account
                ? _value.account
                : account // ignore: cast_nullable_to_non_nullable
                    as AAAccount,
      ),
    );
  }
}

/// @nodoc
@JsonSerializable()
class _$AADataImpl implements _AAData {
  const _$AADataImpl({@JsonKey(name: 'Account') required this.account});

  factory _$AADataImpl.fromJson(Map<String, dynamic> json) =>
      _$$AADataImplFromJson(json);

  @override
  @JsonKey(name: 'Account')
  final AAAccount account;

  @override
  String toString() {
    return 'AAData(account: $account)';
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$AADataImpl &&
            (identical(other.account, account) || other.account == account));
  }

  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  int get hashCode => Object.hash(runtimeType, account);

  /// Create a copy of AAData
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  @pragma('vm:prefer-inline')
  _$$AADataImplCopyWith<_$AADataImpl> get copyWith =>
      __$$AADataImplCopyWithImpl<_$AADataImpl>(this, _$identity);

  @override
  Map<String, dynamic> toJson() {
    return _$$AADataImplToJson(this);
  }
}

abstract class _AAData implements AAData {
  const factory _AAData({
    @JsonKey(name: 'Account') required final AAAccount account,
  }) = _$AADataImpl;

  factory _AAData.fromJson(Map<String, dynamic> json) = _$AADataImpl.fromJson;

  @override
  @JsonKey(name: 'Account')
  AAAccount get account;

  /// Create a copy of AAData
  /// with the given fields replaced by the non-null parameter values.
  @override
  @JsonKey(includeFromJson: false, includeToJson: false)
  _$$AADataImplCopyWith<_$AADataImpl> get copyWith =>
      throw _privateConstructorUsedError;
}

AAAccount _$AAAccountFromJson(Map<String, dynamic> json) {
  return _AAAccount.fromJson(json);
}

/// @nodoc
mixin _$AAAccount {
  String get type => throw _privateConstructorUsedError;
  String get maskedAccNumber => throw _privateConstructorUsedError;
  String get version => throw _privateConstructorUsedError;
  @JsonKey(name: 'Profile')
  AAProfile get profile => throw _privateConstructorUsedError;
  @JsonKey(name: 'Summary')
  AASummary get summary => throw _privateConstructorUsedError;
  @JsonKey(name: 'Transactions')
  AATransactions get transactions => throw _privateConstructorUsedError;

  /// Serializes this AAAccount to a JSON map.
  Map<String, dynamic> toJson() => throw _privateConstructorUsedError;

  /// Create a copy of AAAccount
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  $AAAccountCopyWith<AAAccount> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $AAAccountCopyWith<$Res> {
  factory $AAAccountCopyWith(AAAccount value, $Res Function(AAAccount) then) =
      _$AAAccountCopyWithImpl<$Res, AAAccount>;
  @useResult
  $Res call({
    String type,
    String maskedAccNumber,
    String version,
    @JsonKey(name: 'Profile') AAProfile profile,
    @JsonKey(name: 'Summary') AASummary summary,
    @JsonKey(name: 'Transactions') AATransactions transactions,
  });

  $AAProfileCopyWith<$Res> get profile;
  $AASummaryCopyWith<$Res> get summary;
  $AATransactionsCopyWith<$Res> get transactions;
}

/// @nodoc
class _$AAAccountCopyWithImpl<$Res, $Val extends AAAccount>
    implements $AAAccountCopyWith<$Res> {
  _$AAAccountCopyWithImpl(this._value, this._then);

  // ignore: unused_field
  final $Val _value;
  // ignore: unused_field
  final $Res Function($Val) _then;

  /// Create a copy of AAAccount
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? type = null,
    Object? maskedAccNumber = null,
    Object? version = null,
    Object? profile = null,
    Object? summary = null,
    Object? transactions = null,
  }) {
    return _then(
      _value.copyWith(
            type:
                null == type
                    ? _value.type
                    : type // ignore: cast_nullable_to_non_nullable
                        as String,
            maskedAccNumber:
                null == maskedAccNumber
                    ? _value.maskedAccNumber
                    : maskedAccNumber // ignore: cast_nullable_to_non_nullable
                        as String,
            version:
                null == version
                    ? _value.version
                    : version // ignore: cast_nullable_to_non_nullable
                        as String,
            profile:
                null == profile
                    ? _value.profile
                    : profile // ignore: cast_nullable_to_non_nullable
                        as AAProfile,
            summary:
                null == summary
                    ? _value.summary
                    : summary // ignore: cast_nullable_to_non_nullable
                        as AASummary,
            transactions:
                null == transactions
                    ? _value.transactions
                    : transactions // ignore: cast_nullable_to_non_nullable
                        as AATransactions,
          )
          as $Val,
    );
  }

  /// Create a copy of AAAccount
  /// with the given fields replaced by the non-null parameter values.
  @override
  @pragma('vm:prefer-inline')
  $AAProfileCopyWith<$Res> get profile {
    return $AAProfileCopyWith<$Res>(_value.profile, (value) {
      return _then(_value.copyWith(profile: value) as $Val);
    });
  }

  /// Create a copy of AAAccount
  /// with the given fields replaced by the non-null parameter values.
  @override
  @pragma('vm:prefer-inline')
  $AASummaryCopyWith<$Res> get summary {
    return $AASummaryCopyWith<$Res>(_value.summary, (value) {
      return _then(_value.copyWith(summary: value) as $Val);
    });
  }

  /// Create a copy of AAAccount
  /// with the given fields replaced by the non-null parameter values.
  @override
  @pragma('vm:prefer-inline')
  $AATransactionsCopyWith<$Res> get transactions {
    return $AATransactionsCopyWith<$Res>(_value.transactions, (value) {
      return _then(_value.copyWith(transactions: value) as $Val);
    });
  }
}

/// @nodoc
abstract class _$$AAAccountImplCopyWith<$Res>
    implements $AAAccountCopyWith<$Res> {
  factory _$$AAAccountImplCopyWith(
    _$AAAccountImpl value,
    $Res Function(_$AAAccountImpl) then,
  ) = __$$AAAccountImplCopyWithImpl<$Res>;
  @override
  @useResult
  $Res call({
    String type,
    String maskedAccNumber,
    String version,
    @JsonKey(name: 'Profile') AAProfile profile,
    @JsonKey(name: 'Summary') AASummary summary,
    @JsonKey(name: 'Transactions') AATransactions transactions,
  });

  @override
  $AAProfileCopyWith<$Res> get profile;
  @override
  $AASummaryCopyWith<$Res> get summary;
  @override
  $AATransactionsCopyWith<$Res> get transactions;
}

/// @nodoc
class __$$AAAccountImplCopyWithImpl<$Res>
    extends _$AAAccountCopyWithImpl<$Res, _$AAAccountImpl>
    implements _$$AAAccountImplCopyWith<$Res> {
  __$$AAAccountImplCopyWithImpl(
    _$AAAccountImpl _value,
    $Res Function(_$AAAccountImpl) _then,
  ) : super(_value, _then);

  /// Create a copy of AAAccount
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? type = null,
    Object? maskedAccNumber = null,
    Object? version = null,
    Object? profile = null,
    Object? summary = null,
    Object? transactions = null,
  }) {
    return _then(
      _$AAAccountImpl(
        type:
            null == type
                ? _value.type
                : type // ignore: cast_nullable_to_non_nullable
                    as String,
        maskedAccNumber:
            null == maskedAccNumber
                ? _value.maskedAccNumber
                : maskedAccNumber // ignore: cast_nullable_to_non_nullable
                    as String,
        version:
            null == version
                ? _value.version
                : version // ignore: cast_nullable_to_non_nullable
                    as String,
        profile:
            null == profile
                ? _value.profile
                : profile // ignore: cast_nullable_to_non_nullable
                    as AAProfile,
        summary:
            null == summary
                ? _value.summary
                : summary // ignore: cast_nullable_to_non_nullable
                    as AASummary,
        transactions:
            null == transactions
                ? _value.transactions
                : transactions // ignore: cast_nullable_to_non_nullable
                    as AATransactions,
      ),
    );
  }
}

/// @nodoc
@JsonSerializable()
class _$AAAccountImpl implements _AAAccount {
  const _$AAAccountImpl({
    required this.type,
    required this.maskedAccNumber,
    required this.version,
    @JsonKey(name: 'Profile') required this.profile,
    @JsonKey(name: 'Summary') required this.summary,
    @JsonKey(name: 'Transactions') required this.transactions,
  });

  factory _$AAAccountImpl.fromJson(Map<String, dynamic> json) =>
      _$$AAAccountImplFromJson(json);

  @override
  final String type;
  @override
  final String maskedAccNumber;
  @override
  final String version;
  @override
  @JsonKey(name: 'Profile')
  final AAProfile profile;
  @override
  @JsonKey(name: 'Summary')
  final AASummary summary;
  @override
  @JsonKey(name: 'Transactions')
  final AATransactions transactions;

  @override
  String toString() {
    return 'AAAccount(type: $type, maskedAccNumber: $maskedAccNumber, version: $version, profile: $profile, summary: $summary, transactions: $transactions)';
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$AAAccountImpl &&
            (identical(other.type, type) || other.type == type) &&
            (identical(other.maskedAccNumber, maskedAccNumber) ||
                other.maskedAccNumber == maskedAccNumber) &&
            (identical(other.version, version) || other.version == version) &&
            (identical(other.profile, profile) || other.profile == profile) &&
            (identical(other.summary, summary) || other.summary == summary) &&
            (identical(other.transactions, transactions) ||
                other.transactions == transactions));
  }

  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  int get hashCode => Object.hash(
    runtimeType,
    type,
    maskedAccNumber,
    version,
    profile,
    summary,
    transactions,
  );

  /// Create a copy of AAAccount
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  @pragma('vm:prefer-inline')
  _$$AAAccountImplCopyWith<_$AAAccountImpl> get copyWith =>
      __$$AAAccountImplCopyWithImpl<_$AAAccountImpl>(this, _$identity);

  @override
  Map<String, dynamic> toJson() {
    return _$$AAAccountImplToJson(this);
  }
}

abstract class _AAAccount implements AAAccount {
  const factory _AAAccount({
    required final String type,
    required final String maskedAccNumber,
    required final String version,
    @JsonKey(name: 'Profile') required final AAProfile profile,
    @JsonKey(name: 'Summary') required final AASummary summary,
    @JsonKey(name: 'Transactions') required final AATransactions transactions,
  }) = _$AAAccountImpl;

  factory _AAAccount.fromJson(Map<String, dynamic> json) =
      _$AAAccountImpl.fromJson;

  @override
  String get type;
  @override
  String get maskedAccNumber;
  @override
  String get version;
  @override
  @JsonKey(name: 'Profile')
  AAProfile get profile;
  @override
  @JsonKey(name: 'Summary')
  AASummary get summary;
  @override
  @JsonKey(name: 'Transactions')
  AATransactions get transactions;

  /// Create a copy of AAAccount
  /// with the given fields replaced by the non-null parameter values.
  @override
  @JsonKey(includeFromJson: false, includeToJson: false)
  _$$AAAccountImplCopyWith<_$AAAccountImpl> get copyWith =>
      throw _privateConstructorUsedError;
}

AAProfile _$AAProfileFromJson(Map<String, dynamic> json) {
  return _AAProfile.fromJson(json);
}

/// @nodoc
mixin _$AAProfile {
  @JsonKey(name: 'Holders')
  AAHolders get holders => throw _privateConstructorUsedError;

  /// Serializes this AAProfile to a JSON map.
  Map<String, dynamic> toJson() => throw _privateConstructorUsedError;

  /// Create a copy of AAProfile
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  $AAProfileCopyWith<AAProfile> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $AAProfileCopyWith<$Res> {
  factory $AAProfileCopyWith(AAProfile value, $Res Function(AAProfile) then) =
      _$AAProfileCopyWithImpl<$Res, AAProfile>;
  @useResult
  $Res call({@JsonKey(name: 'Holders') AAHolders holders});

  $AAHoldersCopyWith<$Res> get holders;
}

/// @nodoc
class _$AAProfileCopyWithImpl<$Res, $Val extends AAProfile>
    implements $AAProfileCopyWith<$Res> {
  _$AAProfileCopyWithImpl(this._value, this._then);

  // ignore: unused_field
  final $Val _value;
  // ignore: unused_field
  final $Res Function($Val) _then;

  /// Create a copy of AAProfile
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({Object? holders = null}) {
    return _then(
      _value.copyWith(
            holders:
                null == holders
                    ? _value.holders
                    : holders // ignore: cast_nullable_to_non_nullable
                        as AAHolders,
          )
          as $Val,
    );
  }

  /// Create a copy of AAProfile
  /// with the given fields replaced by the non-null parameter values.
  @override
  @pragma('vm:prefer-inline')
  $AAHoldersCopyWith<$Res> get holders {
    return $AAHoldersCopyWith<$Res>(_value.holders, (value) {
      return _then(_value.copyWith(holders: value) as $Val);
    });
  }
}

/// @nodoc
abstract class _$$AAProfileImplCopyWith<$Res>
    implements $AAProfileCopyWith<$Res> {
  factory _$$AAProfileImplCopyWith(
    _$AAProfileImpl value,
    $Res Function(_$AAProfileImpl) then,
  ) = __$$AAProfileImplCopyWithImpl<$Res>;
  @override
  @useResult
  $Res call({@JsonKey(name: 'Holders') AAHolders holders});

  @override
  $AAHoldersCopyWith<$Res> get holders;
}

/// @nodoc
class __$$AAProfileImplCopyWithImpl<$Res>
    extends _$AAProfileCopyWithImpl<$Res, _$AAProfileImpl>
    implements _$$AAProfileImplCopyWith<$Res> {
  __$$AAProfileImplCopyWithImpl(
    _$AAProfileImpl _value,
    $Res Function(_$AAProfileImpl) _then,
  ) : super(_value, _then);

  /// Create a copy of AAProfile
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({Object? holders = null}) {
    return _then(
      _$AAProfileImpl(
        holders:
            null == holders
                ? _value.holders
                : holders // ignore: cast_nullable_to_non_nullable
                    as AAHolders,
      ),
    );
  }
}

/// @nodoc
@JsonSerializable()
class _$AAProfileImpl implements _AAProfile {
  const _$AAProfileImpl({@JsonKey(name: 'Holders') required this.holders});

  factory _$AAProfileImpl.fromJson(Map<String, dynamic> json) =>
      _$$AAProfileImplFromJson(json);

  @override
  @JsonKey(name: 'Holders')
  final AAHolders holders;

  @override
  String toString() {
    return 'AAProfile(holders: $holders)';
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$AAProfileImpl &&
            (identical(other.holders, holders) || other.holders == holders));
  }

  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  int get hashCode => Object.hash(runtimeType, holders);

  /// Create a copy of AAProfile
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  @pragma('vm:prefer-inline')
  _$$AAProfileImplCopyWith<_$AAProfileImpl> get copyWith =>
      __$$AAProfileImplCopyWithImpl<_$AAProfileImpl>(this, _$identity);

  @override
  Map<String, dynamic> toJson() {
    return _$$AAProfileImplToJson(this);
  }
}

abstract class _AAProfile implements AAProfile {
  const factory _AAProfile({
    @JsonKey(name: 'Holders') required final AAHolders holders,
  }) = _$AAProfileImpl;

  factory _AAProfile.fromJson(Map<String, dynamic> json) =
      _$AAProfileImpl.fromJson;

  @override
  @JsonKey(name: 'Holders')
  AAHolders get holders;

  /// Create a copy of AAProfile
  /// with the given fields replaced by the non-null parameter values.
  @override
  @JsonKey(includeFromJson: false, includeToJson: false)
  _$$AAProfileImplCopyWith<_$AAProfileImpl> get copyWith =>
      throw _privateConstructorUsedError;
}

AAHolders _$AAHoldersFromJson(Map<String, dynamic> json) {
  return _AAHolders.fromJson(json);
}

/// @nodoc
mixin _$AAHolders {
  String get type => throw _privateConstructorUsedError;
  @JsonKey(name: 'Holder')
  AAHolder get holder => throw _privateConstructorUsedError;

  /// Serializes this AAHolders to a JSON map.
  Map<String, dynamic> toJson() => throw _privateConstructorUsedError;

  /// Create a copy of AAHolders
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  $AAHoldersCopyWith<AAHolders> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $AAHoldersCopyWith<$Res> {
  factory $AAHoldersCopyWith(AAHolders value, $Res Function(AAHolders) then) =
      _$AAHoldersCopyWithImpl<$Res, AAHolders>;
  @useResult
  $Res call({String type, @JsonKey(name: 'Holder') AAHolder holder});

  $AAHolderCopyWith<$Res> get holder;
}

/// @nodoc
class _$AAHoldersCopyWithImpl<$Res, $Val extends AAHolders>
    implements $AAHoldersCopyWith<$Res> {
  _$AAHoldersCopyWithImpl(this._value, this._then);

  // ignore: unused_field
  final $Val _value;
  // ignore: unused_field
  final $Res Function($Val) _then;

  /// Create a copy of AAHolders
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({Object? type = null, Object? holder = null}) {
    return _then(
      _value.copyWith(
            type:
                null == type
                    ? _value.type
                    : type // ignore: cast_nullable_to_non_nullable
                        as String,
            holder:
                null == holder
                    ? _value.holder
                    : holder // ignore: cast_nullable_to_non_nullable
                        as AAHolder,
          )
          as $Val,
    );
  }

  /// Create a copy of AAHolders
  /// with the given fields replaced by the non-null parameter values.
  @override
  @pragma('vm:prefer-inline')
  $AAHolderCopyWith<$Res> get holder {
    return $AAHolderCopyWith<$Res>(_value.holder, (value) {
      return _then(_value.copyWith(holder: value) as $Val);
    });
  }
}

/// @nodoc
abstract class _$$AAHoldersImplCopyWith<$Res>
    implements $AAHoldersCopyWith<$Res> {
  factory _$$AAHoldersImplCopyWith(
    _$AAHoldersImpl value,
    $Res Function(_$AAHoldersImpl) then,
  ) = __$$AAHoldersImplCopyWithImpl<$Res>;
  @override
  @useResult
  $Res call({String type, @JsonKey(name: 'Holder') AAHolder holder});

  @override
  $AAHolderCopyWith<$Res> get holder;
}

/// @nodoc
class __$$AAHoldersImplCopyWithImpl<$Res>
    extends _$AAHoldersCopyWithImpl<$Res, _$AAHoldersImpl>
    implements _$$AAHoldersImplCopyWith<$Res> {
  __$$AAHoldersImplCopyWithImpl(
    _$AAHoldersImpl _value,
    $Res Function(_$AAHoldersImpl) _then,
  ) : super(_value, _then);

  /// Create a copy of AAHolders
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({Object? type = null, Object? holder = null}) {
    return _then(
      _$AAHoldersImpl(
        type:
            null == type
                ? _value.type
                : type // ignore: cast_nullable_to_non_nullable
                    as String,
        holder:
            null == holder
                ? _value.holder
                : holder // ignore: cast_nullable_to_non_nullable
                    as AAHolder,
      ),
    );
  }
}

/// @nodoc
@JsonSerializable()
class _$AAHoldersImpl implements _AAHolders {
  const _$AAHoldersImpl({
    required this.type,
    @JsonKey(name: 'Holder') required this.holder,
  });

  factory _$AAHoldersImpl.fromJson(Map<String, dynamic> json) =>
      _$$AAHoldersImplFromJson(json);

  @override
  final String type;
  @override
  @JsonKey(name: 'Holder')
  final AAHolder holder;

  @override
  String toString() {
    return 'AAHolders(type: $type, holder: $holder)';
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$AAHoldersImpl &&
            (identical(other.type, type) || other.type == type) &&
            (identical(other.holder, holder) || other.holder == holder));
  }

  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  int get hashCode => Object.hash(runtimeType, type, holder);

  /// Create a copy of AAHolders
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  @pragma('vm:prefer-inline')
  _$$AAHoldersImplCopyWith<_$AAHoldersImpl> get copyWith =>
      __$$AAHoldersImplCopyWithImpl<_$AAHoldersImpl>(this, _$identity);

  @override
  Map<String, dynamic> toJson() {
    return _$$AAHoldersImplToJson(this);
  }
}

abstract class _AAHolders implements AAHolders {
  const factory _AAHolders({
    required final String type,
    @JsonKey(name: 'Holder') required final AAHolder holder,
  }) = _$AAHoldersImpl;

  factory _AAHolders.fromJson(Map<String, dynamic> json) =
      _$AAHoldersImpl.fromJson;

  @override
  String get type;
  @override
  @JsonKey(name: 'Holder')
  AAHolder get holder;

  /// Create a copy of AAHolders
  /// with the given fields replaced by the non-null parameter values.
  @override
  @JsonKey(includeFromJson: false, includeToJson: false)
  _$$AAHoldersImplCopyWith<_$AAHoldersImpl> get copyWith =>
      throw _privateConstructorUsedError;
}

AAHolder _$AAHolderFromJson(Map<String, dynamic> json) {
  return _AAHolder.fromJson(json);
}

/// @nodoc
mixin _$AAHolder {
  String get name => throw _privateConstructorUsedError;
  String get mobile => throw _privateConstructorUsedError;
  String get address => throw _privateConstructorUsedError;
  String get email => throw _privateConstructorUsedError;
  String get pan => throw _privateConstructorUsedError;

  /// Serializes this AAHolder to a JSON map.
  Map<String, dynamic> toJson() => throw _privateConstructorUsedError;

  /// Create a copy of AAHolder
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  $AAHolderCopyWith<AAHolder> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $AAHolderCopyWith<$Res> {
  factory $AAHolderCopyWith(AAHolder value, $Res Function(AAHolder) then) =
      _$AAHolderCopyWithImpl<$Res, AAHolder>;
  @useResult
  $Res call({
    String name,
    String mobile,
    String address,
    String email,
    String pan,
  });
}

/// @nodoc
class _$AAHolderCopyWithImpl<$Res, $Val extends AAHolder>
    implements $AAHolderCopyWith<$Res> {
  _$AAHolderCopyWithImpl(this._value, this._then);

  // ignore: unused_field
  final $Val _value;
  // ignore: unused_field
  final $Res Function($Val) _then;

  /// Create a copy of AAHolder
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? name = null,
    Object? mobile = null,
    Object? address = null,
    Object? email = null,
    Object? pan = null,
  }) {
    return _then(
      _value.copyWith(
            name:
                null == name
                    ? _value.name
                    : name // ignore: cast_nullable_to_non_nullable
                        as String,
            mobile:
                null == mobile
                    ? _value.mobile
                    : mobile // ignore: cast_nullable_to_non_nullable
                        as String,
            address:
                null == address
                    ? _value.address
                    : address // ignore: cast_nullable_to_non_nullable
                        as String,
            email:
                null == email
                    ? _value.email
                    : email // ignore: cast_nullable_to_non_nullable
                        as String,
            pan:
                null == pan
                    ? _value.pan
                    : pan // ignore: cast_nullable_to_non_nullable
                        as String,
          )
          as $Val,
    );
  }
}

/// @nodoc
abstract class _$$AAHolderImplCopyWith<$Res>
    implements $AAHolderCopyWith<$Res> {
  factory _$$AAHolderImplCopyWith(
    _$AAHolderImpl value,
    $Res Function(_$AAHolderImpl) then,
  ) = __$$AAHolderImplCopyWithImpl<$Res>;
  @override
  @useResult
  $Res call({
    String name,
    String mobile,
    String address,
    String email,
    String pan,
  });
}

/// @nodoc
class __$$AAHolderImplCopyWithImpl<$Res>
    extends _$AAHolderCopyWithImpl<$Res, _$AAHolderImpl>
    implements _$$AAHolderImplCopyWith<$Res> {
  __$$AAHolderImplCopyWithImpl(
    _$AAHolderImpl _value,
    $Res Function(_$AAHolderImpl) _then,
  ) : super(_value, _then);

  /// Create a copy of AAHolder
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? name = null,
    Object? mobile = null,
    Object? address = null,
    Object? email = null,
    Object? pan = null,
  }) {
    return _then(
      _$AAHolderImpl(
        name:
            null == name
                ? _value.name
                : name // ignore: cast_nullable_to_non_nullable
                    as String,
        mobile:
            null == mobile
                ? _value.mobile
                : mobile // ignore: cast_nullable_to_non_nullable
                    as String,
        address:
            null == address
                ? _value.address
                : address // ignore: cast_nullable_to_non_nullable
                    as String,
        email:
            null == email
                ? _value.email
                : email // ignore: cast_nullable_to_non_nullable
                    as String,
        pan:
            null == pan
                ? _value.pan
                : pan // ignore: cast_nullable_to_non_nullable
                    as String,
      ),
    );
  }
}

/// @nodoc
@JsonSerializable()
class _$AAHolderImpl implements _AAHolder {
  const _$AAHolderImpl({
    required this.name,
    required this.mobile,
    required this.address,
    required this.email,
    required this.pan,
  });

  factory _$AAHolderImpl.fromJson(Map<String, dynamic> json) =>
      _$$AAHolderImplFromJson(json);

  @override
  final String name;
  @override
  final String mobile;
  @override
  final String address;
  @override
  final String email;
  @override
  final String pan;

  @override
  String toString() {
    return 'AAHolder(name: $name, mobile: $mobile, address: $address, email: $email, pan: $pan)';
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$AAHolderImpl &&
            (identical(other.name, name) || other.name == name) &&
            (identical(other.mobile, mobile) || other.mobile == mobile) &&
            (identical(other.address, address) || other.address == address) &&
            (identical(other.email, email) || other.email == email) &&
            (identical(other.pan, pan) || other.pan == pan));
  }

  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  int get hashCode =>
      Object.hash(runtimeType, name, mobile, address, email, pan);

  /// Create a copy of AAHolder
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  @pragma('vm:prefer-inline')
  _$$AAHolderImplCopyWith<_$AAHolderImpl> get copyWith =>
      __$$AAHolderImplCopyWithImpl<_$AAHolderImpl>(this, _$identity);

  @override
  Map<String, dynamic> toJson() {
    return _$$AAHolderImplToJson(this);
  }
}

abstract class _AAHolder implements AAHolder {
  const factory _AAHolder({
    required final String name,
    required final String mobile,
    required final String address,
    required final String email,
    required final String pan,
  }) = _$AAHolderImpl;

  factory _AAHolder.fromJson(Map<String, dynamic> json) =
      _$AAHolderImpl.fromJson;

  @override
  String get name;
  @override
  String get mobile;
  @override
  String get address;
  @override
  String get email;
  @override
  String get pan;

  /// Create a copy of AAHolder
  /// with the given fields replaced by the non-null parameter values.
  @override
  @JsonKey(includeFromJson: false, includeToJson: false)
  _$$AAHolderImplCopyWith<_$AAHolderImpl> get copyWith =>
      throw _privateConstructorUsedError;
}

AASummary _$AASummaryFromJson(Map<String, dynamic> json) {
  return _AASummary.fromJson(json);
}

/// @nodoc
mixin _$AASummary {
  String get currentBalance => throw _privateConstructorUsedError;
  String get currency => throw _privateConstructorUsedError;
  String get type => throw _privateConstructorUsedError;
  String get ifscCode => throw _privateConstructorUsedError;
  @JsonKey(name: 'Pending')
  AAPending? get pending => throw _privateConstructorUsedError;

  /// Serializes this AASummary to a JSON map.
  Map<String, dynamic> toJson() => throw _privateConstructorUsedError;

  /// Create a copy of AASummary
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  $AASummaryCopyWith<AASummary> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $AASummaryCopyWith<$Res> {
  factory $AASummaryCopyWith(AASummary value, $Res Function(AASummary) then) =
      _$AASummaryCopyWithImpl<$Res, AASummary>;
  @useResult
  $Res call({
    String currentBalance,
    String currency,
    String type,
    String ifscCode,
    @JsonKey(name: 'Pending') AAPending? pending,
  });

  $AAPendingCopyWith<$Res>? get pending;
}

/// @nodoc
class _$AASummaryCopyWithImpl<$Res, $Val extends AASummary>
    implements $AASummaryCopyWith<$Res> {
  _$AASummaryCopyWithImpl(this._value, this._then);

  // ignore: unused_field
  final $Val _value;
  // ignore: unused_field
  final $Res Function($Val) _then;

  /// Create a copy of AASummary
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? currentBalance = null,
    Object? currency = null,
    Object? type = null,
    Object? ifscCode = null,
    Object? pending = freezed,
  }) {
    return _then(
      _value.copyWith(
            currentBalance:
                null == currentBalance
                    ? _value.currentBalance
                    : currentBalance // ignore: cast_nullable_to_non_nullable
                        as String,
            currency:
                null == currency
                    ? _value.currency
                    : currency // ignore: cast_nullable_to_non_nullable
                        as String,
            type:
                null == type
                    ? _value.type
                    : type // ignore: cast_nullable_to_non_nullable
                        as String,
            ifscCode:
                null == ifscCode
                    ? _value.ifscCode
                    : ifscCode // ignore: cast_nullable_to_non_nullable
                        as String,
            pending:
                freezed == pending
                    ? _value.pending
                    : pending // ignore: cast_nullable_to_non_nullable
                        as AAPending?,
          )
          as $Val,
    );
  }

  /// Create a copy of AASummary
  /// with the given fields replaced by the non-null parameter values.
  @override
  @pragma('vm:prefer-inline')
  $AAPendingCopyWith<$Res>? get pending {
    if (_value.pending == null) {
      return null;
    }

    return $AAPendingCopyWith<$Res>(_value.pending!, (value) {
      return _then(_value.copyWith(pending: value) as $Val);
    });
  }
}

/// @nodoc
abstract class _$$AASummaryImplCopyWith<$Res>
    implements $AASummaryCopyWith<$Res> {
  factory _$$AASummaryImplCopyWith(
    _$AASummaryImpl value,
    $Res Function(_$AASummaryImpl) then,
  ) = __$$AASummaryImplCopyWithImpl<$Res>;
  @override
  @useResult
  $Res call({
    String currentBalance,
    String currency,
    String type,
    String ifscCode,
    @JsonKey(name: 'Pending') AAPending? pending,
  });

  @override
  $AAPendingCopyWith<$Res>? get pending;
}

/// @nodoc
class __$$AASummaryImplCopyWithImpl<$Res>
    extends _$AASummaryCopyWithImpl<$Res, _$AASummaryImpl>
    implements _$$AASummaryImplCopyWith<$Res> {
  __$$AASummaryImplCopyWithImpl(
    _$AASummaryImpl _value,
    $Res Function(_$AASummaryImpl) _then,
  ) : super(_value, _then);

  /// Create a copy of AASummary
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? currentBalance = null,
    Object? currency = null,
    Object? type = null,
    Object? ifscCode = null,
    Object? pending = freezed,
  }) {
    return _then(
      _$AASummaryImpl(
        currentBalance:
            null == currentBalance
                ? _value.currentBalance
                : currentBalance // ignore: cast_nullable_to_non_nullable
                    as String,
        currency:
            null == currency
                ? _value.currency
                : currency // ignore: cast_nullable_to_non_nullable
                    as String,
        type:
            null == type
                ? _value.type
                : type // ignore: cast_nullable_to_non_nullable
                    as String,
        ifscCode:
            null == ifscCode
                ? _value.ifscCode
                : ifscCode // ignore: cast_nullable_to_non_nullable
                    as String,
        pending:
            freezed == pending
                ? _value.pending
                : pending // ignore: cast_nullable_to_non_nullable
                    as AAPending?,
      ),
    );
  }
}

/// @nodoc
@JsonSerializable()
class _$AASummaryImpl implements _AASummary {
  const _$AASummaryImpl({
    required this.currentBalance,
    required this.currency,
    required this.type,
    required this.ifscCode,
    @JsonKey(name: 'Pending') required this.pending,
  });

  factory _$AASummaryImpl.fromJson(Map<String, dynamic> json) =>
      _$$AASummaryImplFromJson(json);

  @override
  final String currentBalance;
  @override
  final String currency;
  @override
  final String type;
  @override
  final String ifscCode;
  @override
  @JsonKey(name: 'Pending')
  final AAPending? pending;

  @override
  String toString() {
    return 'AASummary(currentBalance: $currentBalance, currency: $currency, type: $type, ifscCode: $ifscCode, pending: $pending)';
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$AASummaryImpl &&
            (identical(other.currentBalance, currentBalance) ||
                other.currentBalance == currentBalance) &&
            (identical(other.currency, currency) ||
                other.currency == currency) &&
            (identical(other.type, type) || other.type == type) &&
            (identical(other.ifscCode, ifscCode) ||
                other.ifscCode == ifscCode) &&
            (identical(other.pending, pending) || other.pending == pending));
  }

  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  int get hashCode => Object.hash(
    runtimeType,
    currentBalance,
    currency,
    type,
    ifscCode,
    pending,
  );

  /// Create a copy of AASummary
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  @pragma('vm:prefer-inline')
  _$$AASummaryImplCopyWith<_$AASummaryImpl> get copyWith =>
      __$$AASummaryImplCopyWithImpl<_$AASummaryImpl>(this, _$identity);

  @override
  Map<String, dynamic> toJson() {
    return _$$AASummaryImplToJson(this);
  }
}

abstract class _AASummary implements AASummary {
  const factory _AASummary({
    required final String currentBalance,
    required final String currency,
    required final String type,
    required final String ifscCode,
    @JsonKey(name: 'Pending') required final AAPending? pending,
  }) = _$AASummaryImpl;

  factory _AASummary.fromJson(Map<String, dynamic> json) =
      _$AASummaryImpl.fromJson;

  @override
  String get currentBalance;
  @override
  String get currency;
  @override
  String get type;
  @override
  String get ifscCode;
  @override
  @JsonKey(name: 'Pending')
  AAPending? get pending;

  /// Create a copy of AASummary
  /// with the given fields replaced by the non-null parameter values.
  @override
  @JsonKey(includeFromJson: false, includeToJson: false)
  _$$AASummaryImplCopyWith<_$AASummaryImpl> get copyWith =>
      throw _privateConstructorUsedError;
}

AAPending _$AAPendingFromJson(Map<String, dynamic> json) {
  return _AAPending.fromJson(json);
}

/// @nodoc
mixin _$AAPending {
  String get transactionType => throw _privateConstructorUsedError;
  String get amount => throw _privateConstructorUsedError;

  /// Serializes this AAPending to a JSON map.
  Map<String, dynamic> toJson() => throw _privateConstructorUsedError;

  /// Create a copy of AAPending
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  $AAPendingCopyWith<AAPending> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $AAPendingCopyWith<$Res> {
  factory $AAPendingCopyWith(AAPending value, $Res Function(AAPending) then) =
      _$AAPendingCopyWithImpl<$Res, AAPending>;
  @useResult
  $Res call({String transactionType, String amount});
}

/// @nodoc
class _$AAPendingCopyWithImpl<$Res, $Val extends AAPending>
    implements $AAPendingCopyWith<$Res> {
  _$AAPendingCopyWithImpl(this._value, this._then);

  // ignore: unused_field
  final $Val _value;
  // ignore: unused_field
  final $Res Function($Val) _then;

  /// Create a copy of AAPending
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({Object? transactionType = null, Object? amount = null}) {
    return _then(
      _value.copyWith(
            transactionType:
                null == transactionType
                    ? _value.transactionType
                    : transactionType // ignore: cast_nullable_to_non_nullable
                        as String,
            amount:
                null == amount
                    ? _value.amount
                    : amount // ignore: cast_nullable_to_non_nullable
                        as String,
          )
          as $Val,
    );
  }
}

/// @nodoc
abstract class _$$AAPendingImplCopyWith<$Res>
    implements $AAPendingCopyWith<$Res> {
  factory _$$AAPendingImplCopyWith(
    _$AAPendingImpl value,
    $Res Function(_$AAPendingImpl) then,
  ) = __$$AAPendingImplCopyWithImpl<$Res>;
  @override
  @useResult
  $Res call({String transactionType, String amount});
}

/// @nodoc
class __$$AAPendingImplCopyWithImpl<$Res>
    extends _$AAPendingCopyWithImpl<$Res, _$AAPendingImpl>
    implements _$$AAPendingImplCopyWith<$Res> {
  __$$AAPendingImplCopyWithImpl(
    _$AAPendingImpl _value,
    $Res Function(_$AAPendingImpl) _then,
  ) : super(_value, _then);

  /// Create a copy of AAPending
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({Object? transactionType = null, Object? amount = null}) {
    return _then(
      _$AAPendingImpl(
        transactionType:
            null == transactionType
                ? _value.transactionType
                : transactionType // ignore: cast_nullable_to_non_nullable
                    as String,
        amount:
            null == amount
                ? _value.amount
                : amount // ignore: cast_nullable_to_non_nullable
                    as String,
      ),
    );
  }
}

/// @nodoc
@JsonSerializable()
class _$AAPendingImpl implements _AAPending {
  const _$AAPendingImpl({required this.transactionType, required this.amount});

  factory _$AAPendingImpl.fromJson(Map<String, dynamic> json) =>
      _$$AAPendingImplFromJson(json);

  @override
  final String transactionType;
  @override
  final String amount;

  @override
  String toString() {
    return 'AAPending(transactionType: $transactionType, amount: $amount)';
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$AAPendingImpl &&
            (identical(other.transactionType, transactionType) ||
                other.transactionType == transactionType) &&
            (identical(other.amount, amount) || other.amount == amount));
  }

  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  int get hashCode => Object.hash(runtimeType, transactionType, amount);

  /// Create a copy of AAPending
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  @pragma('vm:prefer-inline')
  _$$AAPendingImplCopyWith<_$AAPendingImpl> get copyWith =>
      __$$AAPendingImplCopyWithImpl<_$AAPendingImpl>(this, _$identity);

  @override
  Map<String, dynamic> toJson() {
    return _$$AAPendingImplToJson(this);
  }
}

abstract class _AAPending implements AAPending {
  const factory _AAPending({
    required final String transactionType,
    required final String amount,
  }) = _$AAPendingImpl;

  factory _AAPending.fromJson(Map<String, dynamic> json) =
      _$AAPendingImpl.fromJson;

  @override
  String get transactionType;
  @override
  String get amount;

  /// Create a copy of AAPending
  /// with the given fields replaced by the non-null parameter values.
  @override
  @JsonKey(includeFromJson: false, includeToJson: false)
  _$$AAPendingImplCopyWith<_$AAPendingImpl> get copyWith =>
      throw _privateConstructorUsedError;
}

AATransactions _$AATransactionsFromJson(Map<String, dynamic> json) {
  return _AATransactions.fromJson(json);
}

/// @nodoc
mixin _$AATransactions {
  String get startDate => throw _privateConstructorUsedError;
  String get endDate => throw _privateConstructorUsedError;
  @JsonKey(name: 'Transaction')
  List<AATransaction> get transactionList => throw _privateConstructorUsedError;

  /// Serializes this AATransactions to a JSON map.
  Map<String, dynamic> toJson() => throw _privateConstructorUsedError;

  /// Create a copy of AATransactions
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  $AATransactionsCopyWith<AATransactions> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $AATransactionsCopyWith<$Res> {
  factory $AATransactionsCopyWith(
    AATransactions value,
    $Res Function(AATransactions) then,
  ) = _$AATransactionsCopyWithImpl<$Res, AATransactions>;
  @useResult
  $Res call({
    String startDate,
    String endDate,
    @JsonKey(name: 'Transaction') List<AATransaction> transactionList,
  });
}

/// @nodoc
class _$AATransactionsCopyWithImpl<$Res, $Val extends AATransactions>
    implements $AATransactionsCopyWith<$Res> {
  _$AATransactionsCopyWithImpl(this._value, this._then);

  // ignore: unused_field
  final $Val _value;
  // ignore: unused_field
  final $Res Function($Val) _then;

  /// Create a copy of AATransactions
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? startDate = null,
    Object? endDate = null,
    Object? transactionList = null,
  }) {
    return _then(
      _value.copyWith(
            startDate:
                null == startDate
                    ? _value.startDate
                    : startDate // ignore: cast_nullable_to_non_nullable
                        as String,
            endDate:
                null == endDate
                    ? _value.endDate
                    : endDate // ignore: cast_nullable_to_non_nullable
                        as String,
            transactionList:
                null == transactionList
                    ? _value.transactionList
                    : transactionList // ignore: cast_nullable_to_non_nullable
                        as List<AATransaction>,
          )
          as $Val,
    );
  }
}

/// @nodoc
abstract class _$$AATransactionsImplCopyWith<$Res>
    implements $AATransactionsCopyWith<$Res> {
  factory _$$AATransactionsImplCopyWith(
    _$AATransactionsImpl value,
    $Res Function(_$AATransactionsImpl) then,
  ) = __$$AATransactionsImplCopyWithImpl<$Res>;
  @override
  @useResult
  $Res call({
    String startDate,
    String endDate,
    @JsonKey(name: 'Transaction') List<AATransaction> transactionList,
  });
}

/// @nodoc
class __$$AATransactionsImplCopyWithImpl<$Res>
    extends _$AATransactionsCopyWithImpl<$Res, _$AATransactionsImpl>
    implements _$$AATransactionsImplCopyWith<$Res> {
  __$$AATransactionsImplCopyWithImpl(
    _$AATransactionsImpl _value,
    $Res Function(_$AATransactionsImpl) _then,
  ) : super(_value, _then);

  /// Create a copy of AATransactions
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? startDate = null,
    Object? endDate = null,
    Object? transactionList = null,
  }) {
    return _then(
      _$AATransactionsImpl(
        startDate:
            null == startDate
                ? _value.startDate
                : startDate // ignore: cast_nullable_to_non_nullable
                    as String,
        endDate:
            null == endDate
                ? _value.endDate
                : endDate // ignore: cast_nullable_to_non_nullable
                    as String,
        transactionList:
            null == transactionList
                ? _value._transactionList
                : transactionList // ignore: cast_nullable_to_non_nullable
                    as List<AATransaction>,
      ),
    );
  }
}

/// @nodoc
@JsonSerializable()
class _$AATransactionsImpl implements _AATransactions {
  const _$AATransactionsImpl({
    required this.startDate,
    required this.endDate,
    @JsonKey(name: 'Transaction')
    required final List<AATransaction> transactionList,
  }) : _transactionList = transactionList;

  factory _$AATransactionsImpl.fromJson(Map<String, dynamic> json) =>
      _$$AATransactionsImplFromJson(json);

  @override
  final String startDate;
  @override
  final String endDate;
  final List<AATransaction> _transactionList;
  @override
  @JsonKey(name: 'Transaction')
  List<AATransaction> get transactionList {
    if (_transactionList is EqualUnmodifiableListView) return _transactionList;
    // ignore: implicit_dynamic_type
    return EqualUnmodifiableListView(_transactionList);
  }

  @override
  String toString() {
    return 'AATransactions(startDate: $startDate, endDate: $endDate, transactionList: $transactionList)';
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$AATransactionsImpl &&
            (identical(other.startDate, startDate) ||
                other.startDate == startDate) &&
            (identical(other.endDate, endDate) || other.endDate == endDate) &&
            const DeepCollectionEquality().equals(
              other._transactionList,
              _transactionList,
            ));
  }

  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  int get hashCode => Object.hash(
    runtimeType,
    startDate,
    endDate,
    const DeepCollectionEquality().hash(_transactionList),
  );

  /// Create a copy of AATransactions
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  @pragma('vm:prefer-inline')
  _$$AATransactionsImplCopyWith<_$AATransactionsImpl> get copyWith =>
      __$$AATransactionsImplCopyWithImpl<_$AATransactionsImpl>(
        this,
        _$identity,
      );

  @override
  Map<String, dynamic> toJson() {
    return _$$AATransactionsImplToJson(this);
  }
}

abstract class _AATransactions implements AATransactions {
  const factory _AATransactions({
    required final String startDate,
    required final String endDate,
    @JsonKey(name: 'Transaction')
    required final List<AATransaction> transactionList,
  }) = _$AATransactionsImpl;

  factory _AATransactions.fromJson(Map<String, dynamic> json) =
      _$AATransactionsImpl.fromJson;

  @override
  String get startDate;
  @override
  String get endDate;
  @override
  @JsonKey(name: 'Transaction')
  List<AATransaction> get transactionList;

  /// Create a copy of AATransactions
  /// with the given fields replaced by the non-null parameter values.
  @override
  @JsonKey(includeFromJson: false, includeToJson: false)
  _$$AATransactionsImplCopyWith<_$AATransactionsImpl> get copyWith =>
      throw _privateConstructorUsedError;
}

AATransaction _$AATransactionFromJson(Map<String, dynamic> json) {
  return _AATransaction.fromJson(json);
}

/// @nodoc
mixin _$AATransaction {
  String get type => throw _privateConstructorUsedError;
  String get mode => throw _privateConstructorUsedError;
  String get amount => throw _privateConstructorUsedError;
  String get currentBalance => throw _privateConstructorUsedError;
  String get transactionTimestamp => throw _privateConstructorUsedError;
  String get narration => throw _privateConstructorUsedError;
  String get txnId => throw _privateConstructorUsedError;

  /// Serializes this AATransaction to a JSON map.
  Map<String, dynamic> toJson() => throw _privateConstructorUsedError;

  /// Create a copy of AATransaction
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  $AATransactionCopyWith<AATransaction> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $AATransactionCopyWith<$Res> {
  factory $AATransactionCopyWith(
    AATransaction value,
    $Res Function(AATransaction) then,
  ) = _$AATransactionCopyWithImpl<$Res, AATransaction>;
  @useResult
  $Res call({
    String type,
    String mode,
    String amount,
    String currentBalance,
    String transactionTimestamp,
    String narration,
    String txnId,
  });
}

/// @nodoc
class _$AATransactionCopyWithImpl<$Res, $Val extends AATransaction>
    implements $AATransactionCopyWith<$Res> {
  _$AATransactionCopyWithImpl(this._value, this._then);

  // ignore: unused_field
  final $Val _value;
  // ignore: unused_field
  final $Res Function($Val) _then;

  /// Create a copy of AATransaction
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? type = null,
    Object? mode = null,
    Object? amount = null,
    Object? currentBalance = null,
    Object? transactionTimestamp = null,
    Object? narration = null,
    Object? txnId = null,
  }) {
    return _then(
      _value.copyWith(
            type:
                null == type
                    ? _value.type
                    : type // ignore: cast_nullable_to_non_nullable
                        as String,
            mode:
                null == mode
                    ? _value.mode
                    : mode // ignore: cast_nullable_to_non_nullable
                        as String,
            amount:
                null == amount
                    ? _value.amount
                    : amount // ignore: cast_nullable_to_non_nullable
                        as String,
            currentBalance:
                null == currentBalance
                    ? _value.currentBalance
                    : currentBalance // ignore: cast_nullable_to_non_nullable
                        as String,
            transactionTimestamp:
                null == transactionTimestamp
                    ? _value.transactionTimestamp
                    : transactionTimestamp // ignore: cast_nullable_to_non_nullable
                        as String,
            narration:
                null == narration
                    ? _value.narration
                    : narration // ignore: cast_nullable_to_non_nullable
                        as String,
            txnId:
                null == txnId
                    ? _value.txnId
                    : txnId // ignore: cast_nullable_to_non_nullable
                        as String,
          )
          as $Val,
    );
  }
}

/// @nodoc
abstract class _$$AATransactionImplCopyWith<$Res>
    implements $AATransactionCopyWith<$Res> {
  factory _$$AATransactionImplCopyWith(
    _$AATransactionImpl value,
    $Res Function(_$AATransactionImpl) then,
  ) = __$$AATransactionImplCopyWithImpl<$Res>;
  @override
  @useResult
  $Res call({
    String type,
    String mode,
    String amount,
    String currentBalance,
    String transactionTimestamp,
    String narration,
    String txnId,
  });
}

/// @nodoc
class __$$AATransactionImplCopyWithImpl<$Res>
    extends _$AATransactionCopyWithImpl<$Res, _$AATransactionImpl>
    implements _$$AATransactionImplCopyWith<$Res> {
  __$$AATransactionImplCopyWithImpl(
    _$AATransactionImpl _value,
    $Res Function(_$AATransactionImpl) _then,
  ) : super(_value, _then);

  /// Create a copy of AATransaction
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? type = null,
    Object? mode = null,
    Object? amount = null,
    Object? currentBalance = null,
    Object? transactionTimestamp = null,
    Object? narration = null,
    Object? txnId = null,
  }) {
    return _then(
      _$AATransactionImpl(
        type:
            null == type
                ? _value.type
                : type // ignore: cast_nullable_to_non_nullable
                    as String,
        mode:
            null == mode
                ? _value.mode
                : mode // ignore: cast_nullable_to_non_nullable
                    as String,
        amount:
            null == amount
                ? _value.amount
                : amount // ignore: cast_nullable_to_non_nullable
                    as String,
        currentBalance:
            null == currentBalance
                ? _value.currentBalance
                : currentBalance // ignore: cast_nullable_to_non_nullable
                    as String,
        transactionTimestamp:
            null == transactionTimestamp
                ? _value.transactionTimestamp
                : transactionTimestamp // ignore: cast_nullable_to_non_nullable
                    as String,
        narration:
            null == narration
                ? _value.narration
                : narration // ignore: cast_nullable_to_non_nullable
                    as String,
        txnId:
            null == txnId
                ? _value.txnId
                : txnId // ignore: cast_nullable_to_non_nullable
                    as String,
      ),
    );
  }
}

/// @nodoc
@JsonSerializable()
class _$AATransactionImpl implements _AATransaction {
  const _$AATransactionImpl({
    required this.type,
    required this.mode,
    required this.amount,
    required this.currentBalance,
    required this.transactionTimestamp,
    required this.narration,
    required this.txnId,
  });

  factory _$AATransactionImpl.fromJson(Map<String, dynamic> json) =>
      _$$AATransactionImplFromJson(json);

  @override
  final String type;
  @override
  final String mode;
  @override
  final String amount;
  @override
  final String currentBalance;
  @override
  final String transactionTimestamp;
  @override
  final String narration;
  @override
  final String txnId;

  @override
  String toString() {
    return 'AATransaction(type: $type, mode: $mode, amount: $amount, currentBalance: $currentBalance, transactionTimestamp: $transactionTimestamp, narration: $narration, txnId: $txnId)';
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$AATransactionImpl &&
            (identical(other.type, type) || other.type == type) &&
            (identical(other.mode, mode) || other.mode == mode) &&
            (identical(other.amount, amount) || other.amount == amount) &&
            (identical(other.currentBalance, currentBalance) ||
                other.currentBalance == currentBalance) &&
            (identical(other.transactionTimestamp, transactionTimestamp) ||
                other.transactionTimestamp == transactionTimestamp) &&
            (identical(other.narration, narration) ||
                other.narration == narration) &&
            (identical(other.txnId, txnId) || other.txnId == txnId));
  }

  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  int get hashCode => Object.hash(
    runtimeType,
    type,
    mode,
    amount,
    currentBalance,
    transactionTimestamp,
    narration,
    txnId,
  );

  /// Create a copy of AATransaction
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  @pragma('vm:prefer-inline')
  _$$AATransactionImplCopyWith<_$AATransactionImpl> get copyWith =>
      __$$AATransactionImplCopyWithImpl<_$AATransactionImpl>(this, _$identity);

  @override
  Map<String, dynamic> toJson() {
    return _$$AATransactionImplToJson(this);
  }
}

abstract class _AATransaction implements AATransaction {
  const factory _AATransaction({
    required final String type,
    required final String mode,
    required final String amount,
    required final String currentBalance,
    required final String transactionTimestamp,
    required final String narration,
    required final String txnId,
  }) = _$AATransactionImpl;

  factory _AATransaction.fromJson(Map<String, dynamic> json) =
      _$AATransactionImpl.fromJson;

  @override
  String get type;
  @override
  String get mode;
  @override
  String get amount;
  @override
  String get currentBalance;
  @override
  String get transactionTimestamp;
  @override
  String get narration;
  @override
  String get txnId;

  /// Create a copy of AATransaction
  /// with the given fields replaced by the non-null parameter values.
  @override
  @JsonKey(includeFromJson: false, includeToJson: false)
  _$$AATransactionImplCopyWith<_$AATransactionImpl> get copyWith =>
      throw _privateConstructorUsedError;
}
