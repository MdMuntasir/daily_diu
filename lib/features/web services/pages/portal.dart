import 'dart:async';
import 'dart:developer';
import 'package:connectivity_plus/connectivity_plus.dart';
import 'package:diu_student/core/common/app%20user/userCubit/app_user_cubit.dart';
import 'package:diu_student/features/web%20services/widgets/cross_button.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:url_launcher/url_launcher.dart';
import 'package:webview_flutter/webview_flutter.dart';
import '../../../core/resources/information_repository.dart';
import '../../home/presentation/pages/homePage.dart';
import '../widgets/offline_screen.dart';

class PortalPage extends StatefulWidget {
  const PortalPage({
    super.key,
  });

  @override
  State<PortalPage> createState() => _PortalPageState();
}

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

class _PortalPageState extends State<PortalPage> {
  bool pageLoaded = false;
  Timer? timer;
  Color barColor = Color(0xFF00868D);

  late String userRole;

  late WebViewController controller;

  @override
  void initState() {
    bool isStudent =
        AppUserCubit()
            .currentUser(context.read<AppUserCubit>())
            .user ==
            "Student";
    controller = WebViewController()
      ..setJavaScriptMode(JavaScriptMode.unrestricted)
      ..setBackgroundColor(const Color(0x00000000))
      ..setNavigationDelegate(
        NavigationDelegate(
          onProgress: (int progress) {
            // Update loading bar.
          },
          onPageStarted: (String url) {},
          onPageFinished: (String url) {
            log('Page finished loading: $url');
          },
          onWebResourceError: (WebResourceError error) {
            log('Error loading resource: ${error.description}');
          },
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
      ..loadRequest(Uri.parse(isStudent
          ? "http://studentportal.diu.edu.bd"
          : "https://teacherportal.diu.edu.bd/"));

    super.initState();
    timer = Timer.periodic(const Duration(seconds: 1), (_) async {
      await _connection();
    });
  }

  Future<void> _connection() async {
    final _checkConnection = await Connectivity().checkConnectivity();
    Online = _checkConnection.contains(ConnectivityResult.mobile) ||
        _checkConnection.contains(ConnectivityResult.wifi);

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
    double w = MediaQuery
        .of(context)
        .size
        .width;

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
