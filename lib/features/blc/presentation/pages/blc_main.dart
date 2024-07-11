import 'dart:async';
import 'dart:developer';
import 'package:connectivity_plus/connectivity_plus.dart';
import 'package:diu_student/core/resources/information_repository.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
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
    if (await canLaunchUrl(Uri.parse(url))) {
      await launchUrl(Uri.parse(url));
    } else {
      throw 'Could not launch $url';
    }
  } catch (e) {
    log('Error launching PDF: $e');
  }
}





class _blcPageState extends State<blcPage> {
  bool pageLoaded = false;

  @override
  void initState() {
    super.initState();
    Timer.periodic(Duration(seconds: 3), (_)async{
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
  Widget build(BuildContext context) {
    double h = MediaQuery.of(context).size.height;
    double w = MediaQuery.of(context).size.width;

    return Scaffold(
      body: Online ?
      WebViewWidget(controller: controller)
          :
      Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Icon(Icons.wifi_off, size: 120, color: Colors.red.shade300,),


          SizedBox(height: h*.02,),

          Text(
              "No Internet Connection!",
            style: TextStyle(
                fontSize: 18,
                fontWeight: FontWeight.bold,
                fontFamily: "Madimi",
              color: Colors.red.shade300
            ),
          ),

          SizedBox(height: h*.05,width: w,),

          
          TextButton(
            onPressed: _connection,
            child: SizedBox(
              width: w*.5,
              child: const Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Icon(FontAwesomeIcons.arrowsRotate,size: 15,),
                  SizedBox(width: 8,),
                  Text(
                    "Refresh",
                    style: TextStyle(
                        fontSize: 18,
                        fontWeight: FontWeight.bold,
                        fontFamily: "Madimi"
                    ),
                  ),
                ],

              ),
            ),
          ),
        ],
      )
    );
  }
}
