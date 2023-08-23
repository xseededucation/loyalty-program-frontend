import 'package:flutter_test/flutter_test.dart';
import 'package:loyalty_program_frontend/domain/models/page_information.dart';
import 'package:loyalty_program_frontend/loyalty_program_frontend.dart';

void main() {
  group('RewardPointsState', () {
    final mockPageInformation = PageInformation();
    group('RewardPointsState, initial', () {
      test('RewardPointsInitial is equatable', () {
        final state1 = RewardPointsInitial();
        final state2 = RewardPointsInitial();
        expect(state1, state2);
      });
    });

    test('RewardPointsInProgress is equatable', () {
      final state1 = RewardPointsInProgress();
      final state2 = RewardPointsInProgress();

      expect(state1, state2);
    });

    group('RewardPointsState, success', () {
      
      RewardPointsSuccess createSubject() {
        return RewardPointsSuccess(pageInformation: mockPageInformation);
      }

      test('RewardPointsSuccess supports value quality', () {
        expect(createSubject(), equals(createSubject()));
      });

      test('RewardPointsSuccess props are correct', () {
        expect(createSubject().props, equals(<Object?>[mockPageInformation]));
      });

      test('RewardPointsSuccess return single object with updated status', () {
        expect(createSubject().copyWith(
          pageInformation: PageInformation(currentCredit: 0)
        ), RewardPointsSuccess(pageInformation: PageInformation(currentCredit: 0)));
      });
    });

    test('RewardPointsFailure is equatable', () {
      const state1 = RewardPointsFailure("Error");
      const state2 = RewardPointsFailure("Error");

      expect(state1, state2);
    });
  });
}
