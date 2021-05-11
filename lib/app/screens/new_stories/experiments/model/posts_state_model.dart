import 'package:freezed_annotation/freezed_annotation.dart';

import 'post_model.dart';

part 'posts_state_model.freezed.dart';

@freezed
class PostsStateModel with _$PostsStateModel {
  const factory PostsStateModel({
    required List<PostModel> posts,
    required PostsFetchStatus fetchStatus,
  }) = _PostsStateModel;
}

@freezed
class PostsFetchStatus with _$PostsFetchStatus {
  const factory PostsFetchStatus.success() = Success;
  const factory PostsFetchStatus.loading() = Loading;
  const factory PostsFetchStatus.error(
    Object error, [
    StackTrace? stackTrace,
  ]) = Error;
  const factory PostsFetchStatus.nothingToLoad() = NothingToLoad;
}
