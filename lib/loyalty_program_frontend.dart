library loyalty_program_frontend;

export '/presentation/screens/reward_points_screen.dart';
export '/presentation/utils/helpers/loyalty_points_checker.dart';
export '/data/repositories/reward_point_repository.dart';
export '/presentation/screens/reward_points_screen.dart';
export '/presentation/utils/helpers/loyalty_points_checker.dart';

export '/presentation/blocs/reward_points/reward_points_event.dart';
export '/presentation/blocs/reward_points/reward_points_bloc.dart';
export '/presentation/blocs/reward_points/reward_points_state.dart';

/// A Calculator.
class Calculator {
  /// Returns [value] plus 1.
  int addOne(int value) => value + 1;
}
