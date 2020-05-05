import 'dart:async';
import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:sanitasi/models/mKantor.dart';

class DaftarUser extends StatefulWidget {
  @override
  _DaftarUserState createState() => _DaftarUserState();
}

class _DaftarUserState extends State<DaftarUser> {
  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();
  String username, password, kantor;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        // appBar: AppBar(
        //   title: Text("Registrasi Petugas Survey"),
        //   leading: null,
        // ),
        body: Container(
      decoration: BoxDecoration(
        gradient: LinearGradient(
          begin: Alignment.topRight,
          end: Alignment.bottomLeft,
          colors: [Colors.blue[100], Colors.blue[300]],
        ),
      ),
      child: Form(
        key: _formKey,
        child: Center(
          child: ListView(
            children: <Widget>[
              _logobmi(),
              _logowater(),
              _nama(),
              SizedBox(
                height: 20.0,
              ),
              _email(),
              _userName(),
              _password(),
              Padding(
                padding: EdgeInsets.only(top: 30.0),
              ),
              _btnDaftar(),
              _btnLogin(),
            ],
          ),
        ),
      ),
    ));
  }

  Widget _logobmi() {
    return Hero(
      tag: 'hero',
      child: CircleAvatar(
        backgroundColor: Colors.transparent,
        radius: 72.0,
        child: Image.asset("images/logobmi.png"),
      ),
    );
  }

  Widget _logowater() {
    return Hero(
      tag: 'hero',
      child: CircleAvatar(
        backgroundColor: Colors.transparent,
        radius: 72.0,
        child: Image.asset("images/logowater.png"),
      ),
    );
  }

  Widget _nama() {
    return Padding(
      padding: const EdgeInsets.all(10.0),
      child: TextFormField(
        validator: valNama,
        keyboardType: TextInputType.emailAddress,
        decoration: InputDecoration(
          contentPadding: EdgeInsets.fromLTRB(20.0, 20.0, 20.0, 20.0),
          // border: OutlineInputBorder(borderRadius: BorderRadius.circular(20.0)),
          labelText: "Nama Lengkap",
          icon: Icon(Icons.person),
        ),
      ),
    );
  }

  Widget _userName() {
    return Container(
      padding: EdgeInsets.only(left: 10.0),
      child: Text(
        "* Email anda merupakan username login",
        style: TextStyle(
          color: Colors.redAccent,
        ),
        textAlign: TextAlign.justify,
      ),
    );
  }

  Widget _email() {
    return Padding(
      padding: const EdgeInsets.all(10.0),
      child: TextFormField(
        validator: valEmail,
        keyboardType: TextInputType.emailAddress,
        decoration: InputDecoration(
          contentPadding: EdgeInsets.fromLTRB(20.0, 20.0, 20.0, 20.0),
          // border: OutlineInputBorder(borderRadius: BorderRadius.circular(20.0)),
          labelText: "Email",
          hintText: "email@email.com",
          icon: Icon(Icons.email),
        ),
      ),
    );
  }

  Widget _password() {
    return Padding(
      padding: const EdgeInsets.all(10.0),
      child: TextFormField(
        validator: valPass,
        obscureText: true,
        keyboardType: TextInputType.text,
        decoration: InputDecoration(
          contentPadding: EdgeInsets.fromLTRB(20, 20, 20, 20),
          // border: OutlineInputBorder(borderRadius: BorderRadius.circular(20.0)),
          labelText: "Password",
          hintText: "Enter Password",
          icon: Icon(Icons.vpn_key),
        ),
      ),
    );
  }

  Widget _kantor() {}

  Widget _btnDaftar() {
    return Padding(
      padding: EdgeInsets.all(10.0),
      child: Material(
        borderRadius: BorderRadius.circular(20),
        elevation: 5.0,
        color: Colors.green,
        child: MaterialButton(
          onPressed: null,
          child: Text(
            "Daftar Petugas",
            style: TextStyle(color: Colors.white),
          ),
        ),
      ),
    );
  }

  Widget _btnLogin() {
    return FlatButton(
      onPressed: null,
      child: Text(
        "Sudah Punya Akun, Klik disini",
        style: TextStyle(color: Colors.white60),
      ),
    );
  }

  String valNama(String value) {
    String patttern = r'(^[a-zA-Z ]*$)';
    RegExp regExp = new RegExp(patttern);
    if (value.length == 0) {
      return "Nama Harus Di Isi";
    } else if (!regExp.hasMatch(value)) {
      return "Menggunakan huruf a-z dan A-Z";
    }
    return null;
  }

  String valEmail(String value) {
    String pattern =
        r'^(([^<>()[\]\\.,;:\s@\"]+(\.[^<>()[\]\\.,;:\s@\"]+)*)|(\".+\"))@((\[[0-9]{1,3}\.[0-9]{1,3}\.[0-9]{1,3}\.[0-9]{1,3}\])|(([a-zA-Z\-0-9]+\.)+[a-zA-Z]{2,}))$';
    RegExp regExp = new RegExp(pattern);
    if (value.length == 0) {
      return "Email Harus Di isi";
    } else if (!regExp.hasMatch(value)) {
      return "Email Tidak Valid";
    } else {
      return null;
    }
  }

  String valPass(String value) {
    if (value.length < 4) {
      return "Password minimal 5 karakter";
    }
    return null;
  }
}
