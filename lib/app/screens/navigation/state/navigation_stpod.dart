import 'package:hooks_riverpod/hooks_riverpod.dart';

import '../model/navigation_model.dart';

final navigationStpod = StateProvider<NavigationModel>((ref) {
  return const NavigationModel(0);
});
