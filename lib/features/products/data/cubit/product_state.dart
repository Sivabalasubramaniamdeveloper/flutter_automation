import 'package:equatable/equatable.dart';

import '../models/product_model.dart';

abstract class ProductState extends Equatable {
  @override
  List<Object?> get props => [];
}

class ProductInitialState extends ProductState {
  @override
  List<Object?> get props => [];
}

class ProductLoadingState extends ProductState {
  @override
  List<Object?> get props => [];
}

class ProductSuccessState extends ProductState {
  final ProductModel products;
  ProductSuccessState({required this.products});
  @override
  List<Object?> get props => [products];
}

class ProductErrorState extends ProductState {
  final String message;

  ProductErrorState({required this.message});

  @override
  List<Object?> get props => [message];
}
