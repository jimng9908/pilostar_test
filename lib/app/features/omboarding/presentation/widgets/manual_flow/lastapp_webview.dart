import 'package:flutter/foundation.dart';
import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:rockstardata_apk/app/features/shared/shared.dart';
import 'package:webview_flutter/webview_flutter.dart';

class LastAppWebView extends StatelessWidget {
  const LastAppWebView({super.key});

  @override
  Widget build(BuildContext context) {
    final gestureRecognizers = <Factory<OneSequenceGestureRecognizer>>{
      Factory<VerticalDragGestureRecognizer>(
        () => VerticalDragGestureRecognizer(),
      ),
      Factory<HorizontalDragGestureRecognizer>(
        () => HorizontalDragGestureRecognizer(),
      ),
    };

    return BlocBuilder<WebViewBloc, WebViewState>(
      builder: (context, state) {
        if (state is WebViewReady) {
          return WebViewWidget(
            controller: state.controller,
            gestureRecognizers: gestureRecognizers,
          );
        }
        if (state is WebViewSuccess) {
          return WebViewWidget(
            controller: state.controller,
            gestureRecognizers: gestureRecognizers,
          );
        }
        return const Center(child: CircularProgressIndicator());
      },
    );
  }
}
