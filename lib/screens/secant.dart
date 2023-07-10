import 'package:flutter/material.dart';
import 'package:numerical_project/screens/source_code_screen.dart';
import 'package:numerical_project/solutions/secant.dart';
import 'package:numerical_project/utils/utils.dart';
import 'package:numerical_project/widgets/app_textfield.dart';
import 'package:provider/provider.dart';

import '../constants/source_code.dart';
import '../provider/provider.dart';
import '../widgets/app_button.dart';
import '../widgets/app_text.dart';

class SecantScreen extends StatefulWidget {
  static const routeName = '/secant';
  const SecantScreen({super.key});

  @override
  State<SecantScreen> createState() => _SecantScreenState();
}

class _SecantScreenState extends State<SecantScreen> {
  final formulaController = TextEditingController();

  final firstGuessController = TextEditingController();
  final secondGuessController = TextEditingController();

  final toleranceController = TextEditingController();

  List<List<String>> solutionsTable = [];

  @override
  void initState() {
    toleranceController.text = "0.0001";
    firstGuessController.text = "0";
    secondGuessController.text = "1";
    formulaController.text = "x^2 - 3";
    super.initState();
  }

  @override
  void dispose() {
    formulaController.dispose();
    firstGuessController.dispose();
    secondGuessController.dispose();
    toleranceController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final appState = Provider.of<AppState>(context);
    return Scaffold(
      appBar: AppBar(
        title: const Text("Secant Method"),
        actions: [
          IconButton(
            onPressed: () {
              Navigator.of(context).push(MaterialPageRoute(builder: (_) {
                return SourceCodeScreen(
                  code: code[3],
                  title: "Secant Method",
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
        child: solutionsTable.isNotEmpty
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
                              labelText: "First Guess xA",
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
                              labelText: "Second Guess xB",
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
                          solutionsTable = Secant(
                            function: formulaController.text,
                            inputXA: double.parse(firstGuessController.text),
                            inputXB: double.parse(secondGuessController.text),
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
          text: "Results found after ${solutionsTable.length - 1} iterations",
          fontWeight: FontWeight.w600,
          textSize: 20,
        ),
        const SizedBox(height: 5),
        TextButton(
            onPressed: () {
              setState(() {
                solutionsTable = [];
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
          columns: solutionsTable[0]
              .map((e) => DataColumn(
                      label: AppText(
                    text: e,
                    alignment: Alignment.centerRight,
                    fontWeight: FontWeight.bold,
                  )))
              .toList(),
          rows: solutionsTable
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
