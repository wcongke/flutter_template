import 'package:flutter/material.dart';
import 'package:webview_flutter/webview_flutter.dart';
import 'package:flutter_template/pages/webview/cookie.dart';

enum _PopupMenuOptions {
  userAgent,
  listCookies,
  clearCookies,
  addCookie,
  setCookie,
  removeCookie,
}

class PopupMenu extends StatefulWidget {
  const PopupMenu({required this.controller, Key? key}) : super(key: key);

  final WebViewController controller;

  @override
  State<PopupMenu> createState() => _PopupMenu();
}

class _PopupMenu extends State<PopupMenu> {
  final appWebViewCookie = AppWebViewCookie();

  @override
  Widget build(BuildContext context) {
    return FutureBuilder<WebViewController>(builder: (context, snapshot) {
      return PopupMenuButton<_PopupMenuOptions>(
          onSelected: (value) async {
            switch (value) {
              case _PopupMenuOptions.userAgent:
                final userAgent = await widget.controller
                    .runJavaScriptReturningResult('navigator.userAgent');
                if (context.mounted) {
                  ScaffoldMessenger.of(context).showSnackBar(
                      SnackBar(content: Text(userAgent.toString())));
                }
                break;

              case _PopupMenuOptions.listCookies:
                appWebViewCookie.onListCookies(context, widget.controller);
                break;
              case _PopupMenuOptions.addCookie:
                appWebViewCookie.onAddCookie(context, widget.controller);
                break;
              case _PopupMenuOptions.clearCookies:
                appWebViewCookie.onClearCookies(context);
                break;
              case _PopupMenuOptions.removeCookie:
                appWebViewCookie.onRemoveCookie(context, widget.controller);
                break;
              case _PopupMenuOptions.setCookie:
                appWebViewCookie.onSetCookie(context, widget.controller);
                break;

              default:
                break;
            }
          },
          itemBuilder: (context) => [
                const PopupMenuItem(
                    value: _PopupMenuOptions.userAgent,
                    child: Text('Show user-agent')),
                const PopupMenuItem(
                    value: _PopupMenuOptions.listCookies,
                    child: Text('List Cookies')),
                const PopupMenuItem(
                    value: _PopupMenuOptions.addCookie,
                    child: Text('Add Cookie')),
                const PopupMenuItem(
                    value: _PopupMenuOptions.clearCookies,
                    child: Text('Clear Cookie')),
                const PopupMenuItem(
                    value: _PopupMenuOptions.removeCookie,
                    child: Text('Remove Cookie')),
                const PopupMenuItem(
                    value: _PopupMenuOptions.setCookie,
                    child: Text('Set Cookie'))
              ]);
    });
  }
}
