import 'dart:async';
import 'dart:convert';

import 'package:autentikasi/pages/side_navbar.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:provider/provider.dart';
import '../providers/auth.dart';

class Obat {
  final String id;
  final String nama_obat;
  final String slug;
  final String guna;
  final String jenis;
  final String sampul;

  Obat(
      {this.id, this.nama_obat, this.slug, this.guna, this.jenis, this.sampul});

  factory Obat.fromJson(Map<String, dynamic> json) {
    return Obat(
      id: json['id'],
      nama_obat: json['nama_obat'],
      slug: json['slug'],
      guna: json['guna'],
      jenis: json['jenis'],
      sampul: json['sampul'],
    );
  }
}

class DaftarObatView extends StatelessWidget {
  static const route = "daftar_obatview";

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      drawer: SideNavbar(),
      appBar: AppBar(
        // leading: IconButton(
        //   icon: Icon(Icons.logout),
        //   onPressed: () => Provider.of<Auth>(context, listen: false).logout(),
        // ),
        title: Text("Medicine Cabinet"),
        actions: [
          IconButton(
            icon: Icon(Icons.logout),
            onPressed: () => Provider.of<Auth>(context, listen: false).logout(),
          ),
        ],
      ),
      body: FutureBuilder<List<Obat>>(
        future: _fetchObats(),
        builder: (context, snapshot) {
          if (snapshot.hasData) {
            List<Obat> data = snapshot.data;
            return _obatsListView(data);
          } else if (snapshot.hasError) {
            return Text("${snapshot.error}");
          }
          return CircularProgressIndicator();
        },
      ),
    );
  }

  Future<List<Obat>> _fetchObats() async {
    final obatsListAPIUrl =
        'https://oktagilangweb.000webhostapp.com/webservice/obat';
    final response = await http.get(Uri.parse(obatsListAPIUrl));

    if (response.statusCode == 200) {
      List jsonResponse = json.decode(response.body);
      return jsonResponse.map((obat) => new Obat.fromJson(obat)).toList();
    } else {
      throw Exception('Failed to load obats from API');
    }
  }

  ListView _obatsListView(data) {
    return ListView.builder(
        itemCount: data.length,
        itemBuilder: (context, index) {
          // return _tile(data[index].nama_obat, data[index].jenis, Icons.work);
          return _tile(data[index].nama_obat, data[index].jenis,
              data[index].guna, data[index].sampul, data[index].slug);
        });
  }

  // ListTile _tile(String title, String subtitle, IconData icon) => ListTile(
  ListTile _tile(String title, String subtitle, String guna, String sampul,
          String slug) =>
      ListTile(
        title: Text(title,
            style: TextStyle(
              fontWeight: FontWeight.w500,
              fontSize: 20,
            )),
        subtitle: Text(subtitle + " - " + guna),
        leading: CircleAvatar(
          backgroundImage: AssetImage('assets/images/' +
              sampul), // no matter how big it is, it won't overflow
        ),
        tileColor: Colors.white,
        onTap: () {
          // Navigator.pop(context);
        },
        trailing: IconButton(
          icon: Icon(Icons.medication),
          onPressed: () {
            // prov.deleteObat(id);
          },
        ),
        // Icon(
        //   icon,
        //   color: Colors.blue[500],
        // ),
      );
}
