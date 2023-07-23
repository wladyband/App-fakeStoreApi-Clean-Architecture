import 'dart:convert';
import 'dart:developer';
import 'dart:io';

import 'package:fakestoreapi/app/domain/models/HttpMethod.dart';
import 'package:flutter/foundation.dart';
import 'package:http/http.dart';

import '../../domain/either/either.dart';

part 'failure.dart';
part 'logs.dart';
part 'parse_response_body.dart';



class Http {
  Http({
      required Client client,
    required String baseUrl,
  })  : _client = client,

        _baseUrl = baseUrl;

  final Client _client;
  final String _baseUrl;


  Future<Either<HttpFailure, R>> request<R>(
      String path, {
        required R Function(dynamic responseBody) onSuccess,
        HttpMethod method = HttpMethod.get,
        Map<String, String> headers = const {},
        Map<String, String> queryParameters = const {},
        Map<String, dynamic> body = const {},
        bool useApiKey = true,
        String languageCode = 'en',
        Duration timeout = const Duration(seconds: 10),
      }) async {
    Map<String, dynamic> logs = {};
    StackTrace? stackTrace;
    try {
      if (useApiKey) {
        queryParameters = {
          ...queryParameters,
        };
      }
      Uri url = Uri.parse(
        path.startsWith('http') ? path : '$_baseUrl$path',
      );
      if (queryParameters.isNotEmpty) {
        url = url.replace(
          queryParameters: {
            ...queryParameters,
            'language': languageCode,
          },
        );
      }

      headers = {
        'Content-Type': 'application/json',
        ...headers,
      };
      late final Response response;
      final bodyString = jsonEncode(body);
      logs = {
        'url': url.toString(),
        'method': method.name,
        'body': body,
      };

      switch (method) {
        case HttpMethod.get:
          response = await _client
              .get(
            url,
            headers: headers,
          )
              .timeout(timeout);
          break;
        case HttpMethod.post:
          response = await _client
              .post(
            url,
            headers: headers,
            body: bodyString,
          )
              .timeout(timeout);
          break;
        case HttpMethod.patch:
          response = await _client
              .patch(
            url,
            headers: headers,
            body: bodyString,
          )
              .timeout(timeout);
          break;
        case HttpMethod.delete:
          response = await _client
              .delete(
            url,
            headers: headers,
            body: bodyString,
          )
              .timeout(timeout);
          break;
        case HttpMethod.put:
          response = await _client
              .put(
            url,
            headers: headers,
            body: bodyString,
          )
              .timeout(timeout);
          break;
      }

      final statusCode = response.statusCode;
      final responseBody = _parseResponseBody(
        response.body,
      );
      logs = {
        ...logs,
        'startTime': DateTime.now().toString(),
        'statusCode': statusCode,
        'responseBody': responseBody,
      };

      if (statusCode >= 200 && statusCode < 300) {
        return Either.right(
          onSuccess(
            responseBody,
          ),
        );
      }

      return Either.left(
        HttpFailure(
          statusCode: statusCode,
          data: responseBody,
        ),
      );
    } catch (e, s) {
      stackTrace = s;
      logs = {
        ...logs,
        'exception': e.toString(),
      };
      if (e is SocketException || e is ClientException) {
        logs = {
          ...logs,
          'exception': 'NetworkException',
        };
        return Either.left(
          HttpFailure(
            exception: NetworkException(),
          ),
        );
      }

      return Either.left(
        HttpFailure(
          exception: e,
        ),
      );
    } finally {
      logs = {
        ...logs,
        'endTime': DateTime.now().toString(),
      };
      _printLogs(logs, stackTrace);
    }
  }
}