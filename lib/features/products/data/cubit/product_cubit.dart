import 'package:dio/dio.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import '../repositories/product_repository.dart';
import 'product_state.dart';

class ProductCubit extends Cubit<ProductState> {
  final ProductRepository _repo;
  ProductCubit(this._repo) : super(ProductInitial());
  CancelToken? cancelToken;
  Future<void> fetchProducts() async {
    cancelToken?.cancel("Cancelled due to new request");
    cancelToken = CancelToken();
    print("cancelToken");
    print(cancelToken);
    print(cancelToken?.whenCancel);
    print(cancelToken?.cancelError);

    emit(const ProductLoading());
    try {
      final products = await _repo.getProducts();
      emit(ProductLoaded(products));
    } on DioException catch (e) {
      if (CancelToken.isCancel(e)) {
        print("Request cancelled: $e");
      } else {
        emit(ProductError(e.toString()));
      }

      rethrow;
    }
  }
}
