import 'package:freezed_annotation/freezed_annotation.dart';

part 'navigation_model.freezed.dart';

@freezed
class NavigationModel with _$NavigationModel {
  const factory NavigationModel(int currentIndex) = _NavigationModel;
}
