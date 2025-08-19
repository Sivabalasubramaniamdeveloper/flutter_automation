import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:internet_connection_checker_plus/internet_connection_checker_plus.dart';
import 'package:provider/single_child_widget.dart';
import 'package:connectivity_plus/connectivity_plus.dart';
import 'core/network/internet_connectivity.dart';
import 'features/products/data/cubit/product_cubit.dart';
import 'features/products/data/repositories/product_repository.dart';
import 'instance/locator.dart';

List<SingleChildWidget> getAppProviders() {
  final productRepository = getIt<ProductRepository>();

  return [
    // Repositories
    RepositoryProvider.value(value: productRepository),

    // Core Cubits
    BlocProvider(create: (_) => ProductCubit(productRepository)),
    BlocProvider(create: (_) => ConnectivityCubit(InternetConnection())),
  ];
}
