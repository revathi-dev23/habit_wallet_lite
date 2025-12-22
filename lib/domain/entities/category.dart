import 'package:freezed_annotation/freezed_annotation.dart';

part 'category.freezed.dart';

@freezed
class Category with _$Category {
  const factory Category({
    required String id,
    required String name,
    required String icon, // e.g., material icon name or asset path
    @Default(false) bool isCustom,
  }) = _Category;
}
