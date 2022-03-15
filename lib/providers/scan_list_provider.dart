import 'package:flutter/material.dart';
import 'package:qrreader/models/scan_model.dart';
import 'package:qrreader/providers/db_provider.dart';

class ScanListProvider extends ChangeNotifier {
  List<ScanModel> scans = [];
  String selectedType = 'http';

  Future<ScanModel> newScan(String valor) async {
    final newScan = ScanModel(valor: valor);
    final id = await DBProvider.db.newScan(newScan);
    // Assign the database id to the model
    newScan.id = id;

    if (this.selectedType == newScan.tipo) {
      this.scans.add(newScan);
      notifyListeners();
    }

    return newScan;
  }

  loadScans() async {
    final scans = await DBProvider.db.getAllScans();
    this.scans = [...scans];
    notifyListeners();
  }

  loadScansByType(String type) async {
    final scans = await DBProvider.db.getAllScans();
    this.scans = [...scans];
    this.selectedType = type;
    notifyListeners();
  }

  eraseAll() async {
    await DBProvider.db.deleteAllScans();
    this.scans = [];
    notifyListeners();
  }

  eraseById(int id) async {
    await DBProvider.db.deleteScan(id);
    notifyListeners();
  }
}
