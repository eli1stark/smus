import 'package:flutter/material.dart';
import 'package:flutter_hooks/flutter_hooks.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';

import 'experiments/state/providers/post_notipod.dart';
import 'experiments/state/repositories/post_frep.dart';

class NewStories extends HookWidget {
  const NewStories({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final frep = useProvider(postFrepWithNotifier);
    final state = useProvider(postNotipod);
    final notifier = useProvider(postNotipod.notifier);

    return Center(
      child: Column(
        children: [
          frep.when(
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
                  state.fetchStatus.when(
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
              context.refresh(postFrepWithNotifier);
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
