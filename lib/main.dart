import 'package:flutter/material.dart';
import 'package:numerical_project/provider/provider.dart';
import 'package:numerical_project/widgets/app_text.dart';
import 'package:provider/provider.dart';

import './screens/home_screen.dart';
import './router.dart';

void main() {
  runApp(
    MultiProvider(
      providers: [
        ChangeNotifierProvider(create: (_) => AppState()),
      ],
      child: const MyApp(),
    ),
  );
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Numerical',
      theme: ThemeData(
        fontFamily: 'Oxygen',
        primarySwatch: Colors.deepPurple,
        appBarTheme: const AppBarTheme(
          backgroundColor: Colors.deepPurple,
          foregroundColor: Colors.white,
          elevation: 0,
        ),
        floatingActionButtonTheme: const FloatingActionButtonThemeData(
          backgroundColor: Colors.deepPurple,
          foregroundColor: Colors.white,
        ),
        colorScheme: ColorScheme.fromSeed(seedColor: Colors.deepPurple),
        useMaterial3: true,
      ),
      home: FutureBuilder(
        future: Future.wait([
          Provider.of<AppState>(context, listen: false).getState(),
          Future.delayed(const Duration(seconds: 2)),
        ]),
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return const Scaffold(
              body: Padding(
                padding: EdgeInsets.all(20.0),
                child: Column(
                  children: [
                    Spacer(),
                    AppText(
                      text: "Numerical and Symbolic Computations",
                      textSize: 30,
                      textAlign: TextAlign.center,
                    ),
                    SizedBox(height: 20),
                    AppText(text: "BSCS 4-2 Group 8", textSize: 20),
                    SizedBox(height: 20),
                    Center(
                      child: CircularProgressIndicator(),
                    ),
                    Spacer(),
                  ],
                ),
              ),
            );
          }

          return const HomeScreen();
        },
      ),
      onGenerateRoute: (settings) => generateRoute(settings),
    );
  }
}
