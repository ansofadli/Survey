import 'package:flutter/material.dart';
import 'package:sanitasi/screen/kantor.dart';
import 'package:sanitasi/signin.dart';
import 'package:shared_preferences/shared_preferences.dart';

class Home extends StatefulWidget {
  // final VoidCallback signOut;
  // Home(this.signOut);
  @override
  _HomeState createState() => _HomeState();
}

class _HomeState extends State<Home> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        // actions: <Widget>[
        //   IconButton(
        //     onPressed: () {
        //       signOut();
        //     },
        //     icon: Icon(Icons.lock_open),
        //   )
        // ],
        backgroundColor: Colors.blue[300],
        title: Text(
          "Survey Sanitasi",
        ),
      ),
      drawer: _drawerApp(context),
      body: Container(
        decoration: BoxDecoration(
          gradient: LinearGradient(
            begin: Alignment.topRight,
            end: Alignment.bottomLeft,
            colors: [Colors.blue[300], Colors.blue[100]],
          ),
        ),
      ),
    );
  }

  // signOut() {
  //   setState(() {
  //     widget.signOut();
  //   });
  // }
}

Widget _drawerApp(context) {
  return Drawer(
    child: ListView(
      padding: EdgeInsets.zero,
      children: <Widget>[
        UserAccountsDrawerHeader(
          accountName: Text("Nama Petugas"),
          accountEmail: Text("Email Petugas"),
          currentAccountPicture: GestureDetector(
            onTap: () {},
            child: CircleAvatar(
              backgroundColor: Colors.white54,
              backgroundImage: AssetImage("images/logobmi.png"),
            ),
          ),
          decoration: BoxDecoration(
            image: DecorationImage(
              image: AssetImage("images/air.jpg"),
            ),
          ),
        ),
        ListTile(
          leading: Icon(Icons.settings),
          title: Text("Setting Profile"),
          trailing: Icon(Icons.info_outline),
          onTap: () {},
        ),
        Divider(
          height: 2.0,
        ),
        ListTile(
          leading: Icon(Icons.business),
          title: Text("Kantor"),
          trailing: Icon(Icons.chevron_right),
          onTap: () {
            Navigator.push(
                context, MaterialPageRoute(builder: (context) => Kantor()));
          },
        ),
        Divider(
          height: 2.0,
        ),
        ListTile(
          title: Text(
            "Sign Out",
            textAlign: TextAlign.center,
          ),
          trailing: Icon(Icons.input),
          onTap: () {
            Navigator.push(
                context, MaterialPageRoute(builder: (context) => SignIn()));
          },
        ),
      ],
    ),
  );
}
