import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:internet_connection_checker_plus/internet_connection_checker_plus.dart';
import 'package:lottie/lottie.dart';
import 'package:permission_handler/permission_handler.dart';

import '../../resources/information_repository.dart';
import '../services.dart';

class DownloadFile extends StatefulWidget {
  final String fileName;
  final BuildContext context;
  final Color color;
  final bool blackDownloading;
  final String url;

  const DownloadFile({
    super.key,
    this.fileName = "Untitled File",
    this.color = Colors.white,
    this.blackDownloading = false,
    required this.url,
    required this.context,
  });

  @override
  State<DownloadFile> createState() => _DownloadFileState();
}

class _DownloadFileState extends State<DownloadFile> {
  bool isDownloading = false;
  final InternetConnection internetConnection =
      InternetConnection.createInstance();

  Future<void> _download() async {
    bool RequestAccepted;

    final isConnected = await internetConnection.hasInternetAccess;

    if (widget.fileName == "") {
      if (widget.context.mounted) {
        ScaffoldMessenger.of(widget.context).showSnackBar(
            const SnackBar(content: Text("Input format is incorrect")));
      }
    } else {
      if (android_info.version.sdkInt <= 32) {
        RequestAccepted = await Permission.storage.request().isGranted;
      } else {
        RequestAccepted = await Permission.photos.request().isGranted;
      }

      if (RequestAccepted) {
        if (isConnected) {
          setState(() {
            isDownloading = true;
          });

          await Services()
              .DownloadFile(url: widget.url, filename: widget.fileName, (path) {
            ScaffoldMessenger.of(widget.context)
                .showSnackBar(SnackBar(content: Text(path)));
          }, onDownloadError: () {
            ScaffoldMessenger.of(widget.context)
                .showSnackBar(const SnackBar(content: Text("Download failed")));
          });

          setState(() {
            isDownloading = false;
          });
        } else {
          if (widget.context.mounted) {
            ScaffoldMessenger.of(widget.context).showSnackBar(
                const SnackBar(content: Text("No Internet Connection")));
          }
        }
      } else {
        if (widget.context.mounted) {
          ScaffoldMessenger.of(widget.context).showSnackBar(
              const SnackBar(content: Text("Storage permission denied")));
        }
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    double w = MediaQuery.sizeOf(widget.context).width;

    return isDownloading
        ? Padding(
            padding: EdgeInsets.symmetric(horizontal: w * .03),
            child: Lottie.asset(
                widget.blackDownloading
                    ? "assets/lottie/DownloadBlack.json"
                    : "assets/lottie/Download.json",
                height: w * .053,
                width: w * .055),
          )
        : IconButton(
            onPressed: _download,
            icon: Icon(Icons.file_download_outlined,
                color: widget.color, size: w * .07));
  }
}
