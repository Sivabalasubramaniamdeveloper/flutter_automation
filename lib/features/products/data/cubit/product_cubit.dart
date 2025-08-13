import 'package:flutter_bloc/flutter_bloc.dart';
import '../repositories/product_repository.dart';
import 'product_state.dart';

class ProductCubit extends Cubit<ProductState> {
  final ProductRepository _repo;
  ProductCubit(this._repo) : super( ProductInitial());

  Future<void> fetchProducts() async {
    emit(const ProductLoading());
    try {
      final products = await _repo.getProducts();
      emit(ProductLoaded(products));
    } catch (e) {
      emit(ProductError(e.toString()));
      rethrow;
    }
  }
}
