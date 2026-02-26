import 'package:bloc/bloc.dart';
import 'package:flutter/foundation.dart';
import 'package:webview_flutter/webview_flutter.dart';

part 'web_view_event.dart';
part 'web_view_state.dart';

class WebViewBloc extends Bloc<WebViewEvent, WebViewState> {
  bool _tokenCaptured = false;
  static const _callbackPath = '/auth2/lastapp/callback';
  static const _linkPath = '/integrations/last-app/link';

  WebViewBloc() : super(WebViewWaiting()) {
    on<InitWebView>(_onInitWebView);
    on<CallbackUrlDetected>(_onCallbackUrlDetected);
    on<MarketplaceHandshakeDetected>(_onMarketplaceHandshakeDetected);
  }

  void _onInitWebView(InitWebView event, Emitter<WebViewState> emit) {
    final controller = WebViewController();
    controller
      ..setJavaScriptMode(JavaScriptMode.unrestricted)
      ..enableZoom(true)
      ..setUserAgent(
          "Mozilla/5.0 (iPhone; CPU iPhone OS 15_0 like Mac OS X) AppleWebKit/605.1.15 (KHTML, like Gecko) Version/15.0 Mobile/15E148 Safari/604.1")
      ..setNavigationDelegate(
        NavigationDelegate(
          onPageStarted: (url) {
            debugPrint('LastAppWebView: onPageStarted -> $url');
          },
          onPageFinished: (url) {
            debugPrint('LastAppWebView: onPageFinished -> $url');
            // Inject viewport for responsiveness
            final viewportScript = """
              var meta = document.createElement('meta');
              meta.name = 'viewport';
              meta.content = 'width=device-width, initial-scale=1.0, maximum-scale=1.0, user-scalable=no';
              document.getElementsByTagName('head')[0].appendChild(meta);
            """;
            controller.runJavaScript(viewportScript);
          },
          onWebResourceError: (error) {
            debugPrint(
                'LastAppWebView: onWebResourceError -> ${error.description}');
          },
          onNavigationRequest: (NavigationRequest request) {
            debugPrint('LastAppWebView: Navegando a -> ${request.url}');
            final uri = Uri.tryParse(request.url);
            if (uri == null) return NavigationDecision.navigate;

            if (request.url.contains(_callbackPath)) {
              final jwt = uri.queryParameters['jwt'];
              if (jwt != null && jwt.isNotEmpty && !_tokenCaptured) {
                debugPrint(
                    'LastAppWebView: Callback URL interceptada, JWT extraído.');
                add(CallbackUrlDetected(jwt, controller));
              }
              return NavigationDecision.prevent;
            }

            if (request.url.contains(_linkPath)) {
              final token = uri.queryParameters['token'];
              final locationId = uri.queryParameters['locationId'];
              final locationName = uri.queryParameters['locationName'];
              final callbackUrl = uri.queryParameters['callbackUrl'];

              if (token != null &&
                  locationId != null &&
                  locationName != null &&
                  !_tokenCaptured) {
                debugPrint(
                    'LastAppWebView: Marketplace Handshake interceptado: $locationName');
                add(MarketplaceHandshakeDetected(
                  token: token,
                  locationId: locationId,
                  locationName: locationName,
                  callbackUrl: callbackUrl,
                  controller: controller,
                ));
              }
              return NavigationDecision.prevent;
            }

            return NavigationDecision.navigate;
          },
        ),
      )
      ..loadRequest(Uri.parse(event.url));

    emit(WebViewReady(controller));
  }

  void _onCallbackUrlDetected(
      CallbackUrlDetected event, Emitter<WebViewState> emit) {
    if (_tokenCaptured) {
      debugPrint('WebViewBloc: Callback duplicado ignorado.');
      return;
    }
    _tokenCaptured = true;
    debugPrint('WebViewBloc: JWT: ${event.jwt}');
    emit(WebViewSuccess(event.jwt, event.controller));
  }

  void _onMarketplaceHandshakeDetected(
      MarketplaceHandshakeDetected event, Emitter<WebViewState> emit) {
    if (_tokenCaptured) return;
    _tokenCaptured = true;
    emit(WebViewSuccess(
      event.token,
      event.controller,
      locationId: event.locationId,
      locationName: event.locationName,
      callbackUrl: event.callbackUrl,
    ));
  }
}
