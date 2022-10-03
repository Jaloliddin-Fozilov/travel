import 'package:flutter/material.dart';
import 'package:travel/screens/places_list_screen.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Sayohat',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      home: const PlacesListScreen(),
    );
  }
}
