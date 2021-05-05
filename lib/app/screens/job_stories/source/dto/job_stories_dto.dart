import '../../model/job_stories_model.dart';

// We don't need @JsonSerializable
// since we are reciving List<dynamic>
class JobStoriesDto {
  JobStoriesDto({
    required this.jobIds,
  });

  factory JobStoriesDto.fromList(List<dynamic> list) {
    return JobStoriesDto(
      jobIds: list.map((e) => e as int).toList(),
    );
  }

  JobStoriesModel toModel() {
    return JobStoriesModel(
      jobIds: jobIds,
    );
  }

  // We also don't need toJson and fromModel
  // since we won't be POSTing to the API
  // YAGNI

  final List<int> jobIds;
}
