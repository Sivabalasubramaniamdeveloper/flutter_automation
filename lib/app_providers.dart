import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:provider/single_child_widget.dart';
import 'package:connectivity_plus/connectivity_plus.dart';
import 'features/products/data/cubit/product_cubit.dart';
import 'features/products/data/repositories/product_repository.dart';
import 'features/products/data/services/product_service.dart';
import 'locator.dart';

List<SingleChildWidget> getAppProviders(Connectivity? connectivity) {
  final productRepository = getIt<ProductRepository>();

  return [
    // Repositories
    RepositoryProvider.value(value: productRepository),

    /// Core Cubits
    BlocProvider(create: (_) => ProductCubit(productRepository)),
  ];
}
