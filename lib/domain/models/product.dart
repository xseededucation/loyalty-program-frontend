class Product {
  List<ProductList>? productList;

  Product({this.productList});

  Product.fromJson(Map<String, dynamic> json) {
    if (json['productList'] != null) {
      productList = <ProductList>[];
      json['productList'].forEach((v) {
        productList!.add(ProductList.fromJson(v));
      });
    }
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    if (productList != null) {
      data['productList'] = productList!.map((v) => v.toJson()).toList();
    }
    return data;
  }
}

class ProductList {
  String? id;
  String? name;
  String? url;

  ProductList({this.id, this.name, this.url});

  ProductList.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    name = json['name'];
    url = json['url'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['id'] = id;
    data['name'] = name;
    data['url'] = url;
    return data;
  }
}
