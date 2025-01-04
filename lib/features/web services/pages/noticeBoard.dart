import 'dart:async';
import 'dart:developer';
import 'package:connectivity_plus/connectivity_plus.dart';
import 'package:diu_student/features/web%20services/widgets/offline_screen.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:url_launcher/url_launcher.dart';
import 'package:webview_flutter/webview_flutter.dart';

import '../../../core/resources/information_repository.dart';
import '../../home/presentation/pages/homePage.dart';
import '../widgets/cross_button.dart';


class noticeBoardPage extends StatefulWidget {
  const noticeBoardPage({Key? key}) : super(key: key);

  @override
  State<noticeBoardPage> createState() => _noticeBoardPageState();
}


const String mainUrl = 'https://daffodilvarsity.edu.bd/public/noticeboard';



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
        if(request.url == "https://daffodilvarsity.edu.bd/public/" ||
            request.url == "http://admission.daffodilvarsity.edu.bd/"){
          return NavigationDecision.prevent;
        }
        else if (request.url.toLowerCase().endsWith('.pdf')) {
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
    controller.clearLocalStorage();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    double h = MediaQuery.of(context).size.height;
    double w = MediaQuery.of(context).size.width;
    double crossButtonSize = h*.04;
    Color barColor = Color(0xFF5F683A);

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
        // extendBodyBehindAppBar: true,
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
