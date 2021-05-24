import 'package:freezed_annotation/freezed_annotation.dart';

part 'post_model.freezed.dart';

@freezed
class PostModel with _$PostModel {
  const factory PostModel({
    required String username,
    required String number,
  }) = _PostModel;
}

@immutable
class ImmutableModel {
  const ImmutableModel({
    required this.newModel,
    required this.number,
  });

  final NewModel? newModel;
  final int? number;

  ImmutableModel copyWith({
    NewModel? newModel,
    int? number,
  }) {
    return ImmutableModel(
      newModel: newModel ?? newModel,
      number: number ?? this.number,
    );
  }

  @override
  bool operator ==(Object other) {
    if (identical(this, other)) return true;
  
    return other is ImmutableModel &&
      other.newModel == newModel &&
      other.number == number;
  }

  @override
  int get hashCode => newModel.hashCode ^ number.hashCode;

  @override
  String toString() => 'ImmutableModel(newModel: $newModel, number: $number)';
}

@immutable
class NewModel {
  const NewModel({required this.name});
  final String? name;

  NewModel copyWith({
    String? name,
  }) {
    return NewModel(
      name: name ?? this.name,
    );
  }
}

// null
// deep copy
// ==
// toString
void intro() {
  const model1 = ImmutableModel(
    newModel: NewModel(name: 'new Name'),
    number: 5,
  );

  const model2 = ImmutableModel(
    newModel: NewModel(name: 'new Name'),
    number: 5,
  );

  print(model1 == model2);
}
