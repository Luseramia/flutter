import 'dart:io';
import 'package:flutter/material.dart';
import 'package:flutter/material.dart';
import 'package:qr_flutter/qr_flutter.dart';
import 'package:qr_code_scanner/qr_code_scanner.dart';

class QRsaner extends StatefulWidget {
  QRsaner({required this.hour, required this.actName});
  String actName;
  String hour;
  @override
  State<QRsaner> createState() => _QRsanerState();
}

class _QRsanerState extends State<QRsaner> {
  final qrKey = GlobalKey(debugLabel: 'QR');
  QRViewController? controller;
  Barcode? barcode;
  @override
  void dispose() {
    controller?.dispose();
    super.dispose();
  }

  @override
  void ressemble() async {
    super.reassemble();

    if (Platform.isAndroid) {
      await controller!.pauseCamera();
    }
    controller!.resumeCamera();
  }

  @override
  Widget build(BuildContext context) => SafeArea(
          child: Scaffold(
        body: Stack(
          alignment: Alignment.center,
          children: <Widget>[
            buildQrview(context),
            Positioned(
                top: MediaQuery.of(context).size.height * 0.1,
                child: actname()),
            // Positioned(bottom: 100, child: buildResult()),
            Positioned(top: 10, child: buildControlButtons()),
            Positioned(bottom: 40, child: checkhour()),
            Positioned(
                bottom: MediaQuery.of(context).size.width * 0.3,
                child: barcode != null ? check() : Container()),
          ],
        ),
      ));

  Widget buildControlButtons() => Container(
        padding: EdgeInsets.symmetric(horizontal: 16),
        decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(8), color: Colors.white24),
        child: Row(
          mainAxisSize: MainAxisSize.max,
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: <Widget>[
            IconButton(
                onPressed: () async {
                  await controller?.toggleFlash();
                  setState(() {});
                },
                icon: FutureBuilder<bool?>(
                  future: controller?.getFlashStatus(),
                  builder: (context, snapshot) {
                    if (snapshot.data != null) {
                      return Icon(
                          snapshot.data! ? Icons.flash_on : Icons.flash_off);
                    } else {
                      return Container();
                    }
                  },
                )),
            IconButton(
                onPressed: () async {
                  await controller?.flipCamera();
                  setState(() {});
                },
                icon: FutureBuilder(
                  future: controller?.getCameraInfo(),
                  builder: (context, snapshot) {
                    if (snapshot.data != null) {
                      return Icon(Icons.switch_camera);
                    } else {
                      return Container();
                    }
                  },
                )),
          ],
        ),
      );

  // Widget buildResult() => Container(
  //       padding: EdgeInsets.all(12),
  //       decoration: BoxDecoration(
  //           color: Colors.white24, borderRadius: BorderRadius.circular(8)),
  //       child: Text(
  //         barcode != null ? 'Result : ${barcode!.code}' : "scan a code",
  //         maxLines: 3,
  //       ),
  //     );

  Widget actname() => Container(
        padding: EdgeInsets.all(12),
        decoration: BoxDecoration(
            color: Color.fromARGB(207, 175, 238, 3),
            borderRadius: BorderRadius.circular(8)),
        height: 70,
        width: MediaQuery.of(context).size.width * 0.7,
        child: Center(
          child: Text(
            widget.actName,
            maxLines: 3,
            style: TextStyle(color: Colors.red),
          ),
        ),
      );
  Widget checkhour() => Container(
        height: 70,
        width: 70,
        decoration: BoxDecoration(
            color: Colors.red[50], borderRadius: BorderRadius.circular(70)),
        child: Center(child: Text("press")),
      );

  Widget check() =>
      OutlinedButton(onPressed: () {}, child: Icon(Icons.check_box));

  Widget buildQrview(BuildContext context) => QRView(
        key: qrKey,
        onQRViewCreated: onQRViewCreated,
        overlay: QrScannerOverlayShape(
          cutOutWidth: MediaQuery.of(context).size.width * 0.8,
          cutOutHeight: MediaQuery.of(context).size.height * 0.4,
          borderWidth: 10,
          borderLength: 30,
          borderRadius: 10,
          borderColor: Theme.of(context).primaryColor,
        ),
      );

  void onQRViewCreated(QRViewController controller) {
    setState(() => this.controller = controller);

    controller.scannedDataStream
        .listen((barcode) => setState(() => this.barcode = barcode));
  }
}
