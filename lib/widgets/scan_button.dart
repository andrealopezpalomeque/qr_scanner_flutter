import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:qr_scanner/providers/scan_list_provider.dart';

class ScanButton extends StatelessWidget {
  const ScanButton({super.key});

  @override
  Widget build(BuildContext context) {
    return FloatingActionButton(
        elevation: 0,
        child: const Icon(Icons.qr_code_scanner),
        onPressed: () async {
          final barcodeScanRes = 'https://fernando-herrera.com';

          final scanListProvider =
              Provider.of<ScanListProvider>(context, listen: false);
          scanListProvider.nuevoScan(barcodeScanRes);
          scanListProvider
              .nuevoScan('geo:40.724233047051705,-74.00731459101564');
        });
  }
}
