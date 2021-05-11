import 'package:freezed_annotation/freezed_annotation.dart';

part 'post_union.freezed.dart';

@freezed
class PostUnion with _$PostUnion {
  const factory PostUnion.success() = Success;
  const factory PostUnion.loading() = Loading;
  const factory PostUnion.error(
    Object error, [
    StackTrace? stackTrace,
  ]) = Error;
  const factory PostUnion.nothingToLoad() = NothingToLoad;
}
