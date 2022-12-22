import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../providers/obat.dart';
import '../providers/auth.dart';

import '../pages/add_obat_page.dart';
import '../widgets/obat_item.dart';
import 'side_navbar.dart';

class ListObatPage extends StatefulWidget {
  static const route = "/list_obat";

  @override
  _ListObatState createState() => _ListObatState();
}

class _ListObatState extends State<ListObatPage> {
  bool isInit = true;
  bool isLoading = false;
  @override
  void didChangeDependencies() {
    if (isInit) {
      isLoading = true;
      Provider.of<Obatan>(context, listen: false).inisialData().then((value) {
        setState(() {
          isLoading = false;
        });
      }).catchError(
        (err) {
          print(err);
          showDialog(
            context: context,
            builder: (context) {
              return AlertDialog(
                title: Text("Error Occured"),
                content: Text(err.toString()),
                actions: [
                  TextButton(
                    onPressed: () {
                      setState(() {
                        isLoading = false;
                      });
                      Navigator.pop(context);
                    },
                    child: Text("Okay"),
                  ),
                ],
              );
            },
          );
        },
      );

      isInit = false;
    }
    super.didChangeDependencies();
  }

  @override
  Widget build(BuildContext context) {
    final prov = Provider.of<Obatan>(context);

    return Scaffold(
      drawer: SideNavbar(),
      appBar: AppBar(
        // leading: IconButton(
        //   icon: Icon(Icons.logout),
        //   onPressed: () => Provider.of<Auth>(context, listen: false).logout(),
        // ),
        title: Text("All Obat"),
        actions: [
          IconButton(
            icon: Icon(Icons.logout),
            onPressed: () => Provider.of<Auth>(context, listen: false).logout(),
          ),
          IconButton(
            icon: Icon(Icons.add),
            onPressed: () => Navigator.pushNamed(context, AddObatPage.route),
          ),
        ],
      ),
      body: (isLoading)
          ? Center(
              child: CircularProgressIndicator(),
            )
          : (prov.allObat.length == 0)
              ? Center(
                  child: Text(
                    "No Data",
                    style: TextStyle(
                      fontSize: 25,
                    ),
                  ),
                )
              : ListView.builder(
                  itemCount: prov.allObat.length,
                  itemBuilder: (context, i) => ObatItem(
                    prov.allObat[i].id,
                    prov.allObat[i].nama_obat,
                    prov.allObat[i].guna,
                    prov.allObat[i].jenis,
                    prov.allObat[i].updatedAt,
                  ),
                ),
    );
  }
}
