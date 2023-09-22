import 'package:flutter_test/flutter_test.dart';
import 'package:loyalty_program_frontend/data/networking/api_base_helper.dart';
import 'package:loyalty_program_frontend/data/repositories/reward_point_repository.dart';
import 'package:loyalty_program_frontend/presentation/utils/constants/constant.dart';
import 'package:mockito/mockito.dart';

class MockApiBaseHelper extends Mock implements ApiBaseHelper {}

void main() {
  group('RewardPointRepository', () {
    late RewardPointRepository repository;
    late MockApiBaseHelper mockApiBaseHelper;

    setUp(() {
      mockApiBaseHelper = MockApiBaseHelper();
      repository = RewardPointRepository();
      repository.apiBaseHelper = mockApiBaseHelper;
    });

    test('checkCanAccessLoyaltyProgram - success', () async {
      final responseData = {'accessGranted': true};
      when(mockApiBaseHelper.get(Constants.baseUrl))
          .thenAnswer((_) async => responseData);

      final result = await repository.checkCanAccessLoyaltyProgram();

      expect(result, responseData);
      verify(mockApiBaseHelper.get('canAccessLoyaltyProgram'));
    });

    test('fetchPageInformation - success', () async {
      final responseData = {'pageTitle': 'Loyalty Program'};
      when(mockApiBaseHelper.get(Constants.baseUrl))
          .thenAnswer((_) async => responseData);

      final result = await repository.fetchPageInformation();

      expect(result, responseData);
      verify(mockApiBaseHelper.get('pageInformation'));
    });

    test('checkCanAccessLoyaltyProgram - failure', () async {
      when(mockApiBaseHelper.get('canAccessLoyaltyProgram'))
          .thenThrow(Exception('API error'));

      expect(
        () async => await repository.checkCanAccessLoyaltyProgram(),
        throwsA(isInstanceOf<Exception>()),
      );
      verify(mockApiBaseHelper.get('canAccessLoyaltyProgram'));
    });

    test('fetchPageInformation - failure', () async {
      when(mockApiBaseHelper.get('pageInformation'))
          .thenThrow(Exception('API error'));

      expect(
        () async => await repository.fetchPageInformation(),
        throwsA(isInstanceOf<Exception>()),
      );
      verify(mockApiBaseHelper.get('pageInformation'));
    });
  });
}
