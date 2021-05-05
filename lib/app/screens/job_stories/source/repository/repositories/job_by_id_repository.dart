import '../../../../../../shared/helpers/handler.dart';
import '../../../model/job_model.dart';
import '../../dto/job_dto.dart';
import '../../service/job_stories_service.dart';

Future<Handler<JobModel>> jobByIdRepository(int id) async {
  final _service = JobStoriesService();

  try {
    final response = await _service.jobById(id);

    final responseData = response.data as Map<String, dynamic>;

    final dto = JobDto.fromJson(responseData);

    final model = dto.toModel();

    return Handler(model: model);
  } catch (e) {
    return Handler(error: 'e');
  }
}
