import 'dart:convert';

import '../models/product_model.dart';
import '../services/product_service.dart';

class ProductRepository {
  final ProductService _service;
  ProductRepository(this._service);

  Future<List<Product>> getProducts() async {
    final response = await _service.fetchProductsRaw('s');
    final responseData = json.decode(response.toString());
    final productsList = (responseData['products'] as List)
        .map((e) => Product.fromMap(e))
        .toList();

    return productsList;
  }


}
