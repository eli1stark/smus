import 'package:hooks_riverpod/hooks_riverpod.dart';

import '../../model/posts_state_model.dart';
import '../notifiers/post_notifier.dart';

final postNotipod = StateNotifierProvider<PostNotifier, PostsStateModel>(
  (ref) {
    return PostNotifier();
  },
);
