import 'package:hooks_riverpod/hooks_riverpod.dart';

import '../../model/post_model.dart';
import '../../model/posts_state_model.dart';
import '../../source/repository/post_repository.dart';

class PostNotifier extends StateNotifier<PostsStateModel> {
  PostNotifier()
      : super(
          const PostsStateModel(
            posts: [],
            fetchStatus: Success(),
          ),
        );

  Future<void> initialize() async {
    final result = await PostRepository.post();

    state = PostsStateModel(
      posts: [result],
      fetchStatus: const Success(),
    );
  }

  Future<void> addPost() async {
    final posts = List<PostModel>.from(state.posts);

    state = state.copyWith(
      fetchStatus: const Loading(),
    );

    try {
      final result = await PostRepository.post();

      posts.add(result);

      if (posts.length > 5) {
        state = state.copyWith(
          fetchStatus: const NothingToLoad(),
        );
      } else {
        state = PostsStateModel(
          posts: posts,
          fetchStatus: const Success(),
        );
      }
    } catch (e, st) {
      state = state.copyWith(
        fetchStatus: Error(e, st),
      );
    }
  }
}
