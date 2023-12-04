import 'package:flutter/material.dart';

class ScanButton extends StatelessWidget {
  const ScanButton({super.key});

  @override
  Widget build(BuildContext context) {
    return FloatingActionButton(
        elevation: 0,
        child: const Icon(Icons.qr_code_scanner),
        onPressed: () async {
          final barcodeScanRes = 'https://fernando-herrera.com';
          // String barcodeScanRes = await FlutterBarcodeScanner.scanBarcode(
          //   "#3D8BEF", "Cancelar", false, ScanMode.QR);
          print(barcodeScanRes);
        });
  }
}
