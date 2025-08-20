import 'package:flutter_automation/core/logger/app_logger.dart';
import '../models/product_model.dart';
import '../services/product_service.dart';

abstract class ProductRepository {
  Future<List<Product>> getProducts();
}

class ProductRepositoryImp extends ProductRepository {
  final ProductService _service;

  ProductRepositoryImp(this._service);

  @override
  Future<List<Product>> getProducts() async {
    try {
      final response = await _service.fetchProductsRaw('s');
      final responseData = response.data;

      if (responseData == null || responseData['products'] == null) {
        throw Exception("Invalid API Response");
      }

      return (responseData['products'] as List)
          .map((e) => Product.fromMap(e))
          .toList();
    } catch (e) {
      AppLogger.e("Repository Error: $e","Repository Error:");
      throw Exception("Failed to fetch products: $e");
    }
  }
}

