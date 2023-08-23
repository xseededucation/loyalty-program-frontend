import 'package:flutter_test/flutter_test.dart';
import 'package:loyalty_program_frontend/loyalty_program_frontend.dart';

void main() {
  group('RewardPointEvent', () {
    group("CanAccessLoyaltyProgram", () {});
    group("FetchPageInformationEvent", () {});
    group("TriggerPaymentEvent", () {
      test("Supports value equality", () {
        expect(TriggerPaymentEvent(1000,""), TriggerPaymentEvent(1000,""));
      });
      test("Props are correct", () {
        expect(TriggerPaymentEvent(1000,"").props, equals(<Object?>[1000,""]));
      });
    });
  });
}
