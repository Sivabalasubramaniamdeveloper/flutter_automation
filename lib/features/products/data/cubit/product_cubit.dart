import 'package:dio/dio.dart';
import 'package:flutter_automation/core/logger/app_logger.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import '../repositories/product_repository.dart';
import 'product_state.dart';

class ProductCubit extends Cubit<ProductState> {
  final ProductRepository repository;

  ProductCubit(this.repository) : super(ProductInitial());



  Future<void> fetchProducts() async {
    emit(ProductLoading());
    try {
      final products = await repository.getProducts();
      emit(ProductLoaded(products));
    } catch (e) {
      emit(ProductError(e.toString()));  // 🔥 Ensure this fires
    }
  }
}

