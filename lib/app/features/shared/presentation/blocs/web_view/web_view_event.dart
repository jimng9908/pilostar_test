part of 'web_view_bloc.dart';

abstract class WebViewEvent {}

class InitWebView extends WebViewEvent {
  final String url;
  InitWebView(this.url);
}

class CallbackUrlDetected extends WebViewEvent {
  final String jwt;
  final WebViewController controller;
  CallbackUrlDetected(this.jwt, this.controller);
}

class MarketplaceHandshakeDetected extends WebViewEvent {
  final String token;
  final String locationId;
  final String locationName;
  final String? callbackUrl;
  final WebViewController controller;
  MarketplaceHandshakeDetected({
    required this.token,
    required this.locationId,
    required this.locationName,
    this.callbackUrl,
    required this.controller,
  });
}
