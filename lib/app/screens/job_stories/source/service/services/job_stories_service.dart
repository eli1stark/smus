import 'package:dio/dio.dart';

import '../../../../../../shared/constants/constants.dart';

Future<Response<dynamic>> jobStoriesService() async {
  final _dio = Dio();

  final response = await _dio.get('$apiPath/jobstories.json');

  return response;
}
