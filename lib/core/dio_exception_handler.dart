import 'dart:io';

import 'package:dio/dio.dart';
import 'package:tech_test_designli/core/custom_exception.dart';

class DioExceptionHandler {
  static CustomException handle(DioException e) {
    switch (e.type) {
      case DioExceptionType.connectionTimeout:
      case DioExceptionType.sendTimeout:
      case DioExceptionType.receiveTimeout:
        return CustomException(
          'Connection timed out. Please check your internet connection.',
        );
      case DioExceptionType.badResponse:
        return _handleBadResponse(e.response?.statusCode);
      case DioExceptionType.cancel:
        return CustomException('Request was cancelled');
      case DioExceptionType.unknown:
        if (e.error is SocketException) {
          return CustomException(
            'No internet connection. Please check your network.',
          );
        }
        return CustomException('An unexpected error occurred: ${e.message}');
      case DioExceptionType.badCertificate:
        return CustomException('Bad SSL certificate');
      case DioExceptionType.connectionError:
        return CustomException('Connection error');
    }
  }

  static CustomException _handleBadResponse(int? statusCode) {
    switch (statusCode) {
      case 400:
        return CustomException('Bad request. Please check your input.');
      case 401:
        return CustomException('Unauthorized. Please check your API token.');
      case 403:
        return CustomException(
          "Forbidden. You don't have permission to access this resource.",
        );
      case 404:
        return CustomException('Resource not found. Please check the URL.');
      case 429:
        return CustomException('Too many requests. Please try again later.');
      case 500:
      case 502:
      case 503:
      case 504:
        return CustomException('Server error. Please try again later.');
      default:
        return CustomException(
          'An error occurred with status code: $statusCode',
        );
    }
  }
}
