import 'dart:async';
import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;

void main() {
  runApp(MaterialApp(
    home: Desa1(),
  ));
}

class Desa1 extends StatefulWidget {
  final List list;
  int index;
  Desa1({this.index, this.list});
  @override
  _Desa1State createState() => _Desa1State();
}

class _Desa1State extends State<Desa1> {
  Future<List> getDesa() async {
    final response = await http.post(
        "http://192.168.1.110/crudflutter/getdesa.php",
        body: {"nokant": widget.list[widget.index]['nokant']});
    return json.decode(response.body);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Data Desa"),
      ),
    );
  }
}

class LisDesa extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Container();
  }
}
