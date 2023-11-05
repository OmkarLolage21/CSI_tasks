import 'package:blog_app/AddBlog.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

class HomePage extends StatefulWidget {
  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  FirebaseAuth auth = FirebaseAuth.instance;
  @override
  Widget build(BuildContext context) {
    return WillPopScope(
      onWillPop: () async {
        SystemNavigator.pop();
        return true;
      },
      child: Scaffold(
        backgroundColor: Colors.teal[300],
        appBar: AppBar(
          automaticallyImplyLeading: false,
          shadowColor: Colors.white,
          title: Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: <Widget>[
              Text(
                'CSI ',
                style: TextStyle(
                    color: Colors.red,
                    fontSize: 22,
                    fontWeight: FontWeight.bold),
              ),
              Text(
                'Assignment',
                style: TextStyle(color: Colors.white, fontSize: 22),
              ),
            ],
          ),
          centerTitle: true,
          backgroundColor: Colors.black87,
          elevation: 0.0,
        ),
        body: SingleChildScrollView(
          child: Column(children: [
            SizedBox(
              height: 30,
            ),
          ]),
        ),
        floatingActionButton: Container(
          padding: EdgeInsets.symmetric(vertical: 25),
          child: Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: <Widget>[
                FloatingActionButton(
                  backgroundColor: Colors.black,
                  hoverColor: Colors.teal[300],
                  onPressed: () {
                    Navigator.push(context,
                        MaterialPageRoute(builder: (context) => AddBlog()));
                  },
                  child: Icon(
                    Icons.add,
                    color: Colors.white,
                  ),
                )
              ]),
        ),
      ),
    );
  }
}
