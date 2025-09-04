import 'package:flutter/material.dart';
import 'package:flutter_inappwebview/flutter_inappwebview.dart';

import '/theme/theme_colors.dart';

class FeedbackPage extends StatefulWidget {
  final String requestUrl;
  final Function(BuildContext context)? onRedirect;
  final Function(String url)? onUrlChange;
  final Widget? loadingReplacement;
  final Color webViewBackgroundColor;

  const FeedbackPage({
    super.key,
    // Required to work
    required this.requestUrl,

    // Optionals
    this.onRedirect,
    this.onUrlChange,
    this.loadingReplacement,
    this.webViewBackgroundColor = const Color(0x00000000),
  });
  static const String route = 'FeedbackPage';

  @override
  FeedbackPageState createState() => FeedbackPageState();
}

class FeedbackPageState extends State<FeedbackPage> {
  int? isSelected;

  //Webview variables

  final GlobalKey webViewKey = GlobalKey();

  InAppWebViewController? webViewController;

  PullToRefreshController? pullToRefreshController;
  String url = "";
  double progress = 0;
  final urlController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    final double width = MediaQuery.of(context).size.width;

    return Scaffold(
      resizeToAvoidBottomInset: false,
      // appBar: AppBar(
      //   centerTitle: true,
      //   title: Text(
      //     "Feedback",
      //     style: TextStyle(
      //       color: Colors.black,
      //     ),
      //   ),
      //   leading: IconButton(
      //     icon: const Icon(
      //       Icons.arrow_back_ios_outlined,
      //       color: AppColors.darkBlue,
      //     ),
      //     onPressed: () {
      //       Navigator.pushNamed(
      //         context,
      //         HomePage.route,
      //       );
      //     },
      //   ),
      // ),
      body: SafeArea(
        child: Container(
          color: Colors.white,
          child: Column(
            children: <Widget>[
              Expanded(
                child: Stack(
                  children: [
                    InAppWebView(
                      key: webViewKey,
                      initialUrlRequest: URLRequest(
                        url: WebUri(widget.requestUrl),
                      ),
                      pullToRefreshController: pullToRefreshController,
                      onWebViewCreated: (controller) {
                        webViewController = controller;
                      },
                      onLoadStart: (controller, url) {
                        setState(() {
                          this.url = url.toString();
                          urlController.text = this.url;
                        });
                      },
                      shouldOverrideUrlLoading: (controller, navigationAction) async {
                        var uri = navigationAction.request.url!;

                        // if (![
                        //   "http",
                        //   "https",
                        //   "file",
                        //   "chrome",
                        //   "data",
                        //   "javascript",
                        //   "about"
                        // ].contains(uri.scheme)) {
                        //   if (await canLaunchUrl(uri)) {
                        //     // Launch the App
                        //     await launchUrl(
                        //       uri,
                        //     );
                        //     // and cancel the request
                        //     return NavigationActionPolicy.CANCEL;
                        //   }
                        // }

                        return NavigationActionPolicy.ALLOW;
                      },
                      onLoadStop: (controller, url) async {
                        pullToRefreshController?.endRefreshing();
                        setState(() {
                          this.url = url.toString();
                          urlController.text = this.url;
                        });
                      },
                      onProgressChanged: (controller, progress) {
                        if (progress == 100) {
                          pullToRefreshController?.endRefreshing();
                        }
                        setState(() {
                          this.progress = progress / 100;
                          urlController.text = this.url;
                        });
                      },
                      onUpdateVisitedHistory: (controller, url, androidIsReload) {
                        setState(() {
                          this.url = url.toString();
                          urlController.text = this.url;
                        });
                      },
                      onConsoleMessage: (controller, consoleMessage) {
                        print(consoleMessage);
                      },
                      initialData: null,
                    ),
                    progress < 1.0
                        ? Container(
                            color: Colors.white.withValues(alpha: 0.4),
                            child: const Center(
                              child: SizedBox(
                                width: 64,
                                height: 64,
                                child: CircularProgressIndicator(
                                  strokeWidth: 3,
                                  valueColor: AlwaysStoppedAnimation<Color>(ThemeColors.accentColor),
                                ),
                              ),
                            ),
                          )
                        : Container(),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
