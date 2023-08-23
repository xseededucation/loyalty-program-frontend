import 'package:flutter_test/flutter_test.dart';
import 'package:loyalty_program_frontend/loyalty_program_frontend.dart';
import 'package:mockito/annotations.dart';
import 'package:mockito/mockito.dart';

@GenerateNiceMocks([MockSpec<LoyaltyProgramEvent>()])
import 'loyalty_points_checker_test.mocks.dart';

void main() {
  group('LoyaltyProgramEvents', () {
    var loyalty_points_checker_test = MockLoyaltyProgramEvent();
    test('appOpened method called', () {
      loyalty_points_checker_test.appOpened();
      expect(verify(loyalty_points_checker_test.appOpened));
    });
  });
}
