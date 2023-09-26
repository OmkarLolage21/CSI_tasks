import 'package:flutter/material.dart';

class homepage extends StatelessWidget {
  String name, email, phone;

  homepage({required this.name, required this.email, required this.phone});
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            Text(
              'Name: ${name}',
              style: TextStyle(fontSize: 20, color: Colors.deepPurple),
            ),
            Padding(padding: EdgeInsets.all(20)),
            Text(
              'Email : ${email}',
              style: TextStyle(fontSize: 20, color: Colors.red[300]),
            ),
            Padding(padding: EdgeInsets.all(20)),
            Text(
              'Phone : ${phone}',
              style: TextStyle(fontSize: 20, color: Colors.deepPurple),
            )
          ],
        ),
      ),
    );
  }
}
