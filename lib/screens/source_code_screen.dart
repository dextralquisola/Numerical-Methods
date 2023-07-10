import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

import 'package:flutter_highlight/flutter_highlight.dart';
import 'package:flutter_highlight/themes/obsidian.dart';
import 'package:numerical_project/utils/utils.dart';

import '../widgets/app_text.dart';

class SourceCodeScreen extends StatelessWidget {
  final String code;
  final String title;
  const SourceCodeScreen({
    super.key,
    required this.code,
    required this.title,
  });

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: AppText(
          text: 'Python Code for $title',
          textSize: 16,
          textColor: Colors.white,
        ),
      ),
      body: SingleChildScrollView(
        child: HighlightView(
          code,
          language: 'python',
          theme: obsidianTheme,
          padding: const EdgeInsets.all(12),
          textStyle: const TextStyle(
            fontFamily: 'monospace',
            fontSize: 12,
          ),
        ),
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () async {
          await Clipboard.setData(ClipboardData(text: code));
          if (context.mounted) {
            showSnackBar(context, "Copied to clipboard");
          }
        },
        child: const Icon(Icons.copy),
      ),
    );
  }
}
