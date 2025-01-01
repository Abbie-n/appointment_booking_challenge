import 'dart:convert';

import 'package:shelf/shelf.dart';

class ApiResponse {
  static const _contentType = {'content-type': 'application/json'};

  static Map<String, dynamic> _wrapResponse({
    dynamic data,
    String? error,
    Map<String, dynamic>? meta,
  }) {
    final response = <String, dynamic>{};

    if (data != null) response['data'] = data;
    if (error != null) response['error'] = error;

    return response;
  }

  static Response ok(
    dynamic data, {
    Map<String, dynamic>? meta,
    Map<String, String>? headers,
  }) {
    return Response.ok(
      jsonEncode(_wrapResponse(data: data, meta: meta)),
      headers: {..._contentType, ...?headers},
    );
  }

  static Response error(
    int statusCode,
    String message, {
    Map<String, dynamic>? meta,
    Map<String, String>? headers,
  }) {
    return Response(
      statusCode,
      body: json.encode(_wrapResponse(error: message, meta: meta)),
      headers: {..._contentType, ...?headers},
    );
  }

  static Response badRequest(
    String message, {
    Map<String, dynamic>? meta,
    Map<String, String>? headers,
  }) {
    return error(400, message, meta: meta, headers: headers);
  }

  static Response notFound(
    String message, {
    Map<String, dynamic>? meta,
    Map<String, String>? headers,
  }) {
    return error(404, message, meta: meta, headers: headers);
  }

  static Response conflict(
    String message, {
    Map<String, dynamic>? meta,
    Map<String, String>? headers,
  }) {
    return error(409, message, meta: meta, headers: headers);
  }

  static Response validationError(
    String message, {
    Map<String, dynamic>? meta,
    Map<String, String>? headers,
  }) {
    return error(422, message, meta: meta, headers: headers);
  }

  static Response serverError(
    String message, {
    Map<String, dynamic>? meta,
    Map<String, String>? headers,
  }) {
    return error(500, message, meta: meta, headers: headers);
  }
}
