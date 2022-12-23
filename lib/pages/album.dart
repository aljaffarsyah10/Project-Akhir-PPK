import 'dart:async';
import 'dart:convert';

import 'package:autentikasi/pages/side_navbar.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:provider/provider.dart';
import '../providers/auth.dart';

Future<Album> fetchAlbum() async {
  final response = await http.get(
      Uri.parse('https://oktagilangweb.000webhostapp.com/webservice/user/131'));

// Dispatch action depending upon
//the server response
  if (response.statusCode == 200) {
    return Album.fromJson(json.decode(response.body));
  } else {
    throw Exception('Failed to load album');
  }
}

Future<Album> updateAlbum(
    String username, String address, String fullname) async {
  final http.Response response = await http.post(
    // Uri.parse('https://jsonplaceholder.typicode.com/albums/1'),
    Uri.parse(
        'https://oktagilangweb.000webhostapp.com/webservice/updateUser/131'),
    // headers: <String, String>{
    //   'Content-Type': 'application/json; charset=UTF-8',
    // },
    body: jsonEncode(<String, String>{
      'username': username,
      'address': address,
      'fullname': fullname,
    }),
  );

// parsing JSOn or throwing an exception
  if (response.statusCode == 200) {
    return Album.fromJson(json.decode(response.body));
  } else {
    throw Exception('Failed to update album.');
  }
}

class Album {
  final String id;
  final String username, email, fullname, address, user_image;

  Album(
      {@required this.id,
      @required this.username,
      this.email,
      this.fullname,
      this.address,
      this.user_image});

  factory Album.fromJson(Map<String, dynamic> json) {
    return Album(
      id: json['id'],
      username: json['username'],
      email: json['email'],
      fullname: json['fullname'],
      address: json['address'],
      user_image: json['user_image'],
    );
  }
}

class albumPage extends StatefulWidget {
  static const route = "/list_album";

  @override
  _albumState createState() => _albumState();
}

class _albumState extends State<albumPage> {
  final TextEditingController _controllerUsername = TextEditingController();
  final TextEditingController _controllerAddress = TextEditingController();
  final TextEditingController _controllerNama = TextEditingController();
  Future<Album> _futureAlbum;

  @override
  void initState() {
    super.initState();
    _futureAlbum = fetchAlbum();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      drawer: SideNavbar(),
      appBar: AppBar(
        title: Text("Profile"),
        actions: [
          IconButton(
            icon: Icon(Icons.logout),
            onPressed: () => Provider.of<Auth>(context, listen: false).logout(),
          ),
        ],
      ),
      body: SingleChildScrollView(
        child: Container(
          color: Color.fromARGB(255, 242, 240, 231),
          width: MediaQuery.of(context).size.width,
          // padding: EdgeInsets.fromLTRB(40.0, 20, 40, 70),
          alignment: Alignment.center,
          padding: const EdgeInsets.all(8.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.center,
            children: <Widget>[
              SizedBox(
                height: 2,
              ),
              Container(
                width: MediaQuery.of(context).size.width,
                child: Text(
                  'My Profile',
                  style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold),
                ),
              ),
              SizedBox(
                height: 10,
              ),
              Container(
                  width: 100,
                  height: 100,
                  decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(75),
                      boxShadow: <BoxShadow>[
                        BoxShadow(
                            offset: Offset(10, 15),
                            color: Color(0x22000000),
                            blurRadius: 20.0)
                      ],
                      image: DecorationImage(
                          image: AssetImage('assets/images/okta.jpeg')))
                  // NetworkImage(
                  //     'https://store.playstation.com/store/api/chihiro/00_09_000/container/US/en/999/UP1018-CUSA00133_00-AV00000000000015/1553561653000/image?w=256&h=256&bg_color=000000&opacity=100&_version=00_09_000'))),
                  ),
              SizedBox(
                height: 30,
              ),
              FutureBuilder<Album>(
                future: _futureAlbum,
                builder: (context, snapshot) {
                  if (snapshot.connectionState == ConnectionState.done) {
                    if (snapshot.hasData) {
                      return Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: <Widget>[
                          Text(
                            snapshot.data.username,
                            style: TextStyle(
                                fontSize: 30, fontWeight: FontWeight.bold),
                            textAlign: TextAlign.center,
                          ),
                          Text(
                            snapshot.data.email,
                            style: TextStyle(
                                fontSize: 20, fontWeight: FontWeight.bold),
                            textAlign: TextAlign.center,
                          ),
                          Text(
                            snapshot.data.fullname,
                            style: TextStyle(
                                fontSize: 20, fontWeight: FontWeight.bold),
                            textAlign: TextAlign.center,
                          ),
                          Text(
                            snapshot.data.address,
                            style: TextStyle(
                                fontSize: 20, fontWeight: FontWeight.bold),
                            textAlign: TextAlign.center,
                          ),
                          SizedBox(
                            height: 30,
                          ),
                          // Text(snapshost.data.username),
                          // Divider( color: Colors.black),
                          Text(
                            "Update Profile",
                            style: TextStyle(
                                fontSize: 20, fontWeight: FontWeight.bold),
                            textAlign: TextAlign.center,
                          ),
                          TextField(
                            controller: _controllerUsername,
                            decoration: const InputDecoration(
                                hintText: 'Input Username'),
                          ),
                          TextField(
                            controller: _controllerNama,
                            decoration:
                                const InputDecoration(hintText: 'Input Nama'),
                          ),
                          TextField(
                            controller: _controllerAddress,
                            decoration:
                                const InputDecoration(hintText: 'Input Alamat'),
                          ),
                          ElevatedButton(
                            child: const Text('Update Data'),
                            onPressed: () {
                              setState(() {
                                _futureAlbum = updateAlbum(
                                    _controllerUsername.text == ""
                                        ? snapshot.data.username
                                        : _controllerUsername.text,
                                    _controllerAddress.text == ""
                                        ? snapshot.data.address
                                        : _controllerAddress.text,
                                    _controllerNama.text == ""
                                        ? snapshot.data.fullname
                                        : _controllerNama.text);
                              });
                            },
                          )
                        ],
                      );
                    } else if (snapshot.hasError) {
                      return Text("${snapshot.error}");
                    }
                  }
                  return const CircularProgressIndicator();
                },
              ),
            ],
          ),
        ),
      ),
    );
  }
}
