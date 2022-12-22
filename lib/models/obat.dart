import 'package:flutter/material.dart';

class Obat {
  String id, nama_obat, guna, jenis, sampul, slug;
  DateTime createdAt, updatedAt;

  Obat({
    @required this.id,
    @required this.nama_obat,
    @required this.guna,
    @required this.jenis,
    @required this.createdAt,
    this.updatedAt,
  });
}
