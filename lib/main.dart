import 'package:flutter/material.dart';

void main() => runApp(CalculatorApp());

class CalculatorApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Calculator',
      theme: ThemeData(
        primarySwatch: Colors.blueGrey,
      ),
      home: Calculator(),
    );
  }
}

class Calculator extends StatefulWidget {
  @override
  _CalculatorState createState() => _CalculatorState();
}

class _CalculatorState extends State<Calculator> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: null,
      backgroundColor: Color(0xff1C1C1C),
      body: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: <Widget>[
          Container(
            alignment: Alignment.centerRight,
            padding: EdgeInsets.symmetric(vertical: 24.0, horizontal: 12.0),
            child: Text(
              output,
              style: new TextStyle(
                color: Colors.white,
                fontSize: 72.0,
                fontWeight: FontWeight.w300,
              ),
            ),
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            children: [
              buildButton(clearText, Color(0xffD4D4D2), Color(0xff1C1C1C)),
              buildButton("+/-", Color(0xffD4D4D2), Color(0xff1C1C1C)),
              buildButton("%", Color(0xffD4D4D2), Color(0xff1C1C1C)),
              buildButton("/", Color(0xffFF9500), Color(0xffffffff))
            ],
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            children: [
              buildButton("7", Color(0xff505050), Color(0xffffffff)),
              buildButton("8", Color(0xff505050), Color(0xffffffff)),
              buildButton("9", Color(0xff505050), Color(0xffffffff)),
              buildButton("x", Color(0xffFF9500), Color(0xffffffff)),
            ],
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            children: [
              buildButton("4", Color(0xff505050), Color(0xffffffff)),
              buildButton("5", Color(0xff505050), Color(0xffffffff)),
              buildButton("6", Color(0xff505050), Color(0xffffffff)),
              buildButton("-", Color(0xffFF9500), Color(0xffffffff)),
            ],
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            children: [
              buildButton("1", Color(0xff505050), Color(0xffffffff)),
              buildButton("2", Color(0xff505050), Color(0xffffffff)),
              buildButton("3", Color(0xff505050), Color(0xffffffff)),
              buildButton("+", Color(0xffFF9500), Color(0xffffffff)),
            ],
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            children: [
              buildButtonZero("0", Color(0xff505050), Color(0xffffffff)),
              buildButton(".", Color(0xff505050), Color(0xffffffff)),
              buildButton("=", Color(0xffFF9500), Color(0xffffffff)),
            ],
          ),
        ],
      ),
    );
  }

  String output = "0";
  String clearText = "AC";

  String _output = "0";
  String _clearText = "AC";
  double _num1 = 0.0;
  double _num2 = 0.0;
  String _operand = "";

  buttonPressed(String button) {
    switch (button) {
      case "AC":
        _output = "0";
        _num1 = 0.0;
        _num2 = 0.0;
        _operand = "";
        break;

      case "C":
        _clearText = "AC";
        _output = "0";
        if (_operand == "") {
          _num1 = 0.0;
        } else {
          _num2 = 0.0;
        }
        break;

      case "+":
      case "-":
      case "*":
      case "/":
        _num1 = double.parse(output);
        _operand = button;
        _output = "0";
        break;

      case ".":
        if (_output.contains(button)) {
          return;
        }
        _output += button;
        break;

      case "+/-":
        _output = (double.parse(output) * -1).toString();
        break;

      case "%":
        _num1 = double.parse(output) / 100;
        _num2 = 0.0;
        _output = _num1.toString();
        _operand = "";
        break;

      case "=":
        _num2 = double.parse(output);

        if (_operand == "+") {
          _output = (_num1 + _num2).toString();
        } else if (_operand == "-") {
          _output = (_num1 - _num2).toString();
        } else if (_operand == "x") {
          _output = (_num1 * _num2).toString();
        } else if (_operand == "/") {
          _output = (_num1 / _num2).toString();
        }

        _num1 = 0.0;
        _num2 = 0.0;
        _operand = "";
        break;

      default:
        _clearText = "C";
        if (output == "0") {
          _output = button;
        } else {
          _output = _output + button;
        }
        break;
    }

    setState(() {
      clearText = _clearText;
      if (double.parse(_output).round() == double.parse(_output)) {
        output = double.parse(_output).round().toString();
      } else {
        output = _output;
      }
    });
  }

  Widget buildButton(String text, Color color, Color textColor) {
    return Container(
        padding: EdgeInsets.only(bottom: 12),
        child: RaisedButton(
          padding: EdgeInsets.all(18),
          shape: CircleBorder(),
          child: Text(
            text,
            style: TextStyle(
              fontSize: 36,
              fontWeight: FontWeight.normal,
            ),
          ),
          onPressed: () => buttonPressed(text),
          color: color,
          textColor: textColor,
        ));
  }

  Widget buildButtonZero(String text, Color color, Color textColor) {
    return Container(
        margin: EdgeInsets.only(left: 8, right: 8),
        padding: EdgeInsets.only(bottom: 12),
        child: RaisedButton(
          padding: EdgeInsets.only(left: 78, top: 20, right: 78, bottom: 20),
          shape: StadiumBorder(),
          child: Text(
            text,
            style: TextStyle(
              fontSize: 36,
              fontWeight: FontWeight.normal,
            ),
          ),
          onPressed: () => buttonPressed(text),
          color: color,
          textColor: textColor,
        ));
  }
}
