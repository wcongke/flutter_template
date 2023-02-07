import 'package:flutter/material.dart';
import 'package:webview_flutter/webview_flutter.dart';

class AppWebViewCookie {
  final WebViewCookieManager webViewCookieManager = WebViewCookieManager();

  void onListCookies(BuildContext context, WebViewController controller) async {
    final Object cookies =
        await controller.runJavaScriptReturningResult('document.cookie');
    if (context.mounted) {
      ScaffoldMessenger.of(context)
          .showSnackBar(SnackBar(content: Text(cookies.toString())));
    }
  }

  void onClearCookies(BuildContext context) async {
    final hadCookies = await webViewCookieManager.clearCookies();
    String msg = hadCookies
        ? 'There were cookies. Now, they are gone!'
        : 'There were no cookies to clear.';

    if (context.mounted) {
      ScaffoldMessenger.of(context).showSnackBar(SnackBar(content: Text(msg)));
    }
  }

  void onAddCookie(BuildContext context, WebViewController controller) async {
    await controller.runJavaScript('''
      var date = new Date();
      date.setTime(date.getTime()+(30*24*60*60*1000));
      document.cookie = "FirstName=John; expires=" + date.toGMTString();
    ''');

    if (context.mounted) {
      ScaffoldMessenger.of(context)
          .showSnackBar(const SnackBar(content: Text('Custom cookie added.')));
    }
  }

  void onSetCookie(BuildContext context, WebViewController controller) async {
    await webViewCookieManager.setCookie(
      const WebViewCookie(name: 'foo', value: 'bar', domain: 'flutter.dev'),
    );

    if (context.mounted) {
      ScaffoldMessenger.of(context)
          .showSnackBar(const SnackBar(content: Text('Custom cookie is set.')));
    }
  }

  void onRemoveCookie(
      BuildContext context, WebViewController controller) async {
    await controller.runJavaScript(
        'document.cookie="FirstName=John; expires=Thu, 01 Jan 1970 00:00:00 UTC" ');

    if (context.mounted) {
      ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(content: Text('Custom cookie removed.')));
    }
  }
}
