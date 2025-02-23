// This file is automatically generated, so please do not edit it.
// @generated by `flutter_rust_bridge`@ 2.7.0.

// ignore_for_file: invalid_use_of_internal_member, unused_import, unnecessary_import

import '../../frb_generated.dart';
import '../../lib.dart';
import 'client.dart';
import 'error.dart';
import 'package:flutter_rust_bridge/flutter_rust_bridge_for_generated.dart';
import 'package:freezed_annotation/freezed_annotation.dart' hide protected;
part 'http.freezed.dart';

// These functions are ignored because they are not marked as `pub`: `build_cancel_tokens`, `from_version`, `header_to_vec`, `make_http_request_helper`, `make_http_request_receive_stream_inner`, `register_client_internal`, `to_method`
// These types are ignored because they are not used by any `pub` functions: `HttpExpectBody`, `RequestCancelTokens`
// These function are ignored because they are on traits that is not defined in current crate (put an empty `#[frb]` on it to unignore): `clone`, `clone`, `fmt`

Future<RequestClient> registerClient({required ClientSettings settings}) =>
    RustLib.instance.api.crateApiRhttpHttpRegisterClient(settings: settings);

RequestClient registerClientSync({required ClientSettings settings}) => RustLib
    .instance
    .api
    .crateApiRhttpHttpRegisterClientSync(settings: settings);

Future<void> cancelRunningRequests({required RequestClient client}) =>
    RustLib.instance.api.crateApiRhttpHttpCancelRunningRequests(client: client);

Stream<Uint8List> makeHttpRequestReceiveStream({
  RequestClient? client,
  ClientSettings? settings,
  required HttpMethod method,
  required String url,
  List<(String, String)>? query,
  HttpHeaders? headers,
  Uint8List? body,
  required FutureOr<void> Function(HttpResponse) onResponse,
  required FutureOr<void> Function(RhttpError) onError,
  required FutureOr<void> Function(CancellationToken) onCancelToken,
  required bool cancelable,
}) => RustLib.instance.api.crateApiRhttpHttpMakeHttpRequestReceiveStream(
  client: client,
  settings: settings,
  method: method,
  url: url,
  query: query,
  headers: headers,
  body: body,
  onResponse: onResponse,
  onError: onError,
  onCancelToken: onCancelToken,
  cancelable: cancelable,
);

Future<void> cancelRequest({required CancellationToken token}) =>
    RustLib.instance.api.crateApiRhttpHttpCancelRequest(token: token);

@freezed
sealed class HttpHeaders with _$HttpHeaders {
  const HttpHeaders._();

  const factory HttpHeaders.map(Map<String, String> field0) = HttpHeaders_Map;
  const factory HttpHeaders.list(List<(String, String)> field0) =
      HttpHeaders_List;
}

enum HttpMethod {
  options,
  get_,
  post,
  put,
  delete,
  head,
  trace,
  connect,
  patch,
}

class HttpResponse {
  final List<(String, String)> headers;
  final HttpVersion version;
  final int statusCode;
  final HttpResponseBody body;

  const HttpResponse({
    required this.headers,
    required this.version,
    required this.statusCode,
    required this.body,
  });

  @override
  int get hashCode =>
      headers.hashCode ^ version.hashCode ^ statusCode.hashCode ^ body.hashCode;

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is HttpResponse &&
          runtimeType == other.runtimeType &&
          headers == other.headers &&
          version == other.version &&
          statusCode == other.statusCode &&
          body == other.body;
}

@freezed
sealed class HttpResponseBody with _$HttpResponseBody {
  const HttpResponseBody._();

  const factory HttpResponseBody.text(String field0) = HttpResponseBody_Text;
  const factory HttpResponseBody.bytes(Uint8List field0) =
      HttpResponseBody_Bytes;
  const factory HttpResponseBody.stream() = HttpResponseBody_Stream;
}

enum HttpVersion { http09, http10, http11, other }
