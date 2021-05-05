import '../../../../../shared/helpers/handler.dart';
import '../../model/job_model.dart';
import '../../model/job_stories_model.dart';
import 'repositories/job_by_id_repository.dart';
import 'repositories/job_stories_repository.dart';

class JobStoriesRepository {
  Future<Handler<JobModel>> jobById(int id) {
    return jobByIdRepository(id);
  }

  Future<Handler<JobStoriesModel>> jobStories() {
    return jobStoriesRepository();
  }
}
