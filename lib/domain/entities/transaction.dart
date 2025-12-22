import 'package:freezed_annotation/freezed_annotation.dart';
import 'category.dart';

part 'transaction.freezed.dart';

@freezed
class Transaction with _$Transaction {
  const factory Transaction({
    required String id,
    required double amount,
    required Category category,
    required DateTime date,
    required String note,
    @Default([]) List<String> attachments, // Paths to local files
    @Default(false) bool isSynced,
    @Default(false) bool editedLocally,
    DateTime? lastModified,
  }) = _Transaction;
}
