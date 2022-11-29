import 'dart:io';

import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:movienight/models/order.dart';
import 'package:movienight/models/ordersStore.dart';
import 'package:movienight/screens/success_delivered.dart';
import 'package:provider/provider.dart';
import 'package:movienight/models/CartStore.dart';
import 'package:qr_code_scanner/qr_code_scanner.dart';

import '../utils/app_routes.dart';

class QrCodeScanner extends StatefulWidget {
  const QrCodeScanner({Key? key}) : super(key: key);

  @override
  State<QrCodeScanner> createState() => _QrCodeScannerState();
}

class _QrCodeScannerState extends State<QrCodeScanner> {
  final GlobalKey qrKey = GlobalKey(debugLabel: 'QR');
  Barcode? result;
  QRViewController? controller;

  // In order to get hot reload to work we need to pause the camera if the platform
  // is android, or resume the camera if the platform is iOS.
  @override
  void reassemble() {
    super.reassemble();
    if (Platform.isAndroid) {
      controller!.pauseCamera();
    } else if (Platform.isIOS) {
      controller!.resumeCamera();
    }
  }

  @override
  Widget build(BuildContext context) {
    if (ModalRoute.of(context)!.settings.arguments == Null) {}
    final arguments = ModalRoute.of(context)!.settings.arguments as Order;

    _onQRViewCreated(QRViewController controller) async {
      this.controller = controller;
      controller.scannedDataStream.listen((scanData) async {
        print(result == null);
        if (arguments.id == scanData.code && result == null) {
          setState(() {
            result = scanData;
          });
          OrdersStore.updateOrder(arguments);
          Navigator.of(context).pushNamed(AppRoutes.DELIVERED_SUCCESS);
        }
      });
    }

    return Scaffold(
      body: Column(
        children: <Widget>[
          Expanded(
            flex: 5,
            child: QRView(
              key: qrKey,
              onQRViewCreated: _onQRViewCreated,
            ),
          ),
        ],
      ),
    );
  }

  @override
  void dispose() {
    controller?.dispose();
    super.dispose();
  }
}
