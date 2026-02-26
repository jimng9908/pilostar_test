import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:rockstardata_apk/app/core/core.dart';

class BasePage extends StatelessWidget {
  final Widget body;
  final String? title;
  final Color? backgroundColor;
  final PreferredSizeWidget? appBar;
  final Color? appBarColor;
  final List<Widget>? actions;
  final Widget? leading;
  final bool showAppBar;
  final Widget? floatingActionButton;
  final Widget? bottomNavigationBar;
  final Widget? drawer;

  const BasePage({
    super.key,
    required this.body,
    this.title,
    this.backgroundColor,
    this.appBar,
    this.appBarColor,
    this.actions,
    this.leading,
    this.showAppBar = false,
    this.floatingActionButton,
    this.bottomNavigationBar,
    this.drawer,
  });

  @override
  Widget build(BuildContext context) {
    // Configurar el color de la status bar
    SystemChrome.setSystemUIOverlayStyle(
      SystemUiOverlayStyle(
        statusBarColor: Colors.transparent,
        statusBarIconBrightness: Brightness.light,
        statusBarBrightness: Brightness.dark,
      ),
    );

    return Scaffold(
      appBar: showAppBar ? appBar : null,
      drawer: drawer,
      body: Container(
        width: double.infinity,
        height: double.infinity,
        decoration: BoxDecoration(
          color: backgroundColor,
          gradient: backgroundColor == null
              ? LinearGradient(
                  begin: Alignment(0.80, 0.86),
                  end: Alignment(0.60, 0.30),
                  colors: [AppColor.primary, AppColor.primaryLight],
                )
              : null,
        ),
        child: SafeArea(
          child: body,
        ),
      ),
      floatingActionButton: floatingActionButton,
      bottomNavigationBar: bottomNavigationBar,
    );
  }
}
