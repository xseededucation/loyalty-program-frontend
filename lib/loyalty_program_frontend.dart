library loyalty_program_frontend;

export 'src/repositories/reward_point_repository.dart';
export 'src/screens/reward_points_screen.dart';
export 'src/utils/loyalty_points_checker.dart';
export 'src/blocs/reward_points_event.dart';
export 'src/blocs/reward_points_state.dart';
export 'src/blocs/reward_points_bloc.dart';

/// A Calculator.
class Calculator {
  /// Returns [value] plus 1.
  int addOne(int value) => value + 1;
}
