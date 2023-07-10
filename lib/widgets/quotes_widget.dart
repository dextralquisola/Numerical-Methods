import 'dart:math';

import 'package:flutter/material.dart';
import 'package:numerical_project/widgets/app_text.dart';

import '../constants/constants.dart';
import '../models/quotes.dart';

class QuotesCard extends StatefulWidget {
  const QuotesCard({
    super.key,
  });

  @override
  State<QuotesCard> createState() => _QuotesCardState();
}

class _QuotesCardState extends State<QuotesCard> {
  @override
  Widget build(BuildContext context) {
    Random random = Random();
    int randomNumber = random.nextInt(quotes.length);
    Quote quote = quotes[randomNumber];
    return Padding(
      padding: const EdgeInsets.only(
        left: 16,
        right: 16,
        bottom: 5,
      ),
      child: Card(
        child: Padding(
          padding: const EdgeInsets.all(20.0),
          child: SizedBox(
            height: 150,
            width: double.infinity,
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                AppText(
                  text: quote.text,
                  textSize: quote.text.length > 100 ? 12 : 14,
                  textAlign: TextAlign.center,
                  fontStyle: FontStyle.italic,
                ),
                const SizedBox(height: 10),
                AppText(
                  text: quote.author,
                  textSize: 14,
                  fontWeight: FontWeight.w400,
                  textAlign: TextAlign.right,
                ),
                const SizedBox(height: 10),
                TextButton(
                    onPressed: () {
                      setState(() {});
                    },
                    child: const Text('Randomize',
                        style: TextStyle(color: Colors.grey, fontSize: 14))),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
