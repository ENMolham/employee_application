import 'package:connectivity_plus/connectivity_plus.dart';
import 'package:dio/dio.dart';
import 'package:employee_application/Core/utils/shared_preference_utils.dart';
import 'package:injectable/injectable.dart';

@module
abstract class ThirdPartyInjection {
  @singleton
  Dio get dio => Dio();

  @singleton
  Connectivity get connectivity => Connectivity();

  @singleton
  SharedPreferencesUtils get sharedPreferencesUtils => SharedPreferencesUtils();
}
