import 'package:flutter/material.dart';
import 'package:numerical_project/screens/source_code_screen.dart';
import 'package:numerical_project/utils/utils.dart';
import 'package:provider/provider.dart';

import '../constants/source_code.dart';
import '../provider/provider.dart';
import '../solutions/jacobi.dart';
import '../widgets/app_button.dart';
import '../widgets/app_text.dart';
import '../widgets/app_textfield.dart';

class JacobiScreen extends StatefulWidget {
  static const routeName = '/jacobi';
  const JacobiScreen({super.key});

  @override
  State<JacobiScreen> createState() => _JacobiScreenState();
}

class _JacobiScreenState extends State<JacobiScreen> {
  final firstEquationController = TextEditingController();
  final secondEquationController = TextEditingController();
  final thirdEquationController = TextEditingController();
  final toleranceController = TextEditingController();

  List<List<String>> solutionTable = [];

  @override
  void initState() {
    firstEquationController.text = "3x + 2y + z = 2.5";
    secondEquationController.text = "3y + x = -2";
    thirdEquationController.text = "y + z = 5";
    toleranceController.text = "0.0001";
    super.initState();
  }

  @override
  void dispose() {
    firstEquationController.dispose();
    secondEquationController.dispose();
    thirdEquationController.dispose();
    toleranceController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final appState = Provider.of<AppState>(context);
    return Scaffold(
      appBar: AppBar(
        title: const Text("Jacobi Iteration Method"),
        actions: [
          IconButton(
            onPressed: () {
              Navigator.of(context).push(MaterialPageRoute(builder: (_) {
                return SourceCodeScreen(
                  code: code[4],
                  title: "Jacobi Method",
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
          padding: const EdgeInsets.all(20),
          child: solutionTable.isNotEmpty
              ? resultsBuilder()
              : Column(
                  children: [
                    AppTextField(
                        controller: firstEquationController,
                        labelText: "Equation 1"),
                    const SizedBox(height: 10),
                    AppTextField(
                        controller: secondEquationController,
                        labelText: "Equation 2"),
                    const SizedBox(height: 10),
                    AppTextField(
                        controller: thirdEquationController,
                        labelText: "Equation 3"),
                    const SizedBox(height: 20),
                    AppTextField(
                      controller: toleranceController,
                      labelText: "Tolerance",
                      hintText: "0.0001",
                    ),
                    const SizedBox(height: 20),
                    AppButton(
                      wrapRow: true,
                      height: 50,
                      onPressed: () {
                        try {
                          solutionTable = Jacobi(
                            [
                              firstEquationController.text,
                              secondEquationController.text,
                              thirdEquationController.text,
                            ],
                            decimalPlaces: appState.decimalPlaces,
                            tolerance: double.parse(toleranceController.text),
                          ).solve();

                          setState(() {});
                        } catch (e) {
                          showSnackBar(context, e.toString());
                        }
                      },
                      text: "Calculate",
                    )
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
