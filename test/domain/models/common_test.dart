import 'package:flutter_test/flutter_test.dart';
import 'package:loyalty_program_frontend/domain/models/common.dart';

void main() {
  group('Common', () {
    test('fromJson should parse JSON correctly', () {
      final json = {
        'status': 'success',
        'data': {'key': 'value'},
      };

      final common = Common.fromJson(json, (dynamic json) {
        return json;
      });

      expect(common.status, 'success');
      expect(common.data, {'key': 'value'});
    });

    test('toJson should convert to JSON correctly', () {
      final data = {'key': 'value'};
      final common = Common(status: 'success', data: data);

      final json = common.toJson((dynamic data) {
        return data;
      });

      expect(json, {
        'status': 'success',
        'message': 'success',
        'data': {'key': 'value'},
      });
    });

    test('fromJson should handle null data gracefully', () {
      final json = {'status': 'success', 'data': null};

      final common = Common.fromJson(json, (dynamic json) {
        return json;
      });

      expect(common.status, 'success');
      expect(common.data, isNull);
    });

    test('toJson should handle null data gracefully', () {
      final common = Common(status: 'success', data: null);

      final json = common.toJson((dynamic data) {
        return data;
      });

      expect(json, {
        'status': 'success',
        'message': 'success',
      });
    });
  });
}
