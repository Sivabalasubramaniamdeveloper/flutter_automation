import 'package:flutter_automation/features/products/data/services/product_service.dart';
import 'package:get_it/get_it.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'features/products/data/repositories/product_repository.dart';

final GetIt getIt = GetIt.instance;

Future<void> setupLocator() async {
  getIt.registerSingletonAsync<SharedPreferences>(
    () async => await SharedPreferences.getInstance(),
  );
  //==================================
  // Register Services
  //==================================
  getIt.registerLazySingleton<ProductServiceImp>(() => ProductServiceImp());

  //==================================
  // Register Repositories
  //==================================
  getIt.registerLazySingleton<ProductRepositoryImp>(
    () => ProductRepositoryImp(getIt<ProductServiceImp>()),
  );
}
