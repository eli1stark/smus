import 'package:flutter/material.dart';
import 'package:flutter_hooks/flutter_hooks.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';

final askStpod = StateProvider<int>((ref) {
  return 5;
});

final stringStpod = Provider<String>((ref) {
  return 'hey';
});

final _scope = ScopedProvider<int>(null);
final _scopeProvider = ScopedProvider<StateProvider<int>>(null);

class AskStories extends HookWidget {
  const AskStories({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final ask = useProvider(askStpod);

    return Center(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Text('Ask Screen ${ask.state}'),
          ProviderScope(
            overrides: [
              _scope.overrideWithValue(ask.state),
              _scopeProvider.overrideWithValue(askStpod)
            ],
            child: const AskString(),
          ),
          TextButton(
            onPressed: () {
              ask.state++;
            },
            child: const Text('add'),
          ),
        ],
      ),
    );
  }
}

class AskString extends HookWidget {
  const AskString();

  @override
  Widget build(BuildContext context) {
    // final ask = useProvider(askStpod);
    // final scope = useProvider(_scope);
    final scopeProvider = useProvider(_scopeProvider);
    final scopeP = useProvider(scopeProvider);

    return Column(
      children: [
        Text('Ask Screen ${scopeP.state}'),
        TextButton(
          onPressed: () {
            scopeP.state--;
          },
          child: const Text('sub'),
        )
      ],
    );
  }
}
