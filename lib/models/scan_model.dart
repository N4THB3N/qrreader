// To parse this JSON data, do
//
//     final ScanModel = ScanModelFromJson(jsonString);

import 'dart:convert';

import 'package:google_maps_flutter/google_maps_flutter.dart' show LatLng;

ScanModel ScanModelFromJson(String str) => ScanModel.fromJson(json.decode(str));

String ScanModelToJson(ScanModel data) => json.encode(data.toJson());

class ScanModel {
  ScanModel({
    this.id,
    this.tipo,
    required this.valor,
  }) {
    if (this.valor!.contains('http')) {
      this.valor = 'http';
    } else {
      this.valor = 'geo';
    }
  }

  int? id;
  String? tipo;
  String valor;

  LatLng getLatLng() {
    final latlng = this.valor.substring(4).split(',');
    final lat = double.parse(latlng[0]);
    final lng = double.parse(latlng[1]);

    return LatLng(lat, lng);
  }

  factory ScanModel.fromJson(Map<String, dynamic> json) => ScanModel(
        id: json["id"],
        tipo: json["tipo"],
        valor: json["valor"],
      );

  Map<String, dynamic> toJson() => {
        "id": id,
        "tipo": tipo,
        "valor": valor,
      };
}
