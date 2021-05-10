import 'package:hooks_riverpod/hooks_riverpod.dart';

import '../../model/post_model.dart';
import '../../source/repository/post_repository.dart';
import '../providers/post_notipod.dart';

final postFrep = FutureProvider<PostModel>((ref) async {
  final result = await PostRepository.post();

  return result;
});

final postFrepWithNotifier = FutureProvider<void>((ref) async {
  final notifier = ref.watch(postNotipod.notifier);

  await notifier.initialize();
});
