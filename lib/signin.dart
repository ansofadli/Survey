import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:sanitasi/screen/dftrUser.dart';
import 'package:sanitasi/screen/home.dart';
import 'package:shared_preferences/shared_preferences.dart';

class SignIn extends StatefulWidget {
  @override
  _SignInState createState() => _SignInState();
}

enum LogStatus {
  noSignin,
  signin,
}

class _SignInState extends State<SignIn> {
  LogStatus _logStatus = LogStatus.noSignin;
  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();
  bool _secText = true;
  // bool _validate = false;
  String username;
  String pass;
  @override
  void initState() {
    getPref();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    switch (_logStatus) {
      case LogStatus.noSignin:
        return Scaffold(
            // appBar: AppBar(
            //   title: Text("Login Petugas Survey"),
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
                  Padding(
                    padding: EdgeInsets.only(top: 20.0),
                  ),
                  _email(),
                  _password(),
                  _btnLogin(),
                  _btnDaftar(),
                ],
              ),
            ),
          ),
        ));
        break;
      case LogStatus.signin:
        return Home();
        break;
    }
  }

  chek() {
    final form = _formKey.currentState;
    if (form.validate()) {
      form.save();
      login();
    }
  }

  login() async {
    final response = await http.post(
        "http://192.168.1.110/crudflutter/login.php",
        body: {"username": username, "password": pass});
    final data = jsonDecode(response.body);
    int value = data["value"];
    String message = data["message"];
    String usernameApi = data["username"];
    String namaApi = data["nama"];
    if (value == 1) {
      setState(() {
        _logStatus = LogStatus.signin;
        // savePref(value);
      });
      print(message);
    } else {
      print(message);
    }
    print(data);
  }

  savePref(int value, String username, String nama) async {
    SharedPreferences preferences = await SharedPreferences.getInstance();
    setState(() {
      preferences.setInt("value", value);
      preferences.setString("username", username);
      preferences.setString("nama", nama);
      preferences.commit();
    });
  }

  signOut() async {
    SharedPreferences preferen = await SharedPreferences.getInstance();
    setState(() {
      preferen.setInt("value", null);
      preferen.commit();
      _logStatus = LogStatus.noSignin;
    });
  }

  var value;
  getPref() async {
    SharedPreferences preferences = await SharedPreferences.getInstance();
    setState(() {
      value = preferences.getInt("value");
      _logStatus = value == 1 ? LogStatus.signin : LogStatus.noSignin;
    });
  }

  showHide() {
    setState(() {
      _secText = !_secText;
    });
  }

  _logobmi() {
    return Padding(
      padding: const EdgeInsets.only(left: 20.0),
      child: Hero(
        tag: 'hero',
        child: CircleAvatar(
          backgroundColor: Colors.transparent,
          radius: 72.0,
          child: Image.asset("images/logobmi.png"),
        ),
      ),
    );
  }

  _logowater() {
    return Padding(
      padding: const EdgeInsets.only(right: 30.0),
      child: Hero(
        tag: 'hero',
        child: CircleAvatar(
          backgroundColor: Colors.transparent,
          radius: 72.0,
          child: Image.asset("images/logowater.png"),
        ),
      ),
    );
  }

  _email() {
    return Padding(
      padding: const EdgeInsets.all(10.0),
      child: TextFormField(
        autofocus: true,
        onSaved: (e) => username = e,
        validator: valEmail,
        keyboardType: TextInputType.emailAddress,
        decoration: InputDecoration(
          contentPadding: EdgeInsets.fromLTRB(20.0, 20.0, 20.0, 20.0),
          border: OutlineInputBorder(borderRadius: BorderRadius.circular(20.0)),
          labelText: "User Name",
          hintText: "email@email.com",
          icon: Icon(Icons.person),
        ),
      ),
    );
  }

  _password() {
    return Padding(
      padding: const EdgeInsets.all(10.0),
      child: TextFormField(
        onSaved: (e) => pass = e,
        validator: valPass,
        obscureText: _secText,
        keyboardType: TextInputType.text,
        decoration: InputDecoration(
          contentPadding: EdgeInsets.fromLTRB(20, 20, 20, 20),
          border: OutlineInputBorder(borderRadius: BorderRadius.circular(20.0)),
          labelText: "Password",
          hintText: "Enter Password",
          icon: Icon(Icons.vpn_key),
          suffixIcon: IconButton(
            onPressed: showHide,
            icon: Icon(_secText ? Icons.visibility_off : Icons.visibility),
          ),
        ),
      ),
    );
  }

  _btnLogin() {
    return Padding(
      padding: EdgeInsets.all(10.0),
      child: Material(
        borderRadius: BorderRadius.circular(20),
        elevation: 5.0,
        color: Colors.green,
        child: MaterialButton(
          onPressed: () {
            chek();
          },
          child: Text(
            "Login",
            style: TextStyle(color: Colors.white),
          ),
        ),
      ),
    );
  }

  _btnDaftar() {
    return InkWell(
      onTap: () {
        Navigator.of(context)
            .push(MaterialPageRoute(builder: (context) => DaftarUser()));
      },
      child: Text(
        "Belum Punya Akun, Klik disini",
        textAlign: TextAlign.center,
        style: TextStyle(color: Colors.white60),
      ),
    );
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
    if (value.length < 5) {
      return "Password minimal 5 karakter";
    }
    return null;
  }
}
