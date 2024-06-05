import 'dart:async';

import 'package:dio/dio.dart';
import 'package:flutter/foundation.dart';
import 'package:fpdart/fpdart.dart';
import 'package:injectable/injectable.dart';

import '../../constants/failure_messages.dart';
import '../../core/models/failure/failure.dart';
import '../../services/network/network_info.dart';
import 'network_service.dart';

@LazySingleton(as: NetworkService)
final class NetworkServiceImpl implements NetworkService {
  final NetworkInfo networkInfo;
  final Dio _dio;

  NetworkServiceImpl(this._dio, {required this.networkInfo});

  @override
  void setBaseUrl(String baseUrl) {
    _dio.options.baseUrl = baseUrl;
  }

  @override
  void setHeader(String key, String value) {
    _dio.options.headers[key] = value;
  }

  @override
  void setHeaders(Map<String, String> headers) {
    _dio.options.headers.addAll(headers);
  }

  @override
  void setToken(String token) {
    _dio.options.headers["Authorization"] = 'Bearer $token';
  }

  @override
  void clearToken() {
    _dio.options.headers.remove("Authorization");
  }

  @override
  Future<Either<Failure, Response<Map<String, dynamic>>>> get(
    String url, {
    Map<String, dynamic>? queryParameters,
  }) async =>
      _tryCatch(() => _dio.get(url, queryParameters: queryParameters));

  @override
  Future<Either<Failure, Response<Map<String, dynamic>>>> post(
    String url, {
    dynamic data,
    Map<String, dynamic>? optionalHeaders,
    Map<String, dynamic>? queryParameters,
  }) {
    return _tryCatch(
      () async => _dio.post(
        url,
        data: data,
        queryParameters: queryParameters,
        options: Options(
          headers: Map.of(_dio.options.headers)..addAll(optionalHeaders ?? {}),
        ),
      ),
    );
  }

  @override
  Future<Either<Failure, Response<Map<String, dynamic>>>> put(
    String url, {
    dynamic data,
  }) =>
      _tryCatch(() => _dio.put(url, data: data));

  @override
  Future<Either<Failure, Response<Map<String, dynamic>>>> delete(
    String url,
    dynamic data,
  ) =>
      _tryCatch(() => _dio.delete(url, data: data));

  Future<Either<Failure, Response<Map<String, dynamic>>>> _tryCatch<T>(
    AsyncValueGetter<Response<Map<String, dynamic>>> operation,
  ) async {
    try {
      if (await networkInfo.isConnected) {
        return right(await operation());
      } else {
        return left(const Failure.noConnection(noConnectionMessage));
      }
    } on DioException catch (e) {
      if (e.type == DioExceptionType.connectionTimeout) {
        return left(
          const Failure.connectionTimedOut(connectionTimedOutMessage),
        );
      } else {
        return left(const Failure.unknownError(unknownErrorMessage));
      }
    } on TimeoutException {
      return left(
        const Failure.connectionTimedOut(connectionTimedOutMessage),
      );
    } catch (e) {
      return left(const Failure.unknownError(unknownErrorMessage));
    }
  }

  @override
  String getToken() {
    return (_dio.options.headers["Authorization"] as String).substring(7);
  }
}
