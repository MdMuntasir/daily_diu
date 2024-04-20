import 'dart:developer';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:url_launcher/url_launcher.dart';
import 'package:webview_flutter/webview_flutter.dart';

class blcPage extends StatefulWidget {
  const blcPage({Key? key}) : super(key: key);

  @override
  State<blcPage> createState() => _blcPageState();
}

WebViewController controller = WebViewController()
  ..setJavaScriptMode(JavaScriptMode.unrestricted)
  ..setBackgroundColor(const Color(0x00000000))
  ..setNavigationDelegate(
    NavigationDelegate(
      onProgress: (int progress) {
        // Update loading bar.
      },
      onPageStarted: (String url) {},
      onPageFinished: (String url) {},
      onWebResourceError: (WebResourceError error) {},
      onNavigationRequest: (NavigationRequest request) {
        if (request.url.startsWith('https://softengen.com/')) {
          return NavigationDecision.prevent;
        } else if (request.url.toLowerCase().endsWith('.pdf')) {
          log('PDF link encountered: ${request.url}');
          _launchPDF(request.url);
          return NavigationDecision.prevent;
        }
        return NavigationDecision.navigate;
      },
    ),
  )
  ..loadRequest(Uri.parse('https://elearn.daffodilvarsity.edu.bd/'));

Future<void> _launchPDF(String url) async {
  try {
    if (await canLaunch(url)) {
      await launch(url);
    } else {
      throw 'Could not launch $url';
    }
  } catch (e) {
    log('Error launching PDF: $e');
  }
}

class _blcPageState extends State<blcPage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: WebViewWidget(controller: controller),
    );
  }
}
