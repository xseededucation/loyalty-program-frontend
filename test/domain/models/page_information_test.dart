import 'package:flutter_test/flutter_test.dart';
import 'package:loyalty_program_frontend/domain/models/page_information.dart';

void main() {
  group('PageInformation', () {
    test('fromJson should parse JSON correctly', () {
      final json = {
        'conversionRates': [
          {'credit': 100, 'denomination': 10},
          {'credit': 200, 'denomination': 20},
        ],
        'currentCredit': 500,
        'eventToCreditMap': [
          {'event': 'Event1', 'creditGiven': 50, 'timeInMins': 10},
          {'event': 'Event2', 'creditGiven': 75, 'timeInMins': 15},
        ],
        'debitActivity': {
          'Transaction': [
            {'_id': '1', 'credit': 50},
            {'_id': '2', 'credit': 75},
          ],
        },
        'zeroCreditMessage': 'No credit available.',
        'zeroCreditHeaderMessage': 'Zero Credit',
      };

      final pageInformation = PageInformation.fromJson(json);

      expect(pageInformation.conversionRates, isA<List<ConversionRates>>());
      expect(pageInformation.conversionRates!.length, 2);

      expect(pageInformation.currentCredit, 500);

      expect(pageInformation.eventToCreditMap, isA<List<EventToCreditMap>>());
      expect(pageInformation.eventToCreditMap!.length, 2);

      expect(pageInformation.debitActivity, isA<DebitActivity>());

      expect(pageInformation.zeroCreditMessage, 'No credit available.');
      expect(pageInformation.zeroCreditHeaderMessage, 'Zero Credit');
    });

    test('toJson should convert to JSON correctly', () {
      final conversionRates = [
        ConversionRates(credit: 100, denomination: 10),
        ConversionRates(credit: 200, denomination: 20),
      ];

      final eventToCreditMap = [
        EventToCreditMap(event: 'Event1', creditGiven: 50, timeInMins: 10),
        EventToCreditMap(event: 'Event2', creditGiven: 75, timeInMins: 15),
      ];

      final pageInformation = PageInformation(
        conversionRates: conversionRates,
        currentCredit: 500,
        eventToCreditMap: eventToCreditMap,
      );

      final json = pageInformation.toJson();

      expect(json, {
        'conversionRates': [
          {
            'credit': 100,
            'denomination': 10,
            'sequenceNo': null,
            'toolTipText': null,
            'headerText': null
          },
          {
            'credit': 200,
            'denomination': 20,
            'sequenceNo': null,
            'toolTipText': null,
            'headerText': null
          },
        ],
        'currentCredit': 500,
        'zeroCreditMessage': null,
        'zeroCreditHeaderMessage': null,
        'eventToCreditMap': [
          {'event': 'Event1', 'creditGiven': 50, 'timeInMins': 10},
          {'event': 'Event2', 'creditGiven': 75, 'timeInMins': 15}
        ],
      });
    });
  });
  group('Transaction', () {
    test('fromJson should parse JSON correctly', () {
      final json = {
        '_id': '12345',
        'caaUserId': 'user123',
        'credit': 100,
        'transactionType': 'purchase',
        'refNo': 'ref123',
        'status': 'completed',
        'denomination': 10,
        'sourceApp': 'app123',
        'createdAt': '2023-09-04T12:34:56Z',
        'updatedAt': '2023-09-04T12:34:56Z',
        '__v': 1,
      };

      final transaction = Transaction.fromJson(json);

      expect(transaction.sId, '12345');
      expect(transaction.caaUserId, 'user123');
      expect(transaction.credit, 100);
      expect(transaction.transactionType, 'purchase');
      expect(transaction.refNo, 'ref123');
      expect(transaction.status, 'completed');
      expect(transaction.denomination, 10);
      expect(transaction.sourceApp, 'app123');
      expect(transaction.createdAt, '2023-09-04T12:34:56Z');
      expect(transaction.updatedAt, '2023-09-04T12:34:56Z');
      expect(transaction.iV, 1);
    });

    test('toJson should convert to JSON correctly', () {
      final transaction = Transaction(
        sId: '12345',
        caaUserId: 'user123',
        credit: 100,
        transactionType: 'purchase',
        refNo: 'ref123',
        status: 'completed',
        denomination: 10,
        sourceApp: 'app123',
        createdAt: '2023-09-04T12:34:56Z',
        updatedAt: '2023-09-04T12:34:56Z',
        iV: 1,
      );

      final json = transaction.toJson();

      expect(json, {
        '_id': '12345',
        'caaUserId': 'user123',
        'credit': 100,
        'transactionType': 'purchase',
        'refNo': 'ref123',
        'status': 'completed',
        'denomination': 10,
        'sourceApp': 'app123',
        'createdAt': '2023-09-04T12:34:56Z',
        'updatedAt': '2023-09-04T12:34:56Z',
        '__v': 1,
      });
    });
  });
  group('DebitActivity', () {
    test('fromJson should parse JSON correctly', () {
      final json = {
        'Transaction': [
          {
            '_id': '12345',
            'caaUserId': 'user123',
            'credit': 100,
            'transactionType': 'purchase',
            'refNo': 'ref123',
            'status': 'completed',
            'denomination': 10,
            'sourceApp': 'app123',
            'createdAt': '2023-09-04T12:34:56Z',
            'updatedAt': '2023-09-04T12:34:56Z',
            '__v': 1,
          },
          {
            '_id': '67890',
            'caaUserId': 'user456',
            'credit': 200,
            'transactionType': 'refund',
            'refNo': 'ref456',
            'status': 'canceled',
            'denomination': 20,
            'sourceApp': 'app456',
            'createdAt': '2023-09-05T14:45:30Z',
            'updatedAt': '2023-09-05T14:45:30Z',
            '__v': 2,
          },
        ],
        'OtherTransactionType': [
          {
            '_id': 'abcd',
            'caaUserId': 'user789',
            'credit': 300,
            'transactionType': 'withdraw',
            'refNo': 'ref789',
            'status': 'completed',
            'denomination': 30,
            'sourceApp': 'app789',
            'createdAt': '2023-09-06T10:15:20Z',
            'updatedAt': '2023-09-06T10:15:20Z',
            '__v': 3,
          },
        ],
      };

      final debitActivity = DebitActivity.fromJson(json);

      expect(debitActivity.debitActivityMap, isA<Map<String, dynamic>>());

      final transactionList = debitActivity.debitActivityMap['Transaction'];
      expect(transactionList, isA<List<dynamic>>());
      expect(transactionList!.length, 2);

      final transaction = transactionList[0];
      expect(transaction, isA<Transaction>());
      expect(transaction.sId, '12345');
      expect(transaction.caaUserId, 'user123');
      expect(transaction.credit, 100);

      final otherTransactionList =
          debitActivity.debitActivityMap['OtherTransactionType'];
      expect(otherTransactionList, isA<List<dynamic>>());
      expect(otherTransactionList!.length, 1);

      final otherTransaction = otherTransactionList[0];
      expect(otherTransaction, isA<Transaction>());
      expect(otherTransaction.sId, 'abcd');
    });
  });
}
