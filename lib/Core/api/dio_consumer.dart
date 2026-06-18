import 'dart:convert';
import 'package:dio/dio.dart';
import 'package:employee_application/Core/api/api_consumer.dart';
import 'package:employee_application/Core/api/end_points.dart';
import 'package:employee_application/Core/api/logging_interceptor.dart';
import 'package:employee_application/Core/constant/strings_constants.dart';
import 'package:employee_application/Core/utils/shared_preference_utils.dart';
import 'package:employee_application/injection.dart';
import 'package:flutter/foundation.dart';
import 'package:injectable/injectable.dart';

@Singleton(as: ApiConsumer)
class DioConsumer implements ApiConsumer {
  DioConsumer(this._client) {
    _client.options
      ..sendTimeout = const Duration(seconds: 10)
      ..connectTimeout = const Duration(seconds: 30)
      ..receiveTimeout = const Duration(seconds: 60)
      ..baseUrl = EndPoints.baseUrl
      ..responseType = ResponseType.plain
      ..followRedirects = true;
    if (kDebugMode) {
      _client.interceptors.add(getIt<LoggingInterceptor>());
    }
  }
  final Dio _client;
  late Map<String, String> _headers;

  void setHeaders() async {
    _headers = {
      StringsConstants.accept: StringsConstants.applicationJson,
      StringsConstants.contentType: StringsConstants.applicationJson,
      StringsConstants.authorization:
          "Bearer ${SharedPreferencesUtils().getToken()}",
    };
  }

  @override
  Future get(
    String path, {
    Map<String, dynamic>? queryParameters,
    CancelToken? cancelToken,
  }) async {
    setHeaders();

    try {
      final Response response = await _client.get(
        path,
        queryParameters: queryParameters,
        cancelToken: cancelToken,
        options: Options(headers: _headers),
      );
      return _handleResponseAsJson(response);
    } catch (error) {
      rethrow;
    }
  }

  @override
  Future post(
    String path, {
    dynamic body,
    String? token,
    FormData? formData,
    ResponseType? responseType,
    Map<String, dynamic>? queryParameters,
  }) async {
    setHeaders();

    try {
      final Response response = await _client.post(
        path,
        queryParameters: queryParameters,
        options: Options(
          headers: _headers,
          contentType: formData == null
              ? StringsConstants.jsonContentType
              : null,
          responseType: responseType,
        ),
        data: formData ?? body,
      );
      return _handleResponseAsJson(response);
    } catch (error) {
      rethrow;
    }
  }

  @override
  Future put(
    String path, {
    Map<String, dynamic>? body,
    Map<String, dynamic>? queryParameters,
  }) async {
    setHeaders();
    try {
      final Response response = await _client.put(
        path,
        queryParameters: queryParameters,
        data: body,
        options: Options(
          headers: _headers,
          contentType: StringsConstants.jsonContentType,
        ),
      );
      return _handleResponseAsJson(response);
    } catch (error) {
      rethrow;
    }
  }

  dynamic _handleResponseAsJson(Response response) {
    final responseJson = jsonDecode(response.data.toString());
    return responseJson;
  }

  @override
  Future delete(
    String path, {
    Map<String, dynamic>? body,
    Map<String, dynamic>? queryParameters,
  }) async {
    setHeaders();

    try {
      final Response response = await _client.delete(
        path,
        data: body,
        options: Options(
          headers: _headers,
          contentType: StringsConstants.jsonContentType,
        ),
      );
      return _handleResponseAsJson(response);
    } catch (error) {
      rethrow;
    }
  }
}
