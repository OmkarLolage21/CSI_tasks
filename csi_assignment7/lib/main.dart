import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';

import 'Splash.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(
    options: const FirebaseOptions(
        apiKey: "AIzaSyBsQPwaLIzY0DX6ewI4mAM1y52TTqAMz7M",
        appId: "1:574235322824:web:ba9366e8f7e5efc9c3b8fd",
        messagingSenderId: "574235322824",
        projectId: "bloagapp2"),
  );
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      debugShowCheckedModeBanner: false,
      theme: ThemeData.dark(),
      home: Splash(),
    );
  }
}
