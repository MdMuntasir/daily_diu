import 'dart:async';
import 'dart:developer';

import 'package:connectivity_plus/connectivity_plus.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:internet_connection_checker_plus/internet_connection_checker_plus.dart';
import 'package:url_launcher/url_launcher.dart';
import 'package:webview_flutter/webview_flutter.dart';

import '../../../core/resources/information_repository.dart';
import '../../home/presentation/pages/homePage.dart';
import '../widgets/cross_button.dart';
import '../widgets/offline_screen.dart';

class AttendancePortal extends StatefulWidget {
  const AttendancePortal({super.key});

  @override
  State<AttendancePortal> createState() => _AttendancePortalState();
}

const String mainUrl = 'https://sso.diu.edu.bd/';

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
        if (request.url.toLowerCase().endsWith('.pdf')) {
          _launchPDF(request.url);
          return NavigationDecision.prevent;
        }
        return NavigationDecision.navigate;
      },
    ),
  )
  ..loadRequest(Uri.parse(mainUrl));

Future<void> _launchPDF(String url) async {
  final Uri uri = Uri.parse(url);
  try {
    if (await launchUrl(
      uri,
      mode: LaunchMode.externalApplication,
    )) {
    } else {
      log('Could not launch URL: $url');
    }
  } catch (e) {
    log('Error launching PDF: $e');
  }
}

class _AttendancePortalState extends State<AttendancePortal> {
  bool pageLoaded = false;
  Timer? timer;
  Color barColor = Color(0xFF62A8EA);

  @override
  void initState() {
    super.initState();
    timer = Timer.periodic(Duration(seconds: 3), (_) async {
      await _connection();
    });
  }

  Future<void> _connection() async {
    final internet = InternetConnection.createInstance();
    final _checkConnection = await internet.hasInternetAccess;

    setState(() {
      if (!pageLoaded) controller.reload();
    });
    pageLoaded = Online;
  }

  @override
  void dispose() {
    timer?.cancel();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    double w = MediaQuery.of(context).size.width;

    return PopScope(
      canPop: false,
      onPopInvokedWithResult: (didPop, result) async {
        if (await controller.canGoBack()) {
          controller.goBack();
        } else {
          Navigator.of(context).pushReplacement(
              MaterialPageRoute(builder: (context) => const homePage()));
        }
      },
      child: Scaffold(
          appBar: AppBar(
            backgroundColor: barColor,
            actions: [
              Padding(
                padding: EdgeInsets.only(right: w * .07),
                child: CrossButton(
                  color: barColor,
                ),
              )
            ],
          ),
          body: Online
              ? WebViewWidget(controller: controller)
              : OfflineScreen(function: _connection)),
    );
  }
}
