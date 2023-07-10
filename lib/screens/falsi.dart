import 'package:flutter/material.dart';
import 'package:numerical_project/screens/source_code_screen.dart';
import 'package:numerical_project/utils/utils.dart';
import 'package:provider/provider.dart';

import '../constants/source_code.dart';
import '../provider/provider.dart';
import '../solutions/falsi.dart';
import '../widgets/app_button.dart';
import '../widgets/app_text.dart';
import '../widgets/app_textfield.dart';

class FalsePositionScreen extends StatefulWidget {
  static const routeName = '/false-position';
  const FalsePositionScreen({super.key});

  @override
  State<FalsePositionScreen> createState() => _FalsePositionScreenState();
}

class _FalsePositionScreenState extends State<FalsePositionScreen> {
  final formulaController = TextEditingController();
  final toleranceController = TextEditingController();

  final firstGuessController = TextEditingController();
  final secondGuessController = TextEditingController();

  List<List<String>> solution_table = [];

  @override
  void initState() {
    toleranceController.text = "0.0001";
    firstGuessController.text = "1";
    secondGuessController.text = "2";
    formulaController.text = "x^2 - 2";
    super.initState();
  }

  @override
  void dispose() {
    formulaController.dispose();
    toleranceController.dispose();
    firstGuessController.dispose();
    secondGuessController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final appState = Provider.of<AppState>(context);
    return Scaffold(
      appBar: AppBar(
        title: const Text("False Position Method"),
        actions: [
          IconButton(
            onPressed: () {
              Navigator.of(context).push(MaterialPageRoute(builder: (_) {
                return SourceCodeScreen(
                  code: code[1],
                  title: "False Position Method",
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
        scrollDirection: Axis.vertical,
        child: solution_table.isNotEmpty
            ? resultsBuilder()
            : Padding(
                padding: const EdgeInsets.all(20.0),
                child: Column(
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
                        textInputType: const TextInputType.numberWithOptions(
                          decimal: true,
                          signed: false,
                        )),
                    const SizedBox(height: 20),
                    Row(
                      mainAxisSize: MainAxisSize.min,
                      children: [
                        Expanded(
                          child: AppTextField(
                              controller: firstGuessController,
                              labelText: "First Guess xL",
                              textInputType:
                                  const TextInputType.numberWithOptions(
                                decimal: true,
                                signed: false,
                              )),
                        ),
                        const SizedBox(width: 20),
                        Expanded(
                          child: AppTextField(
                              controller: secondGuessController,
                              labelText: "Second Guess xR",
                              textInputType:
                                  const TextInputType.numberWithOptions(
                                decimal: true,
                                signed: false,
                              )),
                        ),
                      ],
                    ),
                    const SizedBox(height: 20),
                    AppButton(
                      onPressed: () {
                        try {
                          solution_table = FalsePosition(
                            function: formulaController.text,
                            xL: double.parse(firstGuessController.text),
                            xR: double.parse(secondGuessController.text),
                            tolerance: double.parse(toleranceController.text),
                            decimalPlaces: appState.decimalPlaces,
                          ).solve();

                          setState(() {});
                        } catch (e) {
                          showSnackBar(context, e.toString());
                        }
                      },
                      height: 50,
                      wrapRow: true,
                      text: "Calculate",
                    ),
                  ],
                ),
              ),
      ),
    );
  }

  Widget resultsBuilder() {
    return Column(
      mainAxisAlignment: MainAxisAlignment.start,
      children: [
        const SizedBox(height: 10),
        AppText(
          text: "Results found after ${solution_table.length - 1} iterations",
          fontWeight: FontWeight.w600,
          textSize: 20,
        ),
        const SizedBox(height: 5),
        TextButton(
            onPressed: () {
              setState(() {
                solution_table = [];
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
          columns: solution_table[0]
              .map((e) => DataColumn(
                      label: AppText(
                    text: e,
                    alignment: Alignment.centerRight,
                    fontWeight: FontWeight.bold,
                  )))
              .toList(),
          rows: solution_table
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
