import 'package:flutter/material.dart';
import 'package:flutter_hooks/flutter_hooks.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';

final provider = Provider<int>((ref) {
  return 1;
});

final futureProvider = FutureProvider<int>((ref) async {
  await Future.delayed(const Duration(seconds: 1));

  return 7;
});

final stream = StreamProvider<int>((ref) {
  return Stream.value(1);
});

final stateProvider = StateProvider<int>((ref) {
  return 1;
});

final notifierProvider = StateNotifierProvider<MyNotifier, int>((ref) {
  return MyNotifier();
});

class MyNotifier extends StateNotifier<int> {
  MyNotifier() : super(1);

  // ignore: use_setters_to_change_properties
  void add(int number) {
    state = number;
  }

  void subtract() {
    state = state - 1;
  }
}

class JobStories extends HookWidget {
  const JobStories({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final state = useProvider(notifierProvider);
    final notifier = useProvider(notifierProvider.notifier);
    final future = useProvider(futureProvider);
    final stateP = useProvider(stateProvider);
    final value = useState(2);

    return Center(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          future.when(
            data: (data) {
              return Text(
                data.toString(),
                style: const TextStyle(
                  fontSize: 40.0,
                ),
              );
            },
            loading: () => const CircularProgressIndicator(),
            error: (o, st) => Text('$o $st'),
          ),
          Text(
            state.toString(),
            style: const TextStyle(
              fontSize: 40.0,
            ),
          ),
          Text(
            stateP.state.toString(),
            style: const TextStyle(
              fontSize: 40.0,
            ),
          ),
          Text(
            value.value.toString(),
            style: const TextStyle(
              fontSize: 40.0,
            ),
          ),
          TextButton(
            onPressed: () {
              notifier.add(5);
            },
            child: const Text('Add'),
          ),
          TextButton(
            onPressed: () {
              notifier.subtract();
            },
            child: const Text('Sub'),
          ),
          TextButton(
            onPressed: () {
              stateP.state = 9;
            },
            child: const Text('State provider'),
          ),
          TextButton(
            onPressed: () {
              value.value = 0;
            },
            child: const Text('Use state'),
          )
        ],
      ),
    );
  }
}
