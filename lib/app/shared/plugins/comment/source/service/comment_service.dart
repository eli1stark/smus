import 'package:dio/dio.dart';

import 'services/comment_by_id_service.dart';

class CommentService {
  Future<Response<dynamic>> commentById(int id) {
    return commentByIdService(id);
  }
}
