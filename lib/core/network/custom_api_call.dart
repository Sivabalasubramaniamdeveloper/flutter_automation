import 'package:dio/dio.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:shared_preferences/shared_preferences.dart';
import '../utils/toast_helper.dart';
import 'alice.dart';
import 'package:flutter_timezone/flutter_timezone.dart';

class CustomApiCallService {
  final Dio dio = dioProvider.dio;

  Future<Map<String, String>> _prepareHeaders(String? token) async {
    final String currentTimeZone = await FlutterTimezone.getLocalTimezone();
    return {
      "Content-Type": "application/json",
      "TIMEZONE": currentTimeZone,
      if (token != '') 'Authorization': 'Bearer $token',
      if (token == '') 'key': 'x-Client-Type',
      if (token == '') 'value': 'mobile',
    };
  }

  Future<Response<dynamic>> makeApiRequest({
    required String method,
    required String token,
    required String url,
    Map<String, dynamic>? data,
  }) async {
    try {
      final headers = await _prepareHeaders(token);
      Response response;
      switch (method) {
        case 'GET':
          response = await dio.get(url, options: Options(headers: headers));
          break;
        case 'POST':
          response = await dio.post(
            url,
            data: data,
            options: Options(headers: headers),
          );
          break;
        case 'PUT':
          response = await dio.put(
            url,
            data: data,
            options: Options(headers: headers),
          );
          break;
        case 'PATCH':
          response = await dio.patch(
            url,
            data: data,
            options: Options(headers: headers),
          );
          break;
        case 'DELETE':
          response = await dio.delete(
            url,
            data: data,
            options: Options(headers: headers),
          );
          break;
        default:
          throw Exception('Invalid HTTP method');
      }

      return response;
    } on DioException catch (e) {
      if (e.response?.statusCode == 401) {
        final context = dioProvider.navigatorKey?.currentContext;
        if (context != null) {
          showCupertinoDialog(
            context: context,
            barrierDismissible: false,
            builder: (BuildContext context) {
              return PopScope(
                canPop: false,
                child: CupertinoAlertDialog(
                  title: Text(
                    'Session Expired',
                    style: TextStyle(fontWeight: FontWeight.bold),
                  ),
                  content: Padding(
                    padding: const EdgeInsets.only(top: 8.0).r,
                    child: Text(
                      'Your session has expired. Please login again to continue.',
                      style: TextStyle(fontSize: 16.sp),
                    ),
                  ),
                  actions: <Widget>[
                    CupertinoDialogAction(
                      onPressed: () async {
                        final storedData =
                            await SharedPreferences.getInstance();
                        await storedData.clear();
                        // await dioProvider.navigatorKey?.currentState
                        //     ?.pushAndRemoveUntil(
                        //   MaterialPageRoute(
                        //     builder: (context) => LandingScreen(),
                        //   ),
                        //       (route) => false,
                        // );
                      },
                      isDestructiveAction: true,
                      child: Text(
                        'Continue',
                        style: TextStyle(
                          fontWeight: FontWeight.bold,
                          fontSize: 14.sp,
                        ),
                      ),
                    ),
                  ],
                ),
              );
            },
          );
        }
        rethrow;
      } else if (e.response?.statusCode == 504 ||
          e.response?.statusCode == 500) {
        showErrorToast('Something went wrong, please try again.');
        rethrow;
      } else if (e.response?.statusCode == 403) {
        await showErrorToast(
          e.response?.data['error'] ?? e.response?.data['message'],
        );
        final context = dioProvider.navigatorKey?.currentContext;
        if (context != null) {
          showCupertinoDialog(
            context: context,
            barrierDismissible: false,
            builder: (BuildContext context) {
              return PopScope(
                canPop: false,
                child: CupertinoAlertDialog(
                  title: Text(
                    'Forbidden',
                    style: TextStyle(fontWeight: FontWeight.bold),
                  ),
                  content: Padding(
                    padding: const EdgeInsets.only(top: 8.0).r,
                    child: Text(
                      e.response?.data['message'] ??
                          'Your account is currently deactivated. Please contact Admin to activate.',
                      style: TextStyle(fontSize: 16.sp),
                    ),
                  ),
                  actions: <Widget>[
                    CupertinoDialogAction(
                      onPressed: () async {},
                      isDestructiveAction: true,
                      child: Text(
                        'Close',
                        style: TextStyle(
                          fontWeight: FontWeight.bold,
                          fontSize: 14.sp,
                        ),
                      ),
                    ),
                  ],
                ),
              );
            },
          );
        }

        rethrow;
      } else {
        String? errorMessage =
            e.response?.data['error'] ?? e.response?.data['message'];
        if (errorMessage != null &&
            errorMessage != "Invalid mail format" &&
            errorMessage != "Invalid mobile number") {
          showErrorToast(errorMessage);
        }
        rethrow;
      }
    }
  }

  // Future<Refresh> userRefreshLogin(String token) async {
  //   try {
  //     Response response = await makeApiRequest(
  //       method: 'POST',
  //       token: token,
  //       url: ApiLinks.refreshToken,
  //     );
  //     Refresh refreshData = Refresh.fromJson(response.data);
  //     await SecureStorage().writeSecureData(
  //       "expiresInTimeStampValue",
  //       refreshData.refreshData!.expiresIn.toString(),
  //     );
  //     await SecureStorage().writeSecureData(
  //       "loginToken",
  //       refreshData.refreshData!.token!,
  //     );
  //     return response.data = Refresh.fromJson(response.data);
  //   } catch (error) {
  //     throw Exception('Failed to login: $error');
  //   }
  // }
}
