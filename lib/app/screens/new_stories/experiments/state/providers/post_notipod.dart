import 'package:hooks_riverpod/hooks_riverpod.dart';

import '../notifiers/post_notifier/post_notifier.dart';
import '../notifiers/post_notifier/state/post_state.dart';

final postNotipod = StateNotifierProvider<PostNotifier, PostState>(
  (ref) {
    return PostNotifier();
  },
);
