import 'package:flutter/material.dart';
import 'package:numerical_project/widgets/app_button.dart';
import 'package:numerical_project/widgets/app_textfield.dart';
import 'package:provider/provider.dart';

import '../provider/provider.dart';

class PreferencesScreen extends StatefulWidget {
  static const routeName = '/preferences';
  const PreferencesScreen({super.key});

  @override
  State<PreferencesScreen> createState() => _PreferencesScreenState();
}

class _PreferencesScreenState extends State<PreferencesScreen> {
  final nameController = TextEditingController();
  final decimalPlacesController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    final appState = Provider.of<AppState>(context);

    nameController.text = appState.name;
    decimalPlacesController.text = appState.decimalPlaces.toString();
    return Scaffold(
      resizeToAvoidBottomInset: false,
      appBar: AppBar(
        title: const Text('Preferences'),
      ),
      body: Padding(
        padding: const EdgeInsets.all(20.0),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            AppTextField(
              controller: nameController,
              labelText: 'Name',
              hintText: 'Enter your name',
            ),
            const SizedBox(height: 20),
            AppTextField(
              controller: decimalPlacesController,
              labelText: 'Round to decimal places',
              hintText: 'Enter decimal places',
            ),
            const SizedBox(height: 20),
            AppButton(
              height: 50,
              wrapRow: true,
              onPressed: () {
                appState.setName(nameController.text);
                appState
                    .setDecimalPlaces(int.parse(decimalPlacesController.text));
                Navigator.pop(context);
              },
              text: "Save",
            )
          ],
        ),
      ),
    );
  }
}
