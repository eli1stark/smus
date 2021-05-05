import 'package:dio/dio.dart';

import 'services/job_by_id_service.dart';
import 'services/job_stories_service.dart';

class JobStoriesService {
  Future<Response<dynamic>> jobById(int id) {
    return jobByIdService(id);
  }

  Future<Response<dynamic>> jobStories() {
    return jobStoriesService();
  }
}
