import 'package:flutter_test/flutter_test.dart';
import 'package:loyalty_program_frontend/loyalty_program_frontend.dart';

void main() {
  group('CanAccessLoyaltyProgram', () {
    test('two instances are equal', () {
      // Arrange
      final event1 = CanAccessLoyaltyProgram();
      final event2 = CanAccessLoyaltyProgram();

      // Act & Assert
      expect(event1, event2);
    });
  });
}
