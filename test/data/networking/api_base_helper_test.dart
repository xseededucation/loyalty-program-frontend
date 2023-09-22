import 'package:flutter_test/flutter_test.dart';
import 'package:http/http.dart' as http;
import 'package:http/testing.dart';
import 'package:loyalty_program_frontend/data/networking/api_base_helper.dart';
import 'package:loyalty_program_frontend/data/networking/api_exception.dart';

void main() {
  TestWidgetsFlutterBinding.ensureInitialized();

  group('ApiBaseHelper Tests', () {
    test('Test successful GET request', () async {
      final mockClient = MockClient((request) async {
        return http.Response('{"message": "Success"}', 200);
      });

      final apiBaseHelper = ApiBaseHelper(mockClient);

      final response = await apiBaseHelper.get('/test');

      expect(response, {"message": "Success"});
    });

    test('Test 401 Unauthorized response', () async {
      final mockClient = MockClient((request) async {
        return http.Response('{"error": "Unauthorized"}', 401);
      });

      final apiBaseHelper = ApiBaseHelper(mockClient);

      await expectLater(() async {
        await apiBaseHelper.get('/test');
      }, throwsA(isA<UnauthorizedException>()));
    });

    // Add more tests for other methods (post, put, delete) if needed
  });
}
