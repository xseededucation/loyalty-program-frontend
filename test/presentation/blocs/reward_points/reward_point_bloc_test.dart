import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:loyalty_program_frontend/data/repositories/reward_point_repository.dart';
import 'package:loyalty_program_frontend/presentation/blocs/reward_points/reward_points_bloc.dart';
import 'package:loyalty_program_frontend/presentation/blocs/reward_points/reward_points_event.dart';
import 'package:loyalty_program_frontend/presentation/blocs/reward_points/reward_points_state.dart';
import 'package:mockito/mockito.dart';

class MockRewardPointRepository extends Mock implements RewardPointRepository {}

class MockEmitter extends Mock implements Emitter<RewardPointsState> {}

void main() {
  group('RewardPointsBloc Tests', () {
    late MockRewardPointRepository mockRepository;
    late RewardPointsBloc bloc;
    late MockEmitter mockEmitter;

    setUp(() {
      mockRepository = MockRewardPointRepository();
      mockEmitter = MockEmitter();
      bloc = RewardPointsBloc(rewardPointRepository: mockRepository);
    });

    tearDown(() {
      bloc.close();
    });

    test('Initial state is correct', () {
      expect(bloc.state, RewardPointsInitial());
    });

    test('CanAccessLoyaltyProgram event emits success state', () async {
      when(mockRepository.checkCanAccessLoyaltyProgram())
          .thenAnswer((_) async => {'status': true});

      final expectedStates = [
        RewardPointsInProgress(),
        RewardPointsSuccess(),
      ];

      expectLater(bloc.stream, emitsInOrder(expectedStates));

      bloc.add(CanAccessLoyaltyProgram());
    });

    test('CanAccessLoyaltyProgram event emits failure state', () async {
      when(mockRepository.checkCanAccessLoyaltyProgram()).thenAnswer(
          (_) async => {'status': false, 'message': 'Access denied'});

      final expectedStates = [
        RewardPointsInProgress(),
        RewardPointsFailure('Access denied'),
      ];

      expectLater(bloc.stream, emitsInOrder(expectedStates));

      bloc.add(CanAccessLoyaltyProgram());
    });
  });
}
