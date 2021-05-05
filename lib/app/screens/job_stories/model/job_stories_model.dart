import 'package:flutter/foundation.dart';

@immutable
class JobStoriesModel {
  const JobStoriesModel({
    required this.jobIds,
  });

  final List<int> jobIds;
}
