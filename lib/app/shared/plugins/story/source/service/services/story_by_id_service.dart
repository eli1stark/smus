import 'package:dio/dio.dart';

import '../../../../../../../shared/constants/constants.dart';

Future<Response<dynamic>> storyByIdService(int id) async {
  final _dio = Dio();

  final response = await _dio.get('$apiPath/item/$id.json');

  return response;
}
