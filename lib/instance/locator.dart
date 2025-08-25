import 'package:connectivity_plus/connectivity_plus.dart';
import 'package:flutter/cupertino.dart';
import 'package:get_it/get_it.dart';
import 'package:logger/logger.dart';
import '../config/responsive/responsive_config.dart';
import '../core/constants/app_text_styles.dart';
import '../core/utils/secure_storage.dart';
import '../features/products/data/repositories/product_repository.dart';
import '../features/products/data/services/product_service.dart';

final GetIt getIt = GetIt.instance;

Future<void> setupLocator(BuildContext context) async {
  getIt.registerLazySingleton<Connectivity>(() => Connectivity());
  getIt.registerLazySingleton<Logger>(() => Logger());
  getIt.registerLazySingleton<ResponsiveConfig>(
    () => ResponsiveConfig(context),
  );
  getIt.registerLazySingleton<AppTextStyles>(() => AppTextStyles());
  getIt.registerLazySingleton<CustomSecureStorage>(() => CustomSecureStorage());

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
