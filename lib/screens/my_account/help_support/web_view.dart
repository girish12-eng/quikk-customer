import 'dart:io';
import 'package:flutter/material.dart';
import 'package:webview_flutter/webview_flutter.dart';

class WebViewMobileScreen extends StatefulWidget {
  final String url;

  const WebViewMobileScreen({
    Key? key,
    required this.url,
  }) : super(key: key);

  @override
  WebViewMobileScreenState createState() => WebViewMobileScreenState();
}

class WebViewMobileScreenState extends State<WebViewMobileScreen> {
  @override
  void initState() {
    super.initState();
    // Enable hybrid composition.
    if (Platform.isAndroid) WebView.platform = SurfaceAndroidWebView();
  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: WebView(
        initialUrl: widget.url,
      ),
    );
  }
}
