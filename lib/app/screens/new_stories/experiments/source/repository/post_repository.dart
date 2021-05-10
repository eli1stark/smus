import 'dart:convert';
import 'dart:io';

import '../../model/post_model.dart';
import '../dto/post_dto.dart';
import '../service/post_service.dart';

class PostRepository {
  static Future<PostModel> post() async {
    final response = await PostService.post();

    final responseData = jsonDecode(response) as Map<String, dynamic>;

    final dto = PostDto.fromJson(responseData);

    return dto.toModel();
  }
}

class PostRepositoryWithCustomError {
  static Future<PostModel> post() async {
    try {
      final response = await PostService.post();

      final responseData = jsonDecode(response) as Map<String, dynamic>;

      final dto = PostDto.fromJson(responseData);

      final model = dto.toModel();

      return model;
    } on SocketException catch (_) {
      throw 'User friendly Socket Error';
    } catch (e) {
      throw 'Unknown user friendly error';
    }
  }
}
