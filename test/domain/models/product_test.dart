import 'package:flutter_test/flutter_test.dart';
import 'package:loyalty_program_frontend/domain/models/product.dart';

void main() {
  group('Product', () {
    test('fromJson should parse JSON correctly', () {
      final json = {
        'productList': [
          {
            'id': '1',
            'name': 'Product 1',
            'url': 'https://example.com/product1'
          },
          {
            'id': '2',
            'name': 'Product 2',
            'url': 'https://example.com/product2'
          },
        ],
      };

      final product = Product.fromJson(json);

      expect(product.productList, isA<List<ProductList>>());
      expect(product.productList!.length, 2);

      expect(product.productList![0].id, '1');
      expect(product.productList![0].name, 'Product 1');
      expect(product.productList![0].url, 'https://example.com/product1');

      expect(product.productList![1].id, '2');
      expect(product.productList![1].name, 'Product 2');
      expect(product.productList![1].url, 'https://example.com/product2');
    });

    test('toJson should convert to JSON correctly', () {
      final productList1 = ProductList(
          id: '1', name: 'Product 1', url: 'https://example.com/product1');
      final productList2 = ProductList(
          id: '2', name: 'Product 2', url: 'https://example.com/product2');
      final product = Product(productList: [productList1, productList2]);

      final json = product.toJson();

      expect(json, isA<Map<String, dynamic>>());
      expect(json['productList'], isA<List<dynamic>>());
      expect(json['productList'].length, 2);

      expect(json['productList'][0], {
        'id': '1',
        'name': 'Product 1',
        'url': 'https://example.com/product1',
      });

      expect(json['productList'][1], {
        'id': '2',
        'name': 'Product 2',
        'url': 'https://example.com/product2',
      });
    });
  });

  group('ProductList', () {
    test('fromJson should parse JSON correctly', () {
      final json = {
        'id': '1',
        'name': 'Product 1',
        'url': 'https://example.com/product1'
      };

      final productList = ProductList.fromJson(json);

      expect(productList.id, '1');
      expect(productList.name, 'Product 1');
      expect(productList.url, 'https://example.com/product1');
    });

    test('toJson should convert to JSON correctly', () {
      final productList = ProductList(
          id: '1', name: 'Product 1', url: 'https://example.com/product1');

      final json = productList.toJson();

      expect(json, {
        'id': '1',
        'name': 'Product 1',
        'url': 'https://example.com/product1',
      });
    });
  });
}
