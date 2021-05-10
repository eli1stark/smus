import 'package:hooks_riverpod/hooks_riverpod.dart';

import '../../model/post_model.dart';
import '../../model/posts_state_model.dart';
import '../../source/repository/post_repository.dart';

class PostNotifier extends StateNotifier<PostsStateModel> {
  PostNotifier()
      : super(
          const PostsStateModel(
            posts: [],
            fetchStatus: PostsFetchStatus.success(),
          ),
        );

  Future<void> initialize() async {
    final result = await PostRepository.post();

    state = PostsStateModel(
      posts: [result],
      fetchStatus: const PostsFetchStatus.success(),
    );
  }

  Future<void> addPost() async {
    final posts = List<PostModel>.from(state.posts);

    state = state.copyWith(
      fetchStatus: const PostsFetchStatus.loading(),
    );

    try {
      final result = await PostRepository.post();

      posts.add(result);

      state = PostsStateModel(
        posts: posts,
        fetchStatus: const PostsFetchStatus.success(),
      );
    } catch (e, st) {
      state = state.copyWith(
        fetchStatus: PostsFetchStatus.error(e, st),
      );
    }
  }
}
