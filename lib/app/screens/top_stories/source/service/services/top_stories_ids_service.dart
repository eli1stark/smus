import 'package:dio/dio.dart';

import '../../../../../../shared/constants/constants.dart';

Future<Response<dynamic>> topStoriesIdsService() async {
  final _dio = Dio();

  final response = await _dio.get('$apiPath/topstories.json');

  return response;
}
