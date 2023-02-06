import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:webview_flutter/webview_flutter.dart';

class WebviewPage extends StatefulWidget {
  const WebviewPage(
      {super.key,
      required this.title,
      required this.url,
      this.fromPage = '/home'});

  final String title;
  final String url;
  final String fromPage;

  @override
  State<WebviewPage> createState() => _WebviewPage();
}

class _WebviewPage extends State<WebviewPage> {
  late final WebViewController controller;
  int loadingPercentage = 0;

  @override
  void initState() {
    super.initState();

    controller = WebViewController()
      ..setJavaScriptMode(JavaScriptMode.unrestricted)
      ..setBackgroundColor(const Color.fromARGB(255, 255, 255, 255))
      ..setNavigationDelegate(
        NavigationDelegate(
          onProgress: (int progress) {
            // Update loading bar.
            setState(() {
              loadingPercentage = progress;
            });
          },
          onPageStarted: (String url) {
            setState(() {
              loadingPercentage = 0;
            });
          },
          onPageFinished: (String url) {
            setState(() {
              loadingPercentage = 100;
            });
          },
          onWebResourceError: (WebResourceError error) {},
          onNavigationRequest: (NavigationRequest request) {
            if (request.url.startsWith(widget.url)) {
              return NavigationDecision.prevent;
            }
            return NavigationDecision.navigate;
          },
        ),
      )
      ..loadRequest(Uri.parse(widget.url));

    if (loadingPercentage < 100) {
      LinearProgressIndicator(
        value: loadingPercentage / 100.0,
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          leading: IconButton(
              onPressed: () => context.go(widget.fromPage),
              icon: const Icon(Icons.arrow_back)),
          title: Text(widget.title),
          actions: [
            IconButton(
                onPressed: () async {
                  if (await controller.canGoBack()) {
                    await controller.goBack();
                    return;
                  }

                  if (context.mounted) {
                    ScaffoldMessenger.of(context).showSnackBar(
                      const SnackBar(content: Text('No back history item')),
                    );
                  }
                },
                icon: const Icon(Icons.arrow_back_ios)),
            IconButton(
                onPressed: () async {
                  if (await controller.canGoForward()) {
                    await controller.goForward();
                    return;
                  }

                  if (context.mounted) {
                    ScaffoldMessenger.of(context).showSnackBar(
                      const SnackBar(content: Text('No forward history item')),
                    );
                  }
                },
                icon: const Icon(Icons.arrow_forward_ios)),
            IconButton(
                onPressed: () {
                  controller.reload();
                },
                icon: const Icon(Icons.replay)),
            PopupMenuButton(
                onSelected: (value) async {
                  switch (value) {
                    case 'userAgent':
                      final userAgent = await controller
                          .runJavaScriptReturningResult('navigator.userAgent');
                      if (context.mounted) {
                        ScaffoldMessenger.of(context).showSnackBar(
                            SnackBar(content: Text(userAgent.toString())));
                      }

                      break;
                    default:
                      break;
                  }
                },
                itemBuilder: (context) => [
                      const PopupMenuItem(
                          value: 'userAgent', child: Text('Show user-agent')),
                    ])
          ],
        ),
        body: WebViewWidget(controller: controller));
  }
}
