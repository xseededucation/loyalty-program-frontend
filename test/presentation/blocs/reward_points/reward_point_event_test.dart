import 'package:flutter_test/flutter_test.dart';
import 'package:loyalty_program_frontend/presentation/blocs/reward_points/reward_points_event.dart';

void main() {
  group('RewardPointsEvent Tests', () {
    test('Test CanAccessLoyaltyProgram event', () {
      final event = CanAccessLoyaltyProgram();

      expect(event.props, []);
    });

    test('Test FetchPageInformationEvent event', () {
      final event = FetchPageInformationEvent();

      expect(event.props, []);
    });

    test('Test TriggerPaymentEvent event', () {
      final event = TriggerPaymentEvent(100, 'product123');

      expect(event.creditToRedeem, 100);
      expect(event.productId, 'product123');
      expect(event.props, [100, 'product123']);
    });
  });
}
