import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:sanitasi/models/mDesa.dart';
import 'package:sanitasi/models/mKantor.dart';

class Desa extends StatefulWidget {
  final Kantors nokant;
  Desa(this.nokant);
  @override
  _DesaState createState() => _DesaState();
}

class _DesaState extends State<Desa> {
  List<Desaku> _list = [];
  List<Desaku> _search = [];

  var loading = false;
  Future<List> fetchdata() async {
    setState(() {
      loading = true;
    });
    _list.clear();
    final response =
        await http.post("http://192.168.100.15/crudflutter/getdesa.php");
    if (response.statusCode == 200) {
      print(response.body);
      final data = jsonDecode(response.body);
      setState(() {
        for (Map i in data) {
          _list.add(Desaku.fromJson(i));

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
      if (f.nokant.contains(text) ||
          f.iddesa.contains(text) ||
          f.nmdesa.contains(text)) _search.add(f);
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
      appBar: AppBar(
        title: Text("Data Desa"),
      ),
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
                                      title: Text(b.iddesa),
                                      subtitle: Text(b.nmdesa),
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
                                  onTap: () {},
                                  child: Card(
                                    child: ListTile(
                                      title: Text(a.nokant),
                                      subtitle: Text(a.nmdesa),
                                      leading: Icon(Icons.business),
                                      trailing: Icon(Icons.arrow_forward_ios),
                                    ),
                                  ),
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
