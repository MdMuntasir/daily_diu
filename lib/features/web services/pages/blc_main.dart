import 'dart:async';
import 'dart:developer';
import 'package:connectivity_plus/connectivity_plus.dart';
import 'package:diu_student/core/resources/information_repository.dart';
import 'package:diu_student/features/home/presentation/pages/homePage.dart';
import 'package:diu_student/features/web%20services/widgets/offline_screen.dart';
import 'package:diu_student/main.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:url_launcher/url_launcher.dart';
import 'package:webview_flutter/webview_flutter.dart';

import '../widgets/cross_button.dart';

class blcPage extends StatefulWidget {
  const blcPage({Key? key}) : super(key: key);

  @override
  State<blcPage> createState() => _blcPageState();
}


const String mainUrl = 'https://elearn.daffodilvarsity.edu.bd/';


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
          log('PDF link encountered: ${request.url}');
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
      log('Launched URL: $url');
    } else {
      log('Could not launch URL: $url');
    }
  } catch (e) {
    log('Error launching PDF: $e');
  }
}





class _blcPageState extends State<blcPage> {
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
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    double h = MediaQuery.of(context).size.height;
    double w = MediaQuery.of(context).size.width;
    double crossButtonSize = h*.04;
    Color barColor = Color(0xFF62A8EA);

    return PopScope(
      canPop: false,
      onPopInvokedWithResult: (didPop, result) async{
        if(await controller.canGoBack()){
          controller.goBack();
        } else{
          Navigator.of(context).pushReplacement(MaterialPageRoute(builder: (context)=>homePage()));
        }
      },

      child: Scaffold(
          appBar: AppBar(
            backgroundColor: barColor,
            toolbarHeight: h*.05,
            actions: [Padding(
              padding: EdgeInsets.only(right: w*.07),
              child: CrossButton(crossButtonSize: crossButtonSize, color: barColor,),
            )],

          ),
        body: Online ?
        WebViewWidget(controller: controller)
            :
        OfflineScreen(function: _connection)
      ),
    );
  }
}
