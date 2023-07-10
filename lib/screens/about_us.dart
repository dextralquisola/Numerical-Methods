import 'package:flutter/material.dart';
import 'package:numerical_project/widgets/app_text.dart';

class AboutUsScreen extends StatelessWidget {
  static const routeName = '/about-us';
  const AboutUsScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('About Us'),
      ),
      body: SingleChildScrollView(
        child: Container(
          padding: const EdgeInsets.all(16.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [
              const AppText(
                text:
                    "We are BSCS 4-2 Group 8, students from the Cavite State University - Indang. We are currently taking Numerical and Symbolic Computations (COSC 110) under Ma'am Maria Loriza Arbonida Miranda. This app is our final project for the course.",
                textSize: 16,
                textAlign: TextAlign.justify,
              ),
              profileBuilder(
                'Dexter Jay P. Alquisola',
                "Beard Papi",
                'assets/images/dj.jpg',
              ),
              profileBuilder(
                'Andrea Joy Cruto',
                'Techie',
                'assets/images/kria.jpg',
              ),
              profileBuilder(
                'Paulo Anzures Ferrer',
                'Ballistic',
               'assets/images/paolo.jpg',
              ),
              profileBuilder(
                'Jerome Daniel Valenzuela',
                'Mind Thief',
                'assets/images/jerome.jpg',
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget profileBuilder(String name, String title, String imagepath) {
    return Column(
      children: [
        const SizedBox(height: 32.0),
        CircleAvatar(
          radius: 80.0,
          backgroundImage: AssetImage(imagepath),
        ),
        const SizedBox(height: 16.0),
        Text(
          name,
          style: const TextStyle(
            fontSize: 24.0,
            fontWeight: FontWeight.bold,
          ),
          textAlign: TextAlign.center,
        ),
        const SizedBox(height: 8.0),
        Text(
          title,
          style: TextStyle(
            fontSize: 16.0,
            color: Colors.grey[600],
          ),
          textAlign: TextAlign.center,
        ),
      ],
    );
  }
}
