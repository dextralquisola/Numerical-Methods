import 'package:flutter/material.dart';
import 'package:numerical_project/screens/source_code_screen.dart';
import 'package:numerical_project/solutions/newton_raphson.dart';
import 'package:numerical_project/utils/utils.dart';
import 'package:numerical_project/widgets/app_button.dart';
import 'package:numerical_project/widgets/app_textfield.dart';
import 'package:provider/provider.dart';

import '../constants/source_code.dart';
import '../provider/provider.dart';
import '../widgets/app_text.dart';

class NewtonRaphsonScreen extends StatefulWidget {
  static const routeName = '/newton-raphson';
  const NewtonRaphsonScreen({super.key});

  @override
  State<NewtonRaphsonScreen> createState() => _NewtonRaphsonScreenState();
}

class _NewtonRaphsonScreenState extends State<NewtonRaphsonScreen> {
  final formulaController = TextEditingController();
  final initialGuessController = TextEditingController();
  final toleranceController = TextEditingController();

  List<List<String>> solutionTable = [];

  @override
  void initState() {
    formulaController.text = "e^(-x) - x";
    initialGuessController.text = "0";
    toleranceController.text = "0.0001";
    super.initState();
  }

  @override
  void dispose() {
    formulaController.dispose();
    initialGuessController.dispose();
    toleranceController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final appState = Provider.of<AppState>(context);
    return Scaffold(
      appBar: AppBar(
        title: const Text("Newton-Raphson Method"),
        actions: [
          IconButton(
            onPressed: () {
              Navigator.of(context).push(MaterialPageRoute(builder: (_) {
                return SourceCodeScreen(
                  code: code[2],
                  title: "Newton Method",
                );
              }));
            },
            icon: const Icon(
              Icons.sticky_note_2_outlined,
              color: Colors.white,
              size: 30,
            ),
          )
        ],
      ),
      body: SingleChildScrollView(
        child: Padding(
            padding: const EdgeInsets.all(20.0),
            child: solutionTable.isNotEmpty
                ? resultsBuilder()
                : Column(
                    children: [
                      AppTextField(
                        controller: formulaController,
                        labelText: "Function f(x)",
                        hintText: "x^2 - 2",
                      ),
                      const SizedBox(height: 20),
                      AppTextField(
                          controller: toleranceController,
                          labelText: "Tolerance",
                          hintText: "0.0001",
                          textInputType: const TextInputType.numberWithOptions(
                            decimal: true,
                            signed: false,
                          )),
                      const SizedBox(height: 20),
                      AppTextField(
                          controller: initialGuessController,
                          labelText: "Initial Guess xO",
                          hintText: "0",
                          textInputType: const TextInputType.numberWithOptions(
                            decimal: true,
                            signed: false,
                          )),
                      const SizedBox(height: 20),
                      AppButton(
                        wrapRow: true,
                        height: 50,
                        onPressed: () {
                          try {
                            solutionTable = NewtonRaphson(
                              function: formulaController.text,
                              xo: double.parse(initialGuessController.text),
                              tolerance: double.parse(
                                toleranceController.text,
                              ),
                              decimalPlaces: appState.decimalPlaces,
                            ).solve();

                            setState(() {});
                          } catch (e) {
                            showSnackBar(context, e.toString());
                          }
                        },
                        text: "Calculate",
                      )
                    ],
                  )),
      ),
    );
  }

  Widget resultsBuilder() {
    return Column(
      mainAxisAlignment: MainAxisAlignment.start,
      children: [
        const SizedBox(height: 10),
        AppText(
          text: "Results found after ${solutionTable.length - 1} iterations",
          fontWeight: FontWeight.w600,
          textSize: 20,
        ),
        const SizedBox(height: 5),
        TextButton(
            onPressed: () {
              setState(() {
                solutionTable = [];
              });
            },
            child: const Text("Solve Again")),
        const SizedBox(height: 20),
        solutionsBuilder(),
      ],
    );
  }

  Widget solutionsBuilder() {
    return SingleChildScrollView(
      scrollDirection: Axis.horizontal,
      child: Padding(
        padding: const EdgeInsets.symmetric(vertical: 10.0),
        child: DataTable(
          border: TableBorder.symmetric(
            outside: const BorderSide(width: 1),
            inside: const BorderSide(width: 1),
          ),
          columns: solutionTable[0]
              .map((e) => DataColumn(
                      label: AppText(
                    text: e,
                    alignment: Alignment.centerRight,
                    fontWeight: FontWeight.bold,
                  )))
              .toList(),
          rows: solutionTable
              .sublist(1)
              .map(
                (e) => DataRow(
                  cells: e
                      .map((e) => DataCell(AppText(
                            text: e,
                            alignment: Alignment.centerRight,
                          )))
                      .toList(),
                ),
              )
              .toList(),
        ),
      ),
    );
  }
}
