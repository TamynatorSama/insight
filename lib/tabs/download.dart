import 'dart:io';
import 'dart:isolate';
import 'dart:ui';

import 'package:flutter/material.dart';
import 'package:flutter_downloader/flutter_downloader.dart';
import 'package:insight1/logic/apicall.dart';
import 'package:http/http.dart' as http;
import 'package:path_provider/path_provider.dart';
import 'package:permission_handler/permission_handler.dart';

class Download extends StatefulWidget {
  const Download({Key? key}) : super(key: key);

  @override
  State<Download> createState() => _DownloadState();
}

class _DownloadState extends State<Download> {
  ReceivePort port = ReceivePort();

  static downloadingCallback(id, status, progress) {
    SendPort? send = IsolateNameServer.lookupPortByName("down");
    send?.send([id, status, progress]);
  }

  @override
  void initState() {
    super.initState();
    FlutterDownloader.registerCallback(downloadingCallback);
    port.listen((message) {});
    IsolateNameServer.registerPortWithName(port.sendPort, "down");
  }

  getQuiz() async {
    var list = await HttpReq.request.getquiz();
    return list;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        backgroundColor: Colors.black,
        body: Center(
          child: IconButton(
              onPressed: () async {
                var status = await Permission.storage.request();
                final externalDir = await getExternalStorageDirectories();
                if (status.isGranted) {
                  var response = await http.get(Uri.parse(
                      'https://image.tmdb.org/t/p/w500/8H64YmIYxpRJgSTuLUGRUSyi2kN.jpg'));
                  var file = File("${externalDir![0].path}/go.png'");
                  file.writeAsBytesSync(response.bodyBytes);
                } else {
                  return;
                }
              },
              icon: const Icon(
                Icons.download,
                color: Colors.white,
                size: 48,
              )),
        ));
  }
}
