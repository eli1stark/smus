import 'fake_api.dart';

class PostService {
  static Future<String> post() async {
    final httpClient = FakeHttpClient();

    final response = await httpClient.makeRequest();

    return response;
  }
}
