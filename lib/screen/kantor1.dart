import 'dart:async';
import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:sanitasi/screen/desa1.dart';

void main() {
  runApp(MaterialApp(
    home: Kantor1(),
  ));
}

class Kantor1 extends StatefulWidget {
  @override
  _Kantor1State createState() => _Kantor1State();
}

class _Kantor1State extends State<Kantor1> {
  Future<List> getData() async {
    final response =
        await http.get("http://192.168.1.110/crudflutter/getkantor.php");
    return json.decode(response.body);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: FutureBuilder<List>(
        future: getData(),
        builder: (context, snapshot) {
          if (snapshot.hasError) print(snapshot.error);
          return snapshot.hasData
              ? LisKantor(
                  list: snapshot.data,
                )
              : Center(
                  child: CircularProgressIndicator(),
                );
        },
      ),
    );
  }
}

class LisKantor extends StatelessWidget {
  final List list;
  LisKantor({this.list});

  @override
  Widget build(BuildContext context) {
    return ListView.builder(
      itemCount: list == null ? 0 : list.length,
      itemBuilder: (context, i) {
        return Container(
          child: GestureDetector(
            child: Card(
              child: ListTile(
                title: Text(list[i]['nokant']),
                leading: Icon(Icons.business),
                subtitle: Text(list[i]['nmkant']),
              ),
            ),
            onTap: () => Navigator.of(context).push(MaterialPageRoute(
                builder: (BuildContext contex) => Desa1(
                      list: list,
                      index: i,
                    ))),
          ),
        );
      },
    );
  }
}
