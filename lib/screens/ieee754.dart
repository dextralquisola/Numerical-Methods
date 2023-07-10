import 'package:flutter/material.dart';
import 'package:numerical_project/constants/constants.dart';
import 'package:numerical_project/screens/source_code_screen.dart';
import 'package:numerical_project/solutions/ieee754.dart';
import 'package:numerical_project/utils/utils.dart';
import 'package:numerical_project/widgets/app_button.dart';
import 'package:numerical_project/widgets/app_text.dart';
import 'package:numerical_project/widgets/app_textfield.dart';

import '../constants/source_code.dart';

class IEEE754Screen extends StatefulWidget {
  static const routeName = '/ieee754';
  const IEEE754Screen({super.key});

  @override
  State<IEEE754Screen> createState() => _IEEE754ScreenState();
}

class _IEEE754ScreenState extends State<IEEE754Screen> {
  final decimalController = TextEditingController();

  var is32bit = true;

  var converted = "";

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("IEEE754 Format Converter"),
        actions: [
          IconButton(
            onPressed: () {
              Navigator.of(context).push(MaterialPageRoute(builder: (_) {
                return SourceCodeScreen(
                  code: code[5],
                  title: "IEEE 754 Converter",
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
          child: Column(
            children: [
              AppTextField(
                  controller: decimalController,
                  labelText: "Number",
                  hintText: "Enter number",
                  textInputType: const TextInputType.numberWithOptions(
                    decimal: true,
                    signed: false,
                  )),
              const SizedBox(
                height: 20,
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceAround,
                children: [
                  Expanded(
                    flex: 3,
                    child: Row(
                      children: [
                        Radio(
                            value: true,
                            groupValue: is32bit,
                            onChanged: (e) {
                              setState(() {
                                is32bit = e!;
                              });
                            }),
                        const Expanded(
                          child: AppText(text: '32 bit (Single Precision)'),
                        )
                      ],
                    ),
                  ),
                  Expanded(
                    flex: 3,
                    child: Row(
                      children: [
                        Radio(
                          value: false,
                          groupValue: is32bit,
                          onChanged: (e) {
                            setState(() {
                              is32bit = e!;
                            });
                          },
                        ),
                        const Expanded(
                            child: AppText(
                          text: '64 bit (Double Precision)',
                        ))
                      ],
                    ),
                  ),
                ],
              ),
              const SizedBox(
                height: 20,
              ),
              if (converted != "") ...[
                const Divider(
                  color: Colors.grey,
                ),
                const AppText(
                  text: "Result: ",
                  textSize: 20,
                  fontWeight: FontWeight.w600,
                ),
                const SizedBox(height: 5),
                AppText(
                  text: converted,
                  textSize: 20,
                ),
                const SizedBox(
                  height: 10,
                ),
              ],
              AppButton(
                height: 50,
                wrapRow: true,
                bgColor: converted == "" ? primaryColor : Colors.red,
                onPressed: converted == ""
                    ? () {
                        try {
                          FocusManager.instance.primaryFocus?.unfocus();
                          converted = IEEE754(
                            double.parse(decimalController.text),
                            is32Bit: is32bit,
                          ).solve();
                          setState(() {});
                        } catch (e) {
                          showSnackBar(context, e.toString());
                        }
                      }
                    : () {
                        setState(() {
                          converted = "";
                          decimalController.text = "";
                          is32bit = true;
                        });
                      },
                text: converted == "" ? "Convert" : "Clear",
              ),
            ],
          ),
        ),
      ),
    );
  }
}
