// ignore_for_file: strict_top_level_inference

import 'dart:convert';
import 'dart:io';
import 'package:dio/dio.dart';
import "package:freezed_annotation/freezed_annotation.dart";
part 'network_exceptions.freezed.dart';

@freezed
abstract class NetworkExceptions with _$NetworkExceptions implements Exception {
  const factory NetworkExceptions.requestCancelled() = RequestCancelled;
  const factory NetworkExceptions.canceledByUser() = CanceledByUser;
  const factory NetworkExceptions.firebasePlatformException() =
      FirebasePlatformException;

  const factory NetworkExceptions.badRequest(String reason) = BadRequest;
  const factory NetworkExceptions.unauthorizedRequest(String reason) =
      UnauthorizedRequest;
  const factory NetworkExceptions.forbidden() = Forbidden;

  const factory NetworkExceptions.notFound(String reason) = NotFound;

  const factory NetworkExceptions.methodNotAllowed() = MethodNotAllowed;

  const factory NetworkExceptions.notAcceptable() = NotAcceptable;

  const factory NetworkExceptions.requestTimeout() = RequestTimeout;

  const factory NetworkExceptions.sendTimeout() = SendTimeout;

  const factory NetworkExceptions.unprocessableEntity(String reason) =
      UnprocessableEntity;

  const factory NetworkExceptions.conflict() = Conflict;

  const factory NetworkExceptions.internalServerError() = InternalServerError;

  const factory NetworkExceptions.notImplemented() = NotImplemented;

  const factory NetworkExceptions.serviceUnavailable() = ServiceUnavailable;

  const factory NetworkExceptions.noInternetConnection() = NoInternetConnection;

  const factory NetworkExceptions.formatException() = FormatException;

  const factory NetworkExceptions.unableToProcess() = UnableToProcess;

  const factory NetworkExceptions.defaultError(String error) = DefaultError;

  const factory NetworkExceptions.unexpectedError() = UnexpectedError;

  static NetworkExceptions handleResponse(Response? response) {
    int statusCode = response?.statusCode ?? 0;
    String? message;
    if (response?.data is Map<String, dynamic>) {
      message = response!.data['message'];
    } else if (response?.data is String) {
      try {
        final jsonData = json.decode(response!.data);
        message = jsonData['message'];
      } catch (_) {
        message = response!.data.toString();
      }
    }

    switch (statusCode) {
      case 400:
        return NetworkExceptions.badRequest(message ?? "إرسال غير جيد");
      case 401:
        return NetworkExceptions.unauthorizedRequest(
          message ?? 'لا يوجد حساب بهذا الأسم',
        );
      case 403:
        return const NetworkExceptions.forbidden();

      case 404:
        return NetworkExceptions.notFound(message ?? 'لا يوجد');
      case 405:
        return const NetworkExceptions.methodNotAllowed();
      case 409:
        return const NetworkExceptions.conflict();
      case 408:
        return const NetworkExceptions.requestTimeout();
      case 422:
        return NetworkExceptions.unprocessableEntity(
          message ?? 'بيانات غير صالحة',
        );
      case 500:
        return const NetworkExceptions.internalServerError();
      case 503:
        return const NetworkExceptions.serviceUnavailable();
      default:
        int responseCode = statusCode;
        return NetworkExceptions.defaultError(
          'Received invalid status code: $responseCode',
        );
    }
  }

  static NetworkExceptions getException(error) {
    if (error is Exception) {
      try {
        NetworkExceptions networkExceptions;

        if (error is DioException) {
          switch (error.type) {
            case DioExceptionType.cancel:
              networkExceptions = const NetworkExceptions.requestCancelled();
              break;
            case DioExceptionType.connectionTimeout:
              networkExceptions = const NetworkExceptions.requestTimeout();
              break;
            case DioExceptionType.unknown:
              networkExceptions =
                  const NetworkExceptions.noInternetConnection();
              break;
            case DioExceptionType.receiveTimeout:
              networkExceptions = const NetworkExceptions.sendTimeout();
              break;
            case DioExceptionType.badResponse:
              networkExceptions = NetworkExceptions.handleResponse(
                error.response,
              );
              break;

            case DioExceptionType.sendTimeout:
              networkExceptions = const NetworkExceptions.sendTimeout();
              break;
            case DioExceptionType.badCertificate:
              networkExceptions = const NetworkExceptions.unableToProcess();
              break;
            case DioExceptionType.connectionError:
              networkExceptions =
                  const NetworkExceptions.noInternetConnection();
              break;
          }
        } else if (error is SocketException) {
          networkExceptions = const NetworkExceptions.noInternetConnection();
        } else {
          networkExceptions = const NetworkExceptions.unexpectedError();
        }
        return networkExceptions;
      } on FormatException {
        return const NetworkExceptions.formatException();
      } catch (_) {
        return const NetworkExceptions.unexpectedError();
      }
    } else {
      if (error.toString().contains('is not a subtype of')) {
        return const NetworkExceptions.unableToProcess();
      } else {
        return const NetworkExceptions.unexpectedError();
      }
    }
  }

  static String getErrorMessage(NetworkExceptions networkExceptions) {
    String errorMessage = '';
    networkExceptions.when(
      notImplemented: () {
        errorMessage = 'لم يتم تنفيذها';
      },
      requestCancelled: () {
        errorMessage = 'تم إلغاء الطلب';
      },
      internalServerError: () {
        errorMessage = 'خطأ في الخادم الداخلي';
      },
      notFound: (String reason) {
        errorMessage = reason;
      },
      serviceUnavailable: () {
        errorMessage = 'الخدمة غير متوفرة';
      },
      methodNotAllowed: () {
        errorMessage = 'الطريقة غير مسموحة';
      },
      badRequest: (String message) {
        errorMessage = message;
      },
      unauthorizedRequest: (String error) {
        errorMessage = error;
      },
      unprocessableEntity: (String error) {
        errorMessage = error;
      },
      unexpectedError: () {
        errorMessage = 'حدث خطأ غير متوقع';
      },
      requestTimeout: () {
        errorMessage = 'انتهت مهلة طلب الاتصال';
      },
      noInternetConnection: () {
        errorMessage = 'لا يوجد اتصال بالإنترنت';
      },
      conflict: () {
        errorMessage = 'خطأ بسبب الأزدحام';
      },
      sendTimeout: () {
        errorMessage = 'إرسال المهلة فيما يتعلق بخادم API';
      },
      unableToProcess: () {
        errorMessage = 'غير قادر على معالجة البيانات';
      },
      defaultError: (String error) {
        errorMessage = error;
      },
      formatException: () {
        errorMessage = 'حدث خطأ غير متوقع';
      },
      notAcceptable: () {
        errorMessage = 'غير مقبول به';
      },
      forbidden: () {
        errorMessage = 'محظور';
      },
      firebasePlatformException: () {
        errorMessage = 'خطأ في المنصة';
      },
      canceledByUser: () {
        errorMessage = 'تم الإلغاء بواسطة المستخدم';
      },
    );
    return errorMessage;
  }
}
