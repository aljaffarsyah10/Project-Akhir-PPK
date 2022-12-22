import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:provider/provider.dart';

import '../providers/obat.dart';
import '../pages/edit_obat_page.dart';

class ObatItem extends StatelessWidget {
  final String id, nama_obat, jenis, guna;

  final DateTime updatedAt;

  ObatItem(this.id, this.nama_obat, this.jenis, this.guna, this.updatedAt);

  @override
  Widget build(BuildContext context) {
    var prov = Provider.of<Obatan>(context, listen: false);
    String date = DateFormat.yMMMd().add_Hms().format(updatedAt);
    return ListTile(
      onTap: () {
        Navigator.pushNamed(context, EditObatPage.route, arguments: id);
      },
      leading: CircleAvatar(
        child: Padding(
          padding: const EdgeInsets.all(5),
          child: FittedBox(
            child: Text("\$$jenis"),
          ),
        ),
      ),
      title: Text("$nama_obat"),
      subtitle: Text("Last Edited : $date"),
      trailing: IconButton(
        icon: Icon(Icons.delete),
        onPressed: () {
          prov.deleteObat(id);
        },
      ),
    );
  }
}
