import 'dart:async';
import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:sanitasi/models/mKantor.dart';
import 'package:sanitasi/screen/desa.dart';

// void main() {
//   runApp(MaterialApp(
//     home: Kantor(),
//   ));
// }

class Kantor extends StatefulWidget {
  @override
  _KantorState createState() => _KantorState();
}

class _KantorState extends State<Kantor> {
  List<Kantors> _list = [];
  List<Kantors> _search = [];
  var loading = false;
  Future<Null> fetchdata() async {
    setState(() {
      loading = true;
    });
    _list.clear();
    final response =
        await http.get("http://192.168.100.15/crudflutter/getkantor.php");
    if (response.statusCode == 200) {
      print(response.body);
      final data = jsonDecode(response.body);
      setState(() {
        for (Map i in data) {
          _list.add(Kantors.fromJson(i));
          loading = false;
        }
      });
    }
  }

  TextEditingController controller = TextEditingController();

  onsearch(String text) async {
    _search.clear();
    if (text.isEmpty) {
      setState(() {});
      return;
    }
    _list.forEach((f) {
      if (f.nmkant.contains(text) || f.nokant.toString().contains(text))
        _search.add(f);
    });
    setState(() {});
  }
  //jika int convert ke String("f.nokant.toString().contains(text)")//

  @override
  void initState() {
    super.initState();
    fetchdata();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      // appBar: AppBar(
      //   title: Text("Data Kantor"),
      // ),
      body: Container(
        decoration: BoxDecoration(
          gradient: LinearGradient(
            begin: Alignment.topRight,
            end: Alignment.bottomLeft,
            colors: [Colors.blue[100], Colors.blue[200]],
          ),
        ),
        padding: EdgeInsets.all(10.0),
        child: Column(
          children: <Widget>[
            Container(
              padding: EdgeInsets.only(top: 30.0),
              color: Colors.transparent,
              child: Card(
                child: ListTile(
                    leading: Icon(Icons.search),
                    title: TextField(
                      controller: controller,
                      onChanged: onsearch,
                      decoration: InputDecoration(
                        hintText: "Cari dengan huruf besar",
                        border: InputBorder.none,
                      ),
                    ),
                    trailing: IconButton(
                      onPressed: () {
                        controller.clear();
                        onsearch("");
                      },
                      icon: Icon(Icons.cancel),
                    )),
              ),
            ),
            loading
                ? Center(
                    child: CircularProgressIndicator(),
                  )
                : Expanded(
                    child: _search.length != 0 || controller.text.isNotEmpty
                        ? ListView.builder(
                            itemCount: _search.length,
                            itemBuilder: (context, i) {
                              final b = _search[i];
                              return Container(
                                padding: EdgeInsets.all(2.0),
                                child: GestureDetector(
                                  onTap: () {},
                                  child: Card(
                                    child: ListTile(
                                      title: Text(b.nokant),
                                      subtitle: Text(b.nmkant),
                                      leading: Icon(Icons.business),
                                      trailing: Icon(Icons.arrow_forward_ios),
                                    ),
                                  ),
                                ),
                              );
                            },
                          )
                        : ListView.builder(
                            itemCount: _list.length,
                            itemBuilder: (context, i) {
                              final a = _list[i];
                              return Container(
                                padding: EdgeInsets.all(2.0),
                                child: GestureDetector(
                                  child: Card(
                                    child: ListTile(
                                      title: Text(a.nokant),
                                      subtitle: Text(a.nmkant),
                                      leading: Icon(Icons.business),
                                      trailing: Icon(Icons.arrow_forward_ios),
                                    ),
                                  ),
                                  onTap: () {
                                    Navigator.of(context).push(
                                        MaterialPageRoute(
                                            builder: (context) => Desa(a)));
                                  },
                                ),
                              );
                            },
                          ),
                  ),
          ],
        ),
      ),
    );
  }
}
