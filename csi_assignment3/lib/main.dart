import 'package:assignment_3/providers/theme_provider.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:provider/provider.dart';

import 'home.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    SystemChrome.setSystemUIOverlayStyle(
        SystemUiOverlayStyle(statusBarColor: Colors.transparent));
    return ChangeNotifierProvider(
      create: (context) => ThemeProvider(),
      builder: (context, child) {
        final provider = Provider.of<ThemeProvider>(context);
        return MaterialApp(
          debugShowCheckedModeBanner: false,
          title: 'Daily Tasks App',
          home: home(),
          theme: provider.Theme,
        );
      },
    );
  }
}
