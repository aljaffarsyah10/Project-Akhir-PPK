import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../providers/obat.dart';

class AddObatPage extends StatelessWidget {
  static const route = "/add-obat";

  final TextEditingController nama_obatController = TextEditingController();
  final TextEditingController jenisController = TextEditingController();
  final TextEditingController gunaController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    void save(String nama_obat, String jenis, String guna) {
      try {
        Provider.of<Obatan>(context, listen: false)
            .addObat(nama_obat, jenis, guna)
            .then((value) => Navigator.pop(context));
      } catch (err) {
        showDialog(
          context: context,
          builder: (context) {
            return AlertDialog(
              title: Text("Error Occured"),
              content: Text("Error : $err"),
              actions: [
                TextButton(
                  onPressed: () => Navigator.pop(context),
                  child: Text("OKAY"),
                ),
              ],
            );
          },
        );
      }
    }

    return Scaffold(
      appBar: AppBar(
        title: Text("Add Obat"),
        actions: [
          IconButton(
            icon: Icon(Icons.save),
            onPressed: () => save(nama_obatController.text,
                jenisController.text, gunaController.text),
          ),
        ],
      ),
      body: Padding(
        padding: const EdgeInsets.all(20),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Column(
              children: [
                TextField(
                  autocorrect: false,
                  autofocus: true,
                  controller: nama_obatController,
                  textInputAction: TextInputAction.next,
                  decoration: InputDecoration(
                    labelText: "Obat Name",
                    border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(15),
                    ),
                  ),
                ),
                SizedBox(height: 20),
                TextField(
                  autocorrect: false,
                  controller: jenisController,
                  textInputAction: TextInputAction.next,
                  decoration: InputDecoration(
                    labelText: "Jenis",
                    border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(15),
                    ),
                  ),
                ),
                SizedBox(height: 20),
                TextField(
                  autocorrect: false,
                  controller: gunaController,
                  textInputAction: TextInputAction.next,
                  decoration: InputDecoration(
                    labelText: "Guna",
                    border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(15),
                    ),
                  ),
                ),
              ],
            ),
            Container(
              width: double.infinity,
              margin: EdgeInsets.only(bottom: 30),
              child: ElevatedButton(
                onPressed: () => save(nama_obatController.text,
                    jenisController.text, gunaController.text),
                child: Text(
                  "Save",
                  style: TextStyle(
                    fontSize: 18,
                  ),
                ),
                style: ElevatedButton.styleFrom(
                  padding: EdgeInsets.symmetric(vertical: 15),
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(100),
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
