// This file is automatically generated, so please do not edit it.
// @generated by `flutter_rust_bridge`@ 2.7.0.

// ignore_for_file: invalid_use_of_internal_member, unused_import, unnecessary_import

import '../../frb_generated.dart';
import 'package:flutter_rust_bridge/flutter_rust_bridge_for_generated.dart';
import 'package:freezed_annotation/freezed_annotation.dart' hide protected;
part 'client.freezed.dart';

// These functions are ignored because they are not marked as `pub`: `create_client`, `new_default`, `new`
// These types are ignored because they are not used by any `pub` functions: `DynamicDnsSettings`, `DynamicResolver`, `StaticResolver`
// These function are ignored because they are on traits that is not defined in current crate (put an empty `#[frb]` on it to unignore): `clone`, `resolve`, `resolve`
// These functions are ignored (category: IgnoreBecauseNotAllowedOwner): `digest_ip`

DnsSettings createStaticResolverSync({required StaticDnsSettings settings}) =>
    RustLib.instance.api.crateApiRhttpClientCreateStaticResolverSync(
      settings: settings,
    );

DnsSettings createDynamicResolverSync({
  required FutureOr<List<String>> Function(String) resolver,
}) => RustLib.instance.api.crateApiRhttpClientCreateDynamicResolverSync(
  resolver: resolver,
);

// Rust type: RustOpaqueMoi<flutter_rust_bridge::for_generated::RustAutoOpaqueInner<DnsSettings>>
abstract class DnsSettings implements RustOpaqueInterface {}

// Rust type: RustOpaqueMoi<flutter_rust_bridge::for_generated::RustAutoOpaqueInner<RequestClient>>
abstract class RequestClient implements RustOpaqueInterface {}

abstract class SocketAddrDigester {
  /// Adds the `FALLBACK_PORT` to the end of the string if it doesn't have a port.
  Future<String> digestIp();
}

class ClientCertificate {
  final Uint8List certificate;
  final Uint8List privateKey;

  const ClientCertificate({
    required this.certificate,
    required this.privateKey,
  });

  @override
  int get hashCode => certificate.hashCode ^ privateKey.hashCode;

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is ClientCertificate &&
          runtimeType == other.runtimeType &&
          certificate == other.certificate &&
          privateKey == other.privateKey;
}

class ClientSettings {
  final TimeoutSettings? timeoutSettings;
  final bool throwOnStatusCode;
  final ProxySettings? proxySettings;
  final RedirectSettings? redirectSettings;
  final TlsSettings? tlsSettings;
  final DnsSettings? dnsSettings;

  const ClientSettings({
    this.timeoutSettings,
    required this.throwOnStatusCode,
    this.proxySettings,
    this.redirectSettings,
    this.tlsSettings,
    this.dnsSettings,
  });

  static Future<ClientSettings> default_() =>
      RustLib.instance.api.crateApiRhttpClientClientSettingsDefault();

  @override
  int get hashCode =>
      timeoutSettings.hashCode ^
      throwOnStatusCode.hashCode ^
      proxySettings.hashCode ^
      redirectSettings.hashCode ^
      tlsSettings.hashCode ^
      dnsSettings.hashCode;

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is ClientSettings &&
          runtimeType == other.runtimeType &&
          timeoutSettings == other.timeoutSettings &&
          throwOnStatusCode == other.throwOnStatusCode &&
          proxySettings == other.proxySettings &&
          redirectSettings == other.redirectSettings &&
          tlsSettings == other.tlsSettings &&
          dnsSettings == other.dnsSettings;
}

class CustomProxy {
  final String url;
  final ProxyCondition condition;

  const CustomProxy({required this.url, required this.condition});

  @override
  int get hashCode => url.hashCode ^ condition.hashCode;

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is CustomProxy &&
          runtimeType == other.runtimeType &&
          url == other.url &&
          condition == other.condition;
}

enum ProxyCondition { http, https, all }

@freezed
sealed class ProxySettings with _$ProxySettings {
  const ProxySettings._();

  const factory ProxySettings.noProxy() = ProxySettings_NoProxy;
  const factory ProxySettings.customProxyList(List<CustomProxy> field0) =
      ProxySettings_CustomProxyList;
}

@freezed
sealed class RedirectSettings with _$RedirectSettings {
  const RedirectSettings._();

  const factory RedirectSettings.noRedirect() = RedirectSettings_NoRedirect;
  const factory RedirectSettings.limitedRedirects(int field0) =
      RedirectSettings_LimitedRedirects;
}

class StaticDnsSettings {
  final Map<String, List<String>> overrides;
  final String? fallback;

  const StaticDnsSettings({required this.overrides, this.fallback});

  @override
  int get hashCode => overrides.hashCode ^ fallback.hashCode;

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is StaticDnsSettings &&
          runtimeType == other.runtimeType &&
          overrides == other.overrides &&
          fallback == other.fallback;
}

class TimeoutSettings {
  final Duration? timeout;
  final Duration? connectTimeout;
  final Duration? keepAliveTimeout;
  final Duration? keepAlivePing;

  const TimeoutSettings({
    this.timeout,
    this.connectTimeout,
    this.keepAliveTimeout,
    this.keepAlivePing,
  });

  @override
  int get hashCode =>
      timeout.hashCode ^
      connectTimeout.hashCode ^
      keepAliveTimeout.hashCode ^
      keepAlivePing.hashCode;

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is TimeoutSettings &&
          runtimeType == other.runtimeType &&
          timeout == other.timeout &&
          connectTimeout == other.connectTimeout &&
          keepAliveTimeout == other.keepAliveTimeout &&
          keepAlivePing == other.keepAlivePing;
}

class TlsSettings {
  final bool trustRootCertificates;
  final List<Uint8List> trustedRootCertificates;
  final bool verifyCertificates;
  final ClientCertificate? clientCertificate;
  final TlsVersion? minTlsVersion;
  final TlsVersion? maxTlsVersion;

  const TlsSettings({
    required this.trustRootCertificates,
    required this.trustedRootCertificates,
    required this.verifyCertificates,
    this.clientCertificate,
    this.minTlsVersion,
    this.maxTlsVersion,
  });

  @override
  int get hashCode =>
      trustRootCertificates.hashCode ^
      trustedRootCertificates.hashCode ^
      verifyCertificates.hashCode ^
      clientCertificate.hashCode ^
      minTlsVersion.hashCode ^
      maxTlsVersion.hashCode;

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is TlsSettings &&
          runtimeType == other.runtimeType &&
          trustRootCertificates == other.trustRootCertificates &&
          trustedRootCertificates == other.trustedRootCertificates &&
          verifyCertificates == other.verifyCertificates &&
          clientCertificate == other.clientCertificate &&
          minTlsVersion == other.minTlsVersion &&
          maxTlsVersion == other.maxTlsVersion;
}

enum TlsVersion { tls12, tls13 }
