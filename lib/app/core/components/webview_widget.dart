import 'package:flutter/material.dart';
import 'package:changepayer_app/app/core/components/loading.dart';
import 'package:webview_flutter/webview_flutter.dart';
import 'package:webview_flutter_android/webview_flutter_android.dart';
import 'package:webview_flutter_wkwebview/webview_flutter_wkwebview.dart';
// import 'package:webview_cookie_manager/webview_cookie_manager.dart';

class WebView extends StatefulWidget {
  final String requestUrl;
  final Function(BuildContext context)? onRedirect;
  final Function(String url)? onUrlChange;
  final Function(String url, WebViewController controller)? onPageFinished;
  final Widget? loadingReplacement;
  final Color webViewBackgroundColor;

  const WebView({
    super.key,
    // Required to work
    required this.requestUrl,

    // Optionals
    this.onRedirect,
    this.onUrlChange,
    this.onPageFinished,
    this.loadingReplacement,
    this.webViewBackgroundColor = const Color(0x00000000),
  });

  @override
  WebViewState createState() => WebViewState();
}

class WebViewState extends State<WebView> {
  final _key = UniqueKey();
  late final WebViewController controller;
  // final _cookieManager = WebviewCookieManager();
  late Function onRedirect;
  Widget? loadingReplacement;

  bool isLoading = true;

  @override
  void initState() {
    super.initState();

    // _cookieManager.clearCookies();
    onRedirect = widget.onRedirect ??
        () {
          Navigator.of(context).pop();
        };
    loadingReplacement = widget.loadingReplacement;

    // #docregion platform_features
    late final PlatformWebViewControllerCreationParams params;
    if (WebViewPlatform.instance is WebKitWebViewPlatform) {
      params = WebKitWebViewControllerCreationParams(
        allowsInlineMediaPlayback: true,
        mediaTypesRequiringUserAction: const <PlaybackMediaTypes>{},
      );
    } else {
      params = const PlatformWebViewControllerCreationParams();
    }

    final WebViewController webViewController =
        WebViewController.fromPlatformCreationParams(params);
    // #enddocregion platform_features

    webViewController
      ..setJavaScriptMode(JavaScriptMode.unrestricted)
      ..setBackgroundColor(widget.webViewBackgroundColor)
      ..setNavigationDelegate(
        NavigationDelegate(
          onProgress: (int progress) {
            // Update loading bar.
          },
          onPageStarted: (String url) {},
          onPageFinished: (String url) {
            setState(() {
              isLoading = false;
            });

            //Check that the user is past authentication and current URL is the redirect with the code.
            if (widget.onPageFinished != null) {
              widget.onPageFinished!(url, controller);
              webViewController.runJavaScriptReturningResult(r'''
''');
            }
          },
          onWebResourceError: (WebResourceError error) {
            debugPrint('''
              Page resource error:
                code: ${error.errorCode}
                description: ${error.description}
                errorType: ${error.errorType}
                isForMainFrame: ${error.isForMainFrame}
                errorUrl: ${error.url}
          ''');
            if (error.url != null) {
              webViewController.loadRequest(
                Uri.parse(error.url!),
              );
            }
          },
          onNavigationRequest: (NavigationRequest request) {
            if (request.url.startsWith('https://www.youtube.com/')) {
              debugPrint('blocking navigation to ${request.url}');
              return NavigationDecision.prevent;
            }
            debugPrint('allowing navigation to ${request.url}');
            return NavigationDecision.navigate;
          },
          onUrlChange: (UrlChange change) {
            debugPrint('url change to ${change.url}');
            if (change.url != null) {
              if (change.url!.isNotEmpty &&
                  !isLoading &&
                  widget.onUrlChange != null) {
                widget.onUrlChange!(change.url!);
              }
            }
          },
        ),
      )
      ..addJavaScriptChannel(
        'Toaster',
        onMessageReceived: (JavaScriptMessage message) {
          ScaffoldMessenger.of(context).showSnackBar(
            SnackBar(content: Text(message.message)),
          );
        },
      )
      ..loadRequest(Uri.parse(widget.requestUrl));

    // #docregion platform_features
    if (webViewController.platform is AndroidWebViewController) {
      AndroidWebViewController.enableDebugging(true);
      (webViewController.platform as AndroidWebViewController)
          .setMediaPlaybackRequiresUserGesture(false);
    }
    // #enddocregion platform_features

    controller = webViewController;
  }

  @override
  void dispose() {
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    // _getCookies();
    return Scaffold(
      body: Stack(
        children: <Widget>[
          WebViewWidget(
            key: _key,
            controller: controller,
          ),
          Visibility(
              visible: loadingReplacement != null && isLoading,
              child: loadingReplacement ?? const SizedBox()),
          // Visibility(
          //   visible: loadingReplacement == null && isLoading,
          //   child: const Center(
          //     child: SizedBox(
          //       height: 250,
          //       width: 250,
          //       child: CircularProgressIndicator(
          //         backgroundColor: Colors.white,
          //         valueColor: AlwaysStoppedAnimation<Color>(Colors.blue),
          //       ),
          //     ),
          //   ),
          // ),
          Visibility(
            visible: loadingReplacement == null && isLoading,
            child: const Loading(),
          ),
        ],
      ),
    );
  }

  // Future<void> _getCookies() async {
  //   final cookies = await _cookieManager.getCookies('.testrelyonnutecdigital.b2clogin.com');
  //   for (var cookie in cookies) {
  //     if (cookie.name == 'x-ms-cpim-sso') {
  //       // setState(() {
  //       //   // Update the state with the cookie value
  //       //   xMsCpimSsoCookie = cookie.value;
  //       // });
  //       // break;
  //     }
  //   }
  // }
}
