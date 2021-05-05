import '../../../../../../shared/helpers/handler.dart';
import '../../../model/job_stories_model.dart';
import '../../dto/job_stories_dto.dart';
import '../../service/job_stories_service.dart';

Future<Handler<JobStoriesModel>> jobStoriesRepository() async {
  final _service = JobStoriesService();

  try {
    final response = await _service.jobStories();

    final responseData = response.data as List<dynamic>;

    final dto = JobStoriesDto.fromList(responseData);

    final model = dto.toModel();

    return Handler(model: model);
  } catch (e) {
    return Handler(error: 'e');
  }
}
