import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/annotations.dart';
import 'package:mockito/mockito.dart';
import 'package:poc_automated_tests/http_request.dart';
import 'package:http/http.dart' as http;

import 'http_request_test.mocks.dart';

@GenerateMocks([http.Client])
void main() {
  group(
    'HTTP Request',
    () {
      test(
        'Request should return success',
        _requestShouldReturnSuccess,
      );

      test(
        'Request should return false',
        _requestShouldReturnFalse,
      );

      test(
        'Request should fail',
        _requestShouldFail,
      );
    },
  );
}

_requestShouldReturnSuccess() async {
  final client = MockClient();

  const String url = 'https://docs.flutter.dev/cookbook/testing/unit/mocking';

  when(
    client.head(
      Uri.parse(url),
    ),
  ).thenAnswer(
    (_) async => http.Response(
      '{"id": 1, "title": "mock"}',
      200,
    ),
  );

  expect(await HttpRequest.head(url, client), true);
}

_requestShouldReturnFalse() async {
  final client = MockClient();

  const String url = 'https://docs.flutter.dev/cookbook/testing/unit/mocking';

  when(
    client.head(
      Uri.parse(url),
    ),
  ).thenAnswer(
    (_) async => http.Response(
      'Not Found',
      404,
    ),
  );

  expect(await HttpRequest.head(url, client), false);
}

_requestShouldFail() {
  final client = MockClient();

  const String url = 'https://ds.flutr.dv/cokbok/testg/unt/mocng';

  when(
    client.head(
      Uri.parse(url),
    ),
  ).thenThrow(
    Exception('mock'),
  );

  expect(HttpRequest.head(url, client), throwsException);
}
