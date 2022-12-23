import 'dart:async';
import 'dart:convert';

import 'package:autentikasi/pages/side_navbar.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:provider/provider.dart';
import '../providers/auth.dart';

class Pasien {
  final String id;
  final String nama;
  final String alamat;
  final String keluhan;

  Pasien({this.id, this.nama, this.alamat, this.keluhan});

  factory Pasien.fromJson(Map<String, dynamic> json) {
    return Pasien(
      id: json['id'],
      nama: json['nama'],
      alamat: json['alamat'],
      keluhan: json['keluhan'],
    );
  }
}

class DaftarPasienView extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      drawer: SideNavbar(),
      appBar: AppBar(
        // leading: IconButton(
        //   icon: Icon(Icons.logout),
        //   onPressed: () => Provider.of<Auth>(context, listen: false).logout(),
        // ),
        title: Text("All Pasien"),
        actions: [
          IconButton(
            icon: Icon(Icons.logout),
            onPressed: () => Provider.of<Auth>(context, listen: false).logout(),
          ),
        ],
      ),
      body: FutureBuilder<List<Pasien>>(
        future: _fetchPasiens(),
        builder: (context, snapshot) {
          if (snapshot.hasData) {
            List<Pasien> data = snapshot.data;
            return _pasiensListView(data);
          } else if (snapshot.hasError) {
            return Text("${snapshot.error}");
          }
          return CircularProgressIndicator();
        },
      ),
    );
  }

  Future<List<Pasien>> _fetchPasiens() async {
    final pasiensListAPIUrl =
        'https://oktagilangweb.000webhostapp.com/webservice/pasien';
    final response = await http.get(Uri.parse(pasiensListAPIUrl));

    if (response.statusCode == 200) {
      List jsonResponse = json.decode(response.body);
      return jsonResponse.map((pasien) => new Pasien.fromJson(pasien)).toList();
    } else {
      throw Exception('Failed to load pasiens from API');
    }
  }

  ListView _pasiensListView(data) {
    return ListView.builder(
        itemCount: data.length,
        itemBuilder: (context, index) {
          // return _tile(data[index].nama_pasien, data[index].jenis, Icons.work);
          return _tile(data[index].nama, data[index].alamat,
              data[index].keluhan, Icons.person);
        });
  }

  // ListTile _tile(String title, String subtitle, IconData icon) => ListTile(
  ListTile _tile(
          String title, String subtitle, String keluhan, IconData icon) =>
      ListTile(
        title: Text(title,
            style: TextStyle(
              fontWeight: FontWeight.w500,
              fontSize: 20,
            )),
        subtitle: Text(keluhan + " - " + subtitle),
        leading: Icon(
          icon,
          color: Colors.blue[500],
        ),
        tileColor: Colors.white,
        onTap: () {
          // Navigator.pop(context);
        },
        trailing: IconButton(
          icon: Icon(Icons.navigate_next_rounded),
          onPressed: () {
            // prov.deletePasien(id);
          },
        ),
      );
}
