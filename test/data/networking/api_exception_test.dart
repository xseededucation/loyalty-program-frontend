import 'package:flutter_test/flutter_test.dart';
import 'package:loyalty_program_frontend/data/networking/api_exception.dart';

void main() {
  group('AppException Tests', () {
    test('FetchDataException should have the correct prefix and message', () {
      final exception = FetchDataException("Network error");

      expect(exception.toString(), "Error During Communication: Network error");
    });

    test('BadRequestException should have the correct prefix and message', () {
      final exception = BadRequestException("Invalid data");

      expect(exception.toString(), "Invalid Request: Invalid data");
    });

    test('UnauthorizedException should have the correct prefix and message',
        () {
      final exception = UnauthorizedException("Access denied");

      expect(exception.toString(), "Unauthorized: Access denied");
    });

    test('InvalidInputException should have the correct prefix and message',
        () {
      final exception = InvalidInputException("Invalid input");

      expect(exception.toString(), "Invalid Input: Invalid input");
    });
  });
}
