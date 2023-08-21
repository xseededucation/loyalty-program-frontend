import 'package:flutter_test/flutter_test.dart';
import 'package:loyalty_program_frontend/loyalty_program_frontend.dart';

void main() {
  group('RewardPointsState', () {
    test('RewardPointsInitial is equatable', () {
      final state1 = RewardPointsInitial();
      final state2 = RewardPointsInitial();

      expect(state1, state2);
    });

    test('RewardPointsInProgress is equatable', () {
      final state1 = RewardPointsInProgress();
      final state2 = RewardPointsInProgress();

      expect(state1, state2);
    });

    test('RewardPointsSuccess is equatable', () {
      final state1 = RewardPointsSuccess();
      final state2 = RewardPointsSuccess();

      expect(state1, state2);
    });

    test('RewardPointsFailure is equatable', () {
      const state1 = RewardPointsFailure("Error");
      const state2 = RewardPointsFailure("Error");

      expect(state1, state2);
    });
  });
}
