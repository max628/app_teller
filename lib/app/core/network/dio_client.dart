import 'dart:io';

import 'package:connectivity_plus/connectivity_plus.dart';
import 'package:dio/dio.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:logger/logger.dart';

import '/app/models/response_model.dart';
import '/app/services/storage_service.dart';
import 'pretty_dio_logger.dart';

mixin class DioClient {
  static final String baseUrl = dotenv.get('BASE_URL');

  Dio? _instance;

  static const int _maxLineWidth = 80;
  final _prettyDioLogger = PrettyDioLogger(
    requestHeader: true,
    requestBody: true,
    responseBody: kDebugMode,
    responseHeader: false,
    error: true,
    compact: true,
    maxWidth: _maxLineWidth,
  );

  final BaseOptions _options = BaseOptions(
    baseUrl: baseUrl,
    connectTimeout: const Duration(seconds: 10),
    receiveTimeout: const Duration(seconds: 20),
    queryParameters: {"format": "json"},
    headers: {"Accept": "application/json"},
  );

  Dio get httpDio {
    if (_instance == null) {
      _instance = Dio(_options);

      if (kDebugMode) {
        _instance!.interceptors.add(_prettyDioLogger);
      }

      return _instance!;
    } else {
      _instance!.interceptors.clear();
      if (kDebugMode) {
        _instance!.interceptors.add(_prettyDioLogger);
      }

      return _instance!;
    }
  }

  ///returns a Dio client with Access token in header
  Dio get tokenClient {
    _addInterceptors();

    return _instance!;
  }

  ///returns a Dio client with Access token in header
  ///Also adds a token refresh interceptor which retry the request when it's unauthorized
  Dio get dioWithHeaderToken {
    _addInterceptors();

    return _instance!;
  }

  _addInterceptors() {
    _instance ??= httpDio;
    _instance!.interceptors.clear();
    _instance!.interceptors.add(InterceptorsWrapper(
      onRequest: (options, handler) async {
        // Añadir el token al encabezado de la solicitud
        // ignore: prefer_interpolation_to_compose_strings
        String? accessToken = await StorageService.getAccessToken();
        options.headers.addAll({'Authorization': 'Bearer $accessToken'});
        return handler.next(options); // Continuar con la solicitud
      },
      onResponse: (response, handler) {
        // Manejar la respuesta
        return handler.next(response); // Continuar con la respuesta
      },
      onError: (DioException e, handler) {
        // Manejar errores
        return handler.next(e); // Continuar con el error
      },
    ));
    
    if (kDebugMode) {
      _instance!.interceptors.add(_prettyDioLogger);
    }
  }

  Future<ResponseModel> request(
    String url,
    String method,
    Object? params,
  ) async {
    final connectivityResult = await (Connectivity().checkConnectivity());

    if (!connectivityResult.contains(ConnectivityResult.none)) {
      try {
        final dioResponse = await tokenClient.request(
          url,
          data: params,
          options: Options(method: method),
        );

        ResponseModel responseModel = ResponseModel(
          true,
          dioResponse.statusMessage!,
          dioResponse.statusCode!,
          dioResponse.data,
        );

        return responseModel;
      } on DioException catch (error) {
        String errorMessage = error.message ?? "Service Unavailable";
        switch (error.type) {
          case DioExceptionType.connectionTimeout:
            errorMessage = "Connection Timeout";
            break;
          case DioExceptionType.badCertificate:
            errorMessage = "Bad Certificate";
            break;
          case DioExceptionType.sendTimeout:
            errorMessage = "Send Timeout";
            break;
          case DioExceptionType.receiveTimeout:
            errorMessage = "Receive Timeout";
            break;
          case DioExceptionType.badResponse:
            errorMessage = 'Error in response';
            break;
          case DioExceptionType.cancel:
            errorMessage = "Request Cancelled";
            break;
          default:
        }

        return ResponseModel(
          false,
          errorMessage,
          error.response?.statusCode ?? HttpStatus.serviceUnavailable,
          error.response?.data ?? {"message": "Something went wrong."},
        );
      } catch (e) {
        Logger().e('response code : ${e.toString()}');
        return ResponseModel(false, 'Something Went Wrong', 499, null);
      }
    } else {
      return ResponseModel(false, 'No Internet Connection', 503, null);
    }
  }
}
