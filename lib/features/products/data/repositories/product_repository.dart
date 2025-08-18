import 'dart:convert';
import '../models/product_model.dart';
import '../services/product_service.dart';

abstract class ProductRepository {
  Future<List<Product>> getProducts();
}

class ProductRepositoryImp extends ProductRepository {
  final ProductServiceImp _service;
  ProductRepositoryImp(this._service);

  @override
  Future<List<Product>> getProducts() async {
    final response = await _service.fetchProductsRaw('s');
    print("sssssssssssssssss");
    print(response);
    final responseData = json.decode(response.toString());
    final productsList = (responseData['products'] as List)
        .map((e) => Product.fromMap(e))
        .toList();

    return productsList;
  }
}
