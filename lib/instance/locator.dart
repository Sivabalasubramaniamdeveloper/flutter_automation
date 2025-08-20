import 'package:connectivity_plus/connectivity_plus.dart';
import 'package:get_it/get_it.dart';
import 'package:logger/logger.dart';
import 'package:shared_preferences/shared_preferences.dart';
import '../features/products/data/repositories/product_repository.dart';
import '../features/products/data/services/product_service.dart';

final GetIt getIt = GetIt.instance;

Future<void> setupLocator() async {
  getIt.registerSingletonAsync<SharedPreferences>(
    () async => await SharedPreferences.getInstance(),
  );

  getIt.registerLazySingleton<Connectivity>(() => Connectivity());
  getIt.registerLazySingleton<Logger>(() => Logger());

  //==================================
  // Register Services
  //==================================

  getIt.registerLazySingleton<ProductServiceImp>(() => ProductServiceImp());

  //==================================
  // Register Repositories
  //==================================

  getIt.registerLazySingleton<ProductRepository>(
    () => ProductRepositoryImp(getIt<ProductServiceImp>()),
  );
  await getIt.allReady();
}
