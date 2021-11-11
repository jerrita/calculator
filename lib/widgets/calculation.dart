import 'package:calculator/widgets/calculator_button.dart';
import 'package:calculator/widgets/result_display.dart';
import 'package:flutter/material.dart';
// ignore: import_of_legacy_library_into_null_safe
import 'package:string_num_calculate/string_num_calculate.dart';

class Calculation extends StatefulWidget {
  const Calculation({Key? key}) : super(key: key);

  @override
  _CalculationState createState() => _CalculationState();
}

class _CalculationState extends State<Calculation> {
  int result = 0; // 最后数字
  bool resFlag = true; // 是否重制 Result
  String express = '';

  operatorPressed(String opCode) {
    setState(() {
      express += result.toString();
      express += opCode;
      result = -1;
      resFlag = true;
    });
  }

  numberPressed(int number) {
    setState(() {
      if (result == 0 || resFlag) {
        result = number;
        resFlag = false;
      } else if (result > (1 << 31) / 10) {
        // Avoid overflow
      } else {
        result = result * 10 + number;
      }
    });
  }

  calculateResult() {
    express += result.toString();
    setState(() {
      result = 0;
      express = Calculate.LinierCalculate(express).toString();
    });
  }

  clear() {
    setState(() {
      result = 0;
      express = '';
    });
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        ResultDisplay(
          result: result,
          text: express,
        ),
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
          mainAxisSize: MainAxisSize.min,
          children: [
            _getButton(text: '7', onTap: () => numberPressed(7)),
            _getButton(text: '8', onTap: () => numberPressed(8)),
            _getButton(text: '9', onTap: () => numberPressed(9)),
            _getButton(
                text: 'x',
                onTap: () => operatorPressed('*'),
                backgroundColor: const Color.fromRGBO(220, 220, 220, 1)),
          ],
        ),
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
          mainAxisSize: MainAxisSize.min,
          children: [
            _getButton(text: '4', onTap: () => numberPressed(4)),
            _getButton(text: '5', onTap: () => numberPressed(5)),
            _getButton(text: '6', onTap: () => numberPressed(6)),
            _getButton(
                text: '/',
                onTap: () => operatorPressed('/'),
                backgroundColor: const Color.fromRGBO(220, 220, 220, 1)),
          ],
        ),
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
          mainAxisSize: MainAxisSize.min,
          children: [
            _getButton(text: '1', onTap: () => numberPressed(1)),
            _getButton(text: '2', onTap: () => numberPressed(2)),
            _getButton(text: '3', onTap: () => numberPressed(3)),
            _getButton(
                text: '+',
                onTap: () => operatorPressed('+'),
                backgroundColor: const Color.fromRGBO(220, 220, 220, 1))
          ],
        ),
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
          mainAxisSize: MainAxisSize.min,
          children: [
            _getButton(
                text: '=',
                onTap: calculateResult,
                backgroundColor: Colors.orange,
                textColor: Colors.white),
            _getButton(text: '0', onTap: () => numberPressed(0)),
            _getButton(
                text: 'C',
                onTap: clear,
                backgroundColor: const Color.fromRGBO(220, 220, 220, 1)),
            _getButton(
                text: '-',
                onTap: () => operatorPressed('-'),
                backgroundColor: const Color.fromRGBO(220, 220, 220, 1)),
          ],
        ),
      ],
    );
  }

  Widget _getButton(
      {required String text,
      required VoidCallback onTap,
      Color backgroundColor = Colors.white,
      Color textColor = Colors.black}) {
    return CalculatorButton(
        label: text,
        onTap: onTap,
        size: 90,
        backgroundColor: backgroundColor,
        labelColor: textColor);
  }
}
