import 'package:calculator/widgets/calculation.dart';
import 'package:flutter/material.dart';

void main() {
  runApp(const CalculatorApp());
}

class CalculatorApp extends StatelessWidget {
  const CalculatorApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return const MaterialApp(
      title: "Simple Calculator",
      home: Scaffold(
        body: Calculation(),
      ),
    );
  }
}
