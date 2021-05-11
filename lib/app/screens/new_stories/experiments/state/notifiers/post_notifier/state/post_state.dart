import 'package:freezed_annotation/freezed_annotation.dart';

import '../../../../model/post_model.dart';
import '../union/post_union.dart';

part 'post_state.freezed.dart';

@freezed
class PostState with _$PostState {
  const factory PostState({
    required List<PostModel> posts,
    required PostUnion union,
  }) = _PostState;
}
