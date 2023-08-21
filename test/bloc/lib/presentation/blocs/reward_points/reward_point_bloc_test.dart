import 'package:flutter_test/flutter_test.dart';
import 'package:loyalty_program_frontend/loyalty_program_frontend.dart';
import 'package:mockito/mockito.dart';

class MockRewardPointRepository extends Mock implements RewardPointRepository {}

void main() {
  late MockRewardPointRepository mockRepository;

  setUp(() {
    mockRepository = MockRewardPointRepository();
  });

  group('RewardPointsBloc', () {
    test(
        'emits [RewardPointsInProgress, RewardPointsSuccess] when CanAccessLoyaltyProgram event is added and status is true',
        () {
      final response = {"status": true};
      when(mockRepository.checkCanAccessLoyaltyProgram())
          .thenAnswer((_) async => response);

      final bloc = RewardPointsBloc(rewardPointRepository: mockRepository);

      final expected = [
        RewardPointsInProgress(),
        RewardPointsSuccess(),
      ];

      bloc.add(CanAccessLoyaltyProgram());

      expectLater(bloc.stream, emitsInOrder(expected));

      bloc.close();
    });

    test(
        'emits [RewardPointsInProgress, RewardPointsFailure] when CanAccessLoyaltyProgram event is added and status is false',
        () {
      final response = {"status": false, "message": "Access denied"};
      when(mockRepository.checkCanAccessLoyaltyProgram())
          .thenAnswer((_) async => response);

      final bloc = RewardPointsBloc(rewardPointRepository: mockRepository);

      final expected = [
        RewardPointsInProgress(),
        RewardPointsFailure("Access denied"),
      ];

      bloc.add(CanAccessLoyaltyProgram());

      expectLater(bloc.stream, emitsInOrder(expected));

      bloc.close();
    });

    test(
        'emits [RewardPointsInProgress, RewardPointsFailure] when repository throws an error',
        () {
      when(mockRepository.checkCanAccessLoyaltyProgram())
          .thenThrow(Exception('Error'));

      final bloc = RewardPointsBloc(rewardPointRepository: mockRepository);

      final expected = [
        RewardPointsInProgress(),
        const RewardPointsFailure("Error"),
      ];

      bloc.add(CanAccessLoyaltyProgram());

      expectLater(bloc.stream, emitsInOrder(expected));

      bloc.close();
    });
  });
}
