import 'package:flutter_barcode_scanner/flutter_barcode_scanner.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:qrreader/providers/scan_list_provider.dart';
import 'package:qrreader/utils/utils.dart';

class ScanButton extends StatelessWidget {
  const ScanButton({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return FloatingActionButton(
      elevation: 0,
      onPressed: () async {
        String barcodeScanRes = await FlutterBarcodeScanner.scanBarcode(
            '#3D8BEF', 'Cancel', false, ScanMode.QR);
        // String barcodeScanRes = 'geo:45.280089,-75.922405';

        if (barcodeScanRes == "-1") {
          return;
        }

        final scanListProvider =
            Provider.of<ScanListProvider>(context, listen: false);
        final newScan = await scanListProvider.newScan(barcodeScanRes);
        launchURL(context, newScan);
      },
      child: const Icon(Icons.filter_center_focus),
    );
  }
}
