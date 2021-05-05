import 'package:dio/dio.dart';

import 'services/top_stories_ids_service.dart';

class TopStoriesService {
  Future<Response<dynamic>> topStoriesIds() {
    return topStoriesIdsService();
  }
}
