import 'package:get/get.dart';
import 'package:webview_flutter/webview_flutter.dart';

class WebView_controller extends GetxController {
  WebViewController? controller;

  @override
  void onInit() {
    super.onInit();

    // WebView is not supported on Windows (using GetPlatform for safety)
    if (GetPlatform.isWindows) return;

    // Initialize WebView
    controller = WebViewController()
      ..setJavaScriptMode(JavaScriptMode.unrestricted)
      ..setNavigationDelegate(
        NavigationDelegate(
          onProgress: (int progress) {
            // Update loading bar.
          },
          onPageStarted: (String url) {},
          onPageFinished: (String url) {},
          onHttpError: (HttpResponseError error) {},
          onWebResourceError: (WebResourceError error) {},
          onNavigationRequest: (NavigationRequest request) {
            if (request.url.startsWith('https://www.youtube.com/')) {
              return NavigationDecision.prevent;
            }
            return NavigationDecision.navigate;
          },
        ),
      )
      ..loadRequest(Uri.parse('https://flutter.dev'));
  }
}
