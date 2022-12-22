import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:intl/intl.dart';

import '../models/obat.dart';

class Obatan with ChangeNotifier {
  String token, userId;

  void updateData(tokenData, uid) {
    token = tokenData;
    userId = uid;
    notifyListeners();
  }

  String urlMaster = "https://oktagilangweb.000webhostapp.com/webservice/obat/";
  List<Obat> _allObat = [];

  List<Obat> get allObat => _allObat;

  Future<void> addObat(String nama_obat, String jenis, String guna) async {
    Uri url = Uri.parse("$urlMaster");
    DateTime dateNow = DateTime.now();
    try {
      var response = await http.post(
        url,
        body: json.encode({
          "nama_obat": nama_obat,
          "jenis": jenis,
          "guna": guna,
          "createdAt": dateNow.toString(),
          "updatedAt": dateNow.toString(),
          "userId": userId,
        }),
      );

      if (response.statusCode > 300 || response.statusCode < 200) {
        throw (response.statusCode);
      } else {
        Obat data = Obat(
          id: json.decode(response.body)["name"].toString(),
          nama_obat: nama_obat,
          jenis: jenis,
          guna: guna,
          createdAt: dateNow,
          updatedAt: dateNow,
        );

        _allObat.add(data);
        notifyListeners();
      }
    } catch (err) {
      throw (err);
    }
  }

  void editObat(String id, String nama_obat, String jenis, String guna) async {
    Uri url = Uri.parse("$urlMaster");
    DateTime date = DateTime.now();
    try {
      var response = await http.patch(
        url,
        body: json.encode({
          "nama_obat": nama_obat,
          "jenis": jenis,
          "guna": guna,
          "updatedAt": date.toString(),
        }),
      );

      if (response.statusCode > 300 || response.statusCode < 200) {
        throw (response.statusCode);
      } else {
        Obat edit = _allObat.firstWhere((element) => element.id == id);
        edit.nama_obat = nama_obat;
        edit.jenis = jenis;
        edit.guna = guna;
        edit.updatedAt = date;
        notifyListeners();
      }
    } catch (err) {
      throw (err);
    }
  }

  void deleteObat(String id) async {
    Uri url = Uri.parse("$urlMaster");

    try {
      var response = await http.delete(url);

      if (response.statusCode > 300 || response.statusCode < 200) {
        throw (response.statusCode);
      } else {
        _allObat.removeWhere((element) => element.id == id);
        notifyListeners();
      }
    } catch (err) {
      throw (err);
    }
  }

  Obat selectById(String id) {
    return _allObat.firstWhere((element) => element.id == id);
  }

  Future<void> inisialData() async {
    _allObat = [];
    Uri url = Uri.parse(
        '$urlMaster/products.json?auth=$token&orderBy="userId"&equalTo="$userId"');

    try {
      var response = await http.get(url);

      print(response.statusCode);

      if (response.statusCode >= 300 && response.statusCode < 200) {
        throw (response.statusCode);
      } else {
        var data = json.decode(response.body) as Map<String, dynamic>;
        if (data != null) {
          data.forEach(
            (key, value) {
              Obat obat = Obat(
                id: key,
                nama_obat: value["nana_obat"],
                jenis: value["jenis"],
                createdAt:
                    DateFormat("yyyy-mm-dd hh:mm:ss").parse(value["createdAt"]),
                updatedAt:
                    DateFormat("yyyy-mm-dd hh:mm:ss").parse(value["updatedAt"]),
              );
              _allObat.add(obat);
            },
          );
        }
      }
    } catch (err) {
      throw (err);
    }
  }
}
