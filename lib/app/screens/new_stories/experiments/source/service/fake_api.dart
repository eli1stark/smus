import 'dart:math';

class FakeHttpClient {
  Future<String> makeRequest() async {
    await Future.delayed(const Duration(seconds: 1));

    //! No internet Connection
    // throw const SocketException('No Internet');

    //! 404
    // throw const HttpException('404');

    //! Invalid JSON (throws FormatException)
    //return 'abc';

    return '{"username": "eli", "number": "${Random().nextInt(1000)}"}';
  }
}
