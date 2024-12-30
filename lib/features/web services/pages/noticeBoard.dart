import 'dart:async';
import 'dart:developer';
import 'package:connectivity_plus/connectivity_plus.dart';
import 'package:diu_student/features/web%20services/widgets/offline_screen.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:url_launcher/url_launcher.dart';
import 'package:webview_flutter/webview_flutter.dart';

import '../../../core/resources/information_repository.dart';


class noticeBoardPage extends StatefulWidget {
  const noticeBoardPage({Key? key}) : super(key: key);

  @override
  State<noticeBoardPage> createState() => _noticeBoardPageState();
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
  ..loadRequest(Uri.parse('https://daffodilvarsity.edu.bd/noticeboard/'));

Future<void> _launchPDF(String url) async {
  try {
    if (await canLaunchUrl(Uri.parse(url))) {
      await launchUrl(Uri.parse(url));
    } else {
      throw 'Could not launch $url';
    }
  } catch (e) {
    log('Error launching PDF: $e');
  }
}

class _noticeBoardPageState extends State<noticeBoardPage> {
  bool pageLoaded = false;
  Timer? timer;

  @override
  void initState() {
    super.initState();
    timer = Timer.periodic(Duration(seconds: 3), (_)async{
      await _connection();
    });
  }


  Future<void> _connection() async {
    final _checkConnection = await Connectivity().checkConnectivity();
    Online = _checkConnection.contains(ConnectivityResult.mobile) || _checkConnection.contains(ConnectivityResult.wifi);

    setState(() {
      if(!pageLoaded) controller.reload();
    });
    pageLoaded = Online;
  }

  @override
  void dispose() {
    timer?.cancel();
    controller.clearCache();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {

    return Scaffold(

      body: Online?
      WebViewWidget(controller: controller)
          :
      OfflineScreen(function: _connection)
    );
  }
}
