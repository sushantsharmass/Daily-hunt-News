import 'package:flutter/material.dart';
import 'package:webview_flutter/webview_flutter.dart';
import 'dart:async';


class ArticleViewss extends StatefulWidget {

  final String blogUrl;
  ArticleViewss({this.blogUrl});

  @override
  _ArticleViewssState createState() => _ArticleViewssState();
}


class _ArticleViewssState extends State<ArticleViewss> {

final Completer<WebViewController> _completer = Completer<WebViewController>();


  @override
  Widget build (BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.blue,
        title:Text("News"),
        centerTitle: true,
      ),
      body: Container(
        height: MediaQuery.of(context).size.height,
        width: MediaQuery.of(context).size.width,
      child: WebView(
        initialUrl: widget.blogUrl,
        onWebViewCreated: ((WebViewController webViewController) {
          _completer.complete(webViewController);
        }),
        ), 
      ),
    );
  }
}