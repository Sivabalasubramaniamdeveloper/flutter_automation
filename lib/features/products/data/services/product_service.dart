import 'package:dio/dio.dart';
import 'package:flutter_automation/core/constants/api_constants.dart';
import 'package:flutter_automation/core/constants/app_strings.dart';
import '../../../../core/network/custom_api_call.dart';

class ProductService {
  CustomApiCallService customApiCallService = CustomApiCallService();

  Future<Response<dynamic>> fetchProductsRaw(String token) async {
    try {
      final response = await customApiCallService.makeApiRequest(
        method: AppStrings.getAPI,
        token: token,
        url: APIConstants.demoAPI,
      );
      return response;
    } on DioException catch (e) {
      throw Exception('${AppStrings.failedToLoad} ${e.error}');
    }
  }
}
