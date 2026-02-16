import 'package:flutter/material.dart';
import 'package:indian_hoax_news/models/news_article.dart';
import 'package:webview_flutter/webview_flutter.dart';
import 'package:indian_hoax_news/app/modules/home/controllers/WebView_controller.dart';
// Import for Android features.

import 'package:webview_flutter_android/webview_flutter_android.dart';
// Import for iOS/macOS features.
import 'package:webview_flutter_wkwebview/webview_flutter_wkwebview.dart';
import 'package:get/get.dart';

class NewsDetailWebView extends StatefulWidget {
  final NewsArticle article;
  final WebView_controller webViewController;

  const NewsDetailWebView({
    Key? key,
    required this.article,
    required this.webViewController,
  }) : super(key: key);

  @override
  State<NewsDetailWebView> createState() => _NewsDetailWebViewState();
}

class _NewsDetailWebViewState extends State<NewsDetailWebView> {
  @override
  Widget build(BuildContext context) {
    if (GetPlatform.isWindows) {
      return Scaffold(
        appBar: AppBar(title: const Text('Flutter Simple Example')),
        body: const Center(child: Text('WebView is not supported on Windows')),
      );
    }
    return Scaffold(
      appBar: AppBar(title: const Text('Flutter Simple Example')),
      body: WebViewWidget(controller: widget.webViewController.controller!),
    );
  }
}
