import 'dart:io';
import 'dart:ui';
import 'package:http/http.dart';

import '../constants&variables/constants.dart';
import '../resources/information_repository.dart';

class Services{

  Future<void> DownloadFile({
    required final String url,
    required final String filename,
    final VoidCallback? onDownloadCompleted,
    final VoidCallback? onDownloadError,
  }) async{
    String path = "/storage/emulated/0/Download/$filename.pdf";
    File file = File(path);
    Response res = await get(Uri.parse(url));

    await file.writeAsBytes(res.bodyBytes);

    if(res.statusCode==200 && file.existsSync()) {
      onDownloadCompleted != null? onDownloadCompleted() : onDownloadCompleted;
    }

    else{
      onDownloadError != null? onDownloadError() : onDownloadError;
    }
  }
}