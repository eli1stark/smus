import 'package:dio/dio.dart';

import 'services/story_by_id_service.dart';

class StoryService {
  Future<Response<dynamic>> storyById(int id) {
    return storyByIdService(id);
  }
}
