import 'package:flutter/material.dart';
import 'package:weatherapp/pages/home_page.dart'; // Import your HomePage here

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'My Flutter App',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      home: HomePage(), // Connect to HomePage here
    );
  }
}
