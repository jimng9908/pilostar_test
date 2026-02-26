part of 'web_view_bloc.dart';

abstract class WebViewState {}

class WebViewWaiting extends WebViewState {}

class WebViewReady extends WebViewState {
  final WebViewController controller;
  WebViewReady(this.controller);
}

class WebViewSuccess extends WebViewState {
  final String token;
  final String? locationId;
  final String? locationName;
  final String? callbackUrl;
  final WebViewController controller;
  WebViewSuccess(this.token, this.controller,
      {this.locationId, this.locationName, this.callbackUrl});
}
