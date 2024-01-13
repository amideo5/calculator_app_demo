import 'dart:math';

import 'package:call_application_demo/calcButton.dart';
import 'package:call_application_demo/homepage.dart';
import 'package:call_application_demo/services/SessionManager.dart';
import 'package:flutter/material.dart';
import 'package:math_expressions/math_expressions.dart';

class CalculatorView extends StatefulWidget {
  const CalculatorView({Key? key}) : super(key: key);

  @override
  State<CalculatorView> createState() => _CalculatorViewState();
}

class _CalculatorViewState extends State<CalculatorView> {
  String equation = "0";
  String result = "0";
  String expression = "";
  double equationFontSize = 38.0;
  double resultFontSize = 48.0;

  buttonPressed(String buttonText) {
    String doesContainDecimal(dynamic result) {
      if (result.toString().contains('.')) {
        List<String> splitDecimal = result.toString().split('.');
        if (!(int.parse(splitDecimal[1]) > 0)) {
          return result = splitDecimal[0].toString();
        }
      }
      return result;
    }

    setState(() {
      if (buttonText == "AC") {
        equation = "0";
        result = "0";
      } else if (buttonText == "⌫") {
        equation = equation.substring(0, equation.length - 1);
        if (equation == "") {
          equation = "0";
        }
      } else if (buttonText == "+/-") {
        if (equation[0] != '-') {
          equation = '-$equation';
        } else {
          equation = equation.substring(1);
        }
      } else if (buttonText == "=") {
        expression = equation;
        expression = expression.replaceAll('×', '*');
        expression = expression.replaceAll('÷', '/');
        expression = expression.replaceAll('%', '%');

        try {
          Parser p = Parser();
          Expression exp = p.parse(expression);

          ContextModel cm = ContextModel();
          result = '${exp.evaluate(EvaluationType.REAL, cm)}';
          if (expression.contains('%')) {
            result = doesContainDecimal(result);
          }
        } catch (e) {
          result = "Error";
        }
      } else {
        if (equation == "0") {
          equation = buttonText;
        } else {
          equation = equation + buttonText;
        }
      }
    });
  }

  Future<void> onSavePressed() async {
    if (equation == '0' && result == '0') {
      showDialog(
        context: context,
        builder: (BuildContext context) {
          return AlertDialog(
            title: const Text('Calculator Storage Alert'),
            content: const Text('No input and output!!'),
            actions: [
              TextButton(
                onPressed: () {
                  Navigator.pop(context);
                },
                child: const Text('OK'),
              ),
            ],
          );
        },
      );
    } else {
      showDialog(
        context: context,
        builder: (BuildContext context) {
          return AlertDialog(
            title: const Text('Calculator Storage Alert'),
            content: const Text(
                'You have saved this equation. Go to homepage to view all saved equations.'),
            actions: [
              TextButton(
                onPressed: () {
                  Navigator.pop(context);
                },
                child: const Text('OK'),
              ),
            ],
          );
        },
      );
      await SessionManager.saveEquation(equation);
      await SessionManager.saveResult(result);
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        elevation: 0,
        backgroundColor: Color.fromARGB(255, 70, 75, 95),
        leading: GestureDetector(
          onTap: () {
            Navigator.push(
              context,
              MaterialPageRoute(builder: (context) => const HomePage()),
            );
          },
          child: const Icon(Icons.home_filled, color: Colors.orange),
        ),
        actions: [
          Padding(
            padding: const EdgeInsets.symmetric(vertical: 10.0),
            child: ElevatedButton(
              onPressed: () {
                onSavePressed();
              },
              child: const Text('Save'),
            ),
          ),
          const SizedBox(width: 20),
        ],
      ),
      body: Stack(children: [
        Positioned.fill(
          child: Image.asset(
            'assets/taklumaklu.jpg',
            fit: BoxFit.fill,
          ),
        ),
        WillPopScope(
          onWillPop: null,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [
              Expanded(child: 
              Align(
                    alignment: Alignment.bottomRight,
                    child:
              SingleChildScrollView(
                scrollDirection: Axis.horizontal,
              child :Column(
                crossAxisAlignment: CrossAxisAlignment.end,
                children: [
                  Row(
                    mainAxisAlignment: MainAxisAlignment.end,
                    children: <Widget>[
                      Padding(
                          padding: const EdgeInsets.all(10.0),
                          child: Text(result,
                              textAlign: TextAlign.left,
                              style: const TextStyle(
                                  color: Colors.white, fontSize: 80))),
                      const SizedBox(width: 20),
                    ],
                  ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.end,
                    children: [
                      Padding(
                        padding: const EdgeInsets.symmetric(vertical: 0),
                        child: Text(equation,
                            style: const TextStyle(
                              fontSize: 40,
                              color: Color.fromARGB(255, 255, 255, 255),
                            )),
                      ),
                      const SizedBox(width: 20),
                      IconButton(
                        icon: const Icon(Icons.backspace_outlined,
                            color: Colors.orange, size: 30),
                        onPressed: () {
                          buttonPressed("⌫");
                        },
                      ),
                      const SizedBox(width: 20),
                    ],
                  ),
                ],
              ),
              ))),

              Row(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: [
                  calcButton('AC', Colors.transparent.withOpacity(0.6),
                      () => buttonPressed('AC')),
                  calcButton('%', Colors.transparent.withOpacity(0.6),
                      () => buttonPressed('%')),
                  calcButton('÷', Colors.transparent.withOpacity(0.6),
                      () => buttonPressed('÷')),
                  calcButton("×", Colors.transparent.withOpacity(0.6),
                      () => buttonPressed('×')),
                ],
              ),
              const SizedBox(height: 10),

              Row(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: [
                  calcButton('7', Colors.transparent.withOpacity(0.3),
                      () => buttonPressed('7')),
                  calcButton('8', Colors.transparent.withOpacity(0.3),
                      () => buttonPressed('8')),
                  calcButton('9', Colors.transparent.withOpacity(0.3),
                      () => buttonPressed('9')),
                  calcButton('-', Colors.transparent.withOpacity(0.6),
                      () => buttonPressed('-')),
                ],
              ),
              const SizedBox(height: 10),

              Row(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: [
                  calcButton('4', Colors.transparent.withOpacity(0.3),
                      () => buttonPressed('4')),
                  calcButton('5', Colors.transparent.withOpacity(0.3),
                      () => buttonPressed('5')),
                  calcButton('6', Colors.transparent.withOpacity(0.3),
                      () => buttonPressed('6')),
                  calcButton('+', Colors.transparent.withOpacity(0.6),
                      () => buttonPressed('+')),
                ],
              ),
              const SizedBox(height: 10),
              // calculator number buttons

              Row(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: [
                  Column(
//mainAxisAlignment: MainAxisAlignment.spaceAround
                    children: [
                      Row(
                        children: [
                          calcButton('1', Colors.transparent.withOpacity(0.3),
                              () => buttonPressed('1')),
                          SizedBox(
                              width: MediaQuery.of(context).size.width * 0.04),
                          calcButton('2', Colors.transparent.withOpacity(0.3),
                              () => buttonPressed('2')),
                          SizedBox(
                              width: MediaQuery.of(context).size.width * 0.04),
                          calcButton('3', Colors.transparent.withOpacity(0.3),
                              () => buttonPressed('3')),
                        ],
                      ),
                      const SizedBox(height: 10),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                        children: [
                          calcButton('+/-', Colors.transparent.withOpacity(0.3),
                              () => buttonPressed('+/-')),
                          SizedBox(
                              width: MediaQuery.of(context).size.width * 0.04),
                          calcButton('0', Colors.transparent.withOpacity(0.3),
                              () => buttonPressed('0')),
                          SizedBox(
                              width: MediaQuery.of(context).size.width * 0.04),
                          calcButton('.', Colors.transparent.withOpacity(0.3),
                              () => buttonPressed('.')),
                        ],
                      ),
                    ],
                  ),
                  calcButton('=', Colors.orange, () => buttonPressed('=')),
                ],
              ),
              const Row(children: [SizedBox(height: 20)]),
              
            ],
          ),
        ),
      ]),
    );
  }
}
