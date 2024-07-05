// ignore_for_file: library_private_types_in_public_api

import 'package:flutter/material.dart';

void main() {
  runApp(CalculatorApp());
}

// ignore: use_key_in_widget_constructors
class CalculatorApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Flutter Calculator',
      theme: ThemeData(
        brightness: Brightness.dark,
        primarySwatch: Colors.blue,
      ),
      home: CalculatorHomePage(),
    );
  }
}

// ignore: use_key_in_widget_constructors
class CalculatorHomePage extends StatefulWidget {
  @override
  _CalculatorHomePageState createState() => _CalculatorHomePageState();
}

class _CalculatorHomePageState extends State<CalculatorHomePage> {
  String output = "0";
  String _output = "0";
  int num1 = 0;
  int num2 = 0;
  String operand = "";

  buttonPressed(String buttonText) {
    if (buttonText == "CLEAR") {
      _output = "0";
      num1 = 0;
      num2 = 0;
      operand = "";
    } else if (buttonText == "+" || buttonText == "-" || buttonText == "*" || buttonText == "/") {
      num1 = int.parse(output);
      operand = buttonText;
      _output = "0";
    } else if (buttonText == ".") {
      if (_output.contains(".")) {
        // ignore: avoid_print
        print("Already contains a decimal");
        return;
      } else {
        _output = _output + buttonText;
      }
    } else if (buttonText == "=") {
      num2 = int.parse(output);

      if (operand == "+") {
        _output = (num1 + num2).toString();
      }
      if (operand == "-") {
        _output = (num1 - num2).toString();
      }
      if (operand == "*") {
        _output = (num1 * num2).toString();
      }
      if (operand == "/") {
        if (num2 == 0) {
          _output = "Error";
        } else {
          _output = (num1 ~/ num2).toString(); // Integer division
        }
      }

      num1 = 0;
      num2 = 0;
      operand = "";
    } else {
      if (_output == "0") {
        _output = buttonText;
      } else {
        _output = _output + buttonText;
      }
    }

    // ignore: avoid_print
    print(_output);

    setState(() {
      output = _output;
    });
  }

  Widget buildButton(String buttonText, {Color textColor = Colors.white, Color buttonColor = Colors.grey}) {
    return Expanded(
      child: Container(
        margin: const EdgeInsets.all(5.0),
        child: OutlinedButton(
          style: OutlinedButton.styleFrom(
            padding: const EdgeInsets.all(24.0),
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(12.0),
            ),
            side: BorderSide(color: buttonColor, width: 2),
            backgroundColor: buttonColor,
          ),
          child: Text(
            buttonText,
            style: TextStyle(
              fontSize: 28.0, // Increased font size
              fontWeight: FontWeight.bold,
              color: textColor,
            ),
          ),
          onPressed: () => buttonPressed(buttonText),
        ),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text(
          'Calculator',
          style: TextStyle(
            fontSize: 30.0,
            fontWeight: FontWeight.bold,
          ),
        ),
      ),
      // ignore: avoid_unnecessary_containers
      body: Container(
        color: Colors.black,
        child: Column(
          children: <Widget>[
            Container(
              alignment: Alignment.centerRight,
              padding: const EdgeInsets.symmetric(
                vertical: 24.0,
                horizontal: 12.0,
              ),
              child: Text(
                output,
                style: const TextStyle(
                  fontSize: 48.0,
                  fontWeight: FontWeight.bold,
                  color: Colors.white,
                ),
              ),
            ),
            const Expanded(
              child: Divider(),
            ),
            Column(
              children: [
                Row(
                  children: [
                    buildButton("7", buttonColor: Colors.grey[800]!),
                    buildButton("8", buttonColor: Colors.grey[800]!),
                    buildButton("9", buttonColor: Colors.grey[800]!),
                    buildButton("/", buttonColor: Colors.orange, textColor: Colors.black),
                  ],
                ),
                Row(
                  children: [
                    buildButton("4", buttonColor: Colors.grey[800]!),
                    buildButton("5", buttonColor: Colors.grey[800]!),
                    buildButton("6", buttonColor: Colors.grey[800]!),
                    buildButton("*", buttonColor: Colors.orange, textColor: Colors.black),
                  ],
                ),
                Row(
                  children: [
                    buildButton("1", buttonColor: Colors.grey[800]!),
                    buildButton("2", buttonColor: Colors.grey[800]!),
                    buildButton("3", buttonColor: Colors.grey[800]!),
                    buildButton("-", buttonColor: Colors.orange, textColor: Colors.black),
                  ],
                ),
                Row(
                  children: [
                    buildButton(".", buttonColor: Colors.grey[800]!),
                    buildButton("0", buttonColor: Colors.grey[800]!),
                    buildButton("00", buttonColor: Colors.grey[800]!),
                    buildButton("+", buttonColor: Colors.orange, textColor: Colors.black),
                  ],
                ),
                Row(
                  children: [
                    buildButton("CLEAR", buttonColor: Colors.red, textColor: Colors.white),
                    buildButton("=", buttonColor: Colors.green, textColor: Colors.white),
                  ],
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
