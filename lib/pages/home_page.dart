import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:qrreader/pages/directions_page.dart';
import 'package:qrreader/pages/maps_page.dart';
import 'package:qrreader/providers/db_provider.dart';
import 'package:qrreader/providers/scan_list_provider.dart';
import 'package:qrreader/providers/ui_provider.dart';
import 'package:qrreader/widgets/custom_navigatorbar.dart';
import 'package:qrreader/widgets/scan_button.dart';

class HomePage extends StatelessWidget {
  const HomePage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Historial'),
        actions: [
          IconButton(
              onPressed: () {
                Provider.of<ScanListProvider>(context, listen: false)
                    .eraseAll();
              },
              icon: const Icon(Icons.delete_forever))
        ],
      ),
      body: const MapsPage(),
      bottomNavigationBar: const CustomNavigatorBar(),
      floatingActionButton: const ScanButton(),
      floatingActionButtonLocation: FloatingActionButtonLocation.centerDocked,
    );
  }
}

class _HomePageBody extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final uiProvider = Provider.of<UiProvider>(context);
    final currentIndex = uiProvider.selectedMenuOpt;
    final scanListProvider =
        Provider.of<ScanListProvider>(context, listen: false);

    DBProvider.db.getAllScans().then((scan) => print(scan));

    switch (currentIndex) {
      case 0:
        scanListProvider.loadScansByType('geo');
        return const MapsPage();

      case 1:
        scanListProvider.loadScansByType('http');
        return const DirectionsPage();

      default:
        return const MapsPage();
    }
  }
}
