import 'package:flutter_test/flutter_test.dart';
import 'package:loyalty_program_frontend/loyalty_program_frontend.dart';
import 'package:mockito/mockito.dart';
import 'package:http/http.dart' as http;
import 'package:loyalty_program_frontend/data/networking/api_base_helper.dart';

class MockHttpClient extends Mock implements http.Client {}

class MockApiBaseHelper extends Mock implements ApiBaseHelper {
  final http.Client client = MockHttpClient();
}

void main() {
  group('RewardPointRepository Tests', () {
   MockApiBaseHelper mockApiBaseHelper = MockApiBaseHelper();
    late RewardPointRepository repository;

    setUp(() {
      mockApiBaseHelper = MockApiBaseHelper();
      repository = RewardPointRepository();
      repository.apiBaseHelper = mockApiBaseHelper;
    });

    test('checkCanAccessLoyaltyProgram success', () async {
      when(mockApiBaseHelper.get('https://loyalty-program-apis.xseeddigital.info/api/canAccessLoyaltyProgram'))
          .thenAnswer((_) async => http.Response('{"status": "success"}', 200));
      final result = await repository.checkCanAccessLoyaltyProgram();
      expect(result, isTrue);
    });

    test('fetchPageInformation success', () async {
      when(mockApiBaseHelper.get(
              'https://loyalty-program-apis.xseeddigital.info/api/pageInformation'))
          .thenAnswer(
              (_) async => http.Response('{"info": "sample info"}', 200));
      final result = await repository.fetchPageInformation();
      expect(result, equals('sample info'));
    });

    test('makePayment success', () async {
      when(mockApiBaseHelper.post('', any))
          .thenAnswer((_) async => http.Response('{"success": true}', 200));
      final result = await repository.makePayment(100, 'product123');
      expect(result, isTrue);
    });

    test('updateUserActivity success', () async {
      when(mockApiBaseHelper.post('', any))
          .thenAnswer((_) async => http.Response('{"success": true}', 200));
      final result = await repository.updateUserActivity('activityType');
      expect(result, isTrue);
    });
  });
}
