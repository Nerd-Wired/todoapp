import 'package:flutter/material.dart';
import 'screens/home_screen.dart'; // make sure path is correct

void main() {
  runApp(const MaterialApp(
    debugShowCheckedModeBanner: false,
    home: HomeScreen(),
  ));
}
