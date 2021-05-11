import 'package:hooks_riverpod/hooks_riverpod.dart';

import 'post_notipod.dart';

final postFpod = FutureProvider<void>((ref) async {
  final notifier = ref.watch(postNotipod.notifier);

  await notifier.initialize();
});
