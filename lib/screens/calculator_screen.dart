import 'package:flutter/material.dart';
import 'package:math_expressions/math_expressions.dart';
import 'dart:math' as math;

import '../constants/constants.dart';
import '../utils/utils.dart';
import '../widgets/calculator_btn.dart';

class CalculatorScreen extends StatefulWidget {
  static const routeName = '/calculator-screen';
  const CalculatorScreen({super.key});

  @override
  State<CalculatorScreen> createState() => _CalculatorScreenState();
}

class _CalculatorScreenState extends State<CalculatorScreen> {
  String allowedOnscreen = '0123456789+-.x÷/()^*';
  String typedEquation = '';

  final _textEditingController = TextEditingController();

  var formulas = [
    'A + B',
    'A - (B/C)',
    'X + (Y-X)*(A/A-B)',
    'A - ((X * (A - B)) / (X - Y))',
    'e^(-X) - X'
  ];

  int? selectedFormula;

  var isUsingFormula = false;
  List<String> inputs = [];
  int indexOfInputVariable = 0;
  String formulaVariables = '';

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      resizeToAvoidBottomInset: false,
      appBar: AppBar(
        elevation: 0,
        backgroundColor: Colors.transparent,
        title: Container(
          margin: const EdgeInsets.only(left: 8),
          child: const Text("Calculator"),
        ),
        actions: [
          IconButton(
            onPressed: () {
              showDialog(
                context: context,
                builder: (BuildContext context) {
                  return AlertDialog(
                    title: const Text('Enter formula'),
                    content: Column(
                      mainAxisSize: MainAxisSize.min,
                      children: [
                        const Text(
                            'Enter formula using variables A, B, C, X, Y and Z\nNote: the app only support "e" as a constant'),
                        Row(
                          children: [
                            Expanded(
                              child: TextFormField(
                                controller: _textEditingController,
                                decoration: const InputDecoration(
                                  hintText: 'Sample: e^(-X) - X',
                                ),
                              ),
                            ),
                          ],
                        ),
                      ],
                    ),
                    actions: [
                      TextButton(
                        child: const Text('Cancel'),
                        onPressed: () {
                          Navigator.of(context).pop();
                        },
                      ),
                      TextButton(
                        child: const Text('OK'),
                        onPressed: () {
                          setState(() {
                            if (_textEditingController.text.isNotEmpty) {
                              formulas.add(
                                  _textEditingController.text.toUpperCase());
                              _textEditingController.clear();
                            }
                          });
                          // Perform any operations with enteredText
                          Navigator.of(context).pop();
                        },
                      ),
                    ],
                  );
                },
              );
            },
            icon: const Icon(
              Icons.add,
              color: Colors.white,
              size: 32,
            ),
          )
        ],
      ),
      backgroundColor: Colors.deepPurpleAccent,
      body: SafeArea(
        child: Column(
          children: [
            Expanded(
                child: buildResult(
              typedEquation,
              formulaVariables,
            )),
            Expanded(flex: 2, child: buildButtons()),
          ],
        ),
      ),
    );
  }

  Widget buildResult(String result, String formulaVariables) {
    return Padding(
      padding: const EdgeInsets.all(24),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        mainAxisAlignment: MainAxisAlignment.end,
        children: [
          if (selectedFormula != null)
            Text(
              formulas[selectedFormula!],
              overflow: TextOverflow.ellipsis,
              style: const TextStyle(color: Colors.white, fontSize: 18),
            ),
          Text(
            result,
            overflow: TextOverflow.ellipsis,
            style: const TextStyle(color: Colors.white, fontSize: 36),
          ),
          const SizedBox(height: 24),
          if (isUsingFormula &&
              indexOfInputVariable < formulaVariables.length) ...[
            Text(
              "Enter value for ${formulaVariables[indexOfInputVariable]}: ",
              overflow: TextOverflow.ellipsis,
              style: const TextStyle(color: Colors.white, fontSize: 18),
            ),
          ]
        ],
      ),
    );
  }

  Widget buildButtons() {
    return Container(
      padding: const EdgeInsets.all(16),
      decoration: const BoxDecoration(
        color: MyColors.background2,
        borderRadius: BorderRadius.vertical(top: Radius.circular(32)),
      ),
      child: Column(
        children: [
          buildButtonRow('AC', '<', '<F', 'F>'),
          buildButtonRow('(', ')', '^', '/'),
          buildButtonRow('7', '8', '9', '*'),
          buildButtonRow('4', '5', '6', '-'),
          buildButtonRow('1', '2', '3', '+'),
          buildButtonRow('0', '.', '', '='),
        ],
      ),
    );
  }

  Widget buildButtonRow(
    String first,
    String second,
    String third,
    String fourth,
  ) {
    final row = [first, second, third, fourth];
    return Expanded(
      child: Row(
        children: row
            .map(
              (text) => ButtonWidget(
                text: text,
                onClicked: () {
                  if (allowedOnscreen.contains(text)) {
                    if (selectedFormula != null && !isUsingFormula) {
                      selectedFormula = null;
                    }
                    setState(() {
                      typedEquation += text;
                    });
                  }

                  if (text == '<' && typedEquation.isNotEmpty) {
                    setState(() {
                      typedEquation =
                          typedEquation.substring(0, typedEquation.length - 1);
                    });
                  }

                  if (text == 'AC') {
                    setState(() {
                      typedEquation = '';
                      indexOfInputVariable = 0;
                      inputs.clear();
                      isUsingFormula = false;
                      selectedFormula = null;
                    });
                  }

                  if (text == 'F>') {
                    setState(() {
                      if (selectedFormula == null) {
                        selectedFormula = 0;
                      } else {
                        selectedFormula =
                            (selectedFormula! + 1) % formulas.length;
                      }
                    });
                  }

                  if (text == '<F') {
                    setState(() {
                      if (selectedFormula == null) {
                        selectedFormula = formulas.length - 1;
                      } else {
                        selectedFormula =
                            (selectedFormula! - 1) % formulas.length;
                      }
                    });
                  }

                  if (text == '=') {
                    if (selectedFormula != null && !isUsingFormula) {
                      setState(() {
                        isUsingFormula = true;
                        formulaVariables =
                            getVariableNames(formulas[selectedFormula!]);
                      });
                    } else if (isUsingFormula) {
                      setState(() {
                        if (indexOfInputVariable < formulaVariables.length) {
                          inputs.add(typedEquation);
                          typedEquation = '';

                          print("indexOfInputVariable: $indexOfInputVariable");

                          if (indexOfInputVariable ==
                              formulaVariables.length - 1) {
                            inputs.add(typedEquation);
                            typedEquation = '';

                            final variables = formulaVariables;
                            final values = <String, double>{};
                            for (var i = 0; i < variables.length; i++) {
                              values[variables[i]] = double.parse(inputs[i]);
                            }
                            print("values");
                            print(values);
                            final result =
                                calculate(formulas[selectedFormula!], values);
                            typedEquation = result.toString();
                            formulaVariables = '';
                            selectedFormula = null;
                            indexOfInputVariable = 0;
                            isUsingFormula = false;
                            inputs.clear();
                          }

                          indexOfInputVariable++;
                        }
                      });
                    } else {
                      setState(() {
                        formulaVariables = '';
                        inputs.clear();
                        selectedFormula = null;
                        isUsingFormula = false;

                        final result = calculate(typedEquation, {});
                        typedEquation = result.toString();
                      });
                    }
                  }
                },
                onClickedLong: () => print(text),
              ),
            )
            .toList(),
      ),
    );
  }

  double calculate(String formula, Map<String, double> values) {
    try {
      if (values.isNotEmpty) {
        values.forEach((key, value) {
          formula = formula.replaceAll(key, value.toString());
        });
      }

      return _evaluate(formula);
    } catch (e) {
      showSnackBar(context, e.toString());
      return 0;
    }
  }

  double _evaluate(String formula) {
    Parser p = Parser();
    Expression exp = p.parse(formula);
    Variable e = Variable('e');
    ContextModel cm = ContextModel()..bindVariable(e, Number(math.e));
    return exp.evaluate(EvaluationType.REAL, cm);
  }

  String getVariableNames(String formula) {
    String filterFormula = '0123456789+-.x÷/()^*DFGHIJKLMNOPQRSTUVW';
    formula = formula.replaceAll(' ', '');
    final variables = <String>{};
    for (var i = 0; i < formula.length; i++) {
      final char = formula[i];
      if (filterFormula.contains(char.toUpperCase()) || char == 'e') {
        continue;
      }
      variables.add(char);
    }
    return variables.join('');
  }
}
