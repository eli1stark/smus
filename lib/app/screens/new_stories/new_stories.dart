import 'package:flutter/material.dart';
import 'package:flutter_hooks/flutter_hooks.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';

import 'experiments/state/providers/post_fpod.dart';
import 'experiments/state/providers/post_notipod.dart';

class NewStories extends HookWidget {
  const NewStories({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final fpod = useProvider(postFpod);
    final state = useProvider(postNotipod);
    final notifier = useProvider(postNotipod.notifier);

    return Center(
      child: Column(
        children: [
          fpod.when(
            data: (_) {
              final posts = <Widget>[];

              for (final i in state.posts) {
                posts.add(
                  Text(
                    i.toString(),
                    style: const TextStyle(
                      fontSize: 20.0,
                    ),
                  ),
                );
              }

              return Column(
                children: [
                  ...posts,
                  state.union.when(
                    success: () => const SizedBox(),
                    loading: () => const CircularProgressIndicator(),
                    error: (e, st) {
                      return Text(
                        'Fetch Status error: $e',
                        style: const TextStyle(
                          fontSize: 20.0,
                        ),
                      );
                    },
                    nothingToLoad: () {
                      return const Text('Nothing to load');
                    },
                  )
                ],
              );
            },
            loading: () => const CircularProgressIndicator(),
            error: (e, st) {
              return Text(
                'Riverpod error: $e',
                style: const TextStyle(
                  fontSize: 20.0,
                ),
              );
            },
          ),
          TextButton(
            onPressed: () {
              context.refresh(postFpod);
            },
            child: const Text('refresh'),
          ),
          TextButton(
            onPressed: () {
              notifier.addPost();
            },
            child: const Text('add new Post'),
          ),
        ],
      ),
    );
  }
}
