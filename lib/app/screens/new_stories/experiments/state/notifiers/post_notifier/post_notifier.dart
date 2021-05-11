import 'package:hooks_riverpod/hooks_riverpod.dart';

import '../../../model/post_model.dart';
import '../../../source/repository/post_repository.dart';
import 'state/post_state.dart';
import 'union/post_union.dart';

class PostNotifier extends StateNotifier<PostState> {
  PostNotifier()
      : super(
          const PostState(
            posts: [],
            union: Success(),
          ),
        );

  Future<void> initialize() async {
    final result = await PostRepository.post();

    state = PostState(
      posts: [result],
      union: const Success(),
    );
  }

  Future<void> addPost() async {
    final posts = List<PostModel>.from(state.posts);

    state = state.copyWith(union: const Loading());

    try {
      final result = await PostRepository.post();

      posts.add(result);

      if (posts.length > 5) {
        state = state.copyWith(union: const NothingToLoad());
      } else {
        state = PostState(
          posts: posts,
          union: const Success(),
        );
      }
    } catch (e, st) {
      state = state.copyWith(union: Error(e, st));
    }
  }
}
