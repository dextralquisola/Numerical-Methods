import 'package:flutter/material.dart';
import 'package:numerical_project/widgets/app_text.dart';
import '../models/menu.dart';

class MenuWidget extends StatelessWidget {
  final MenuItem menuItem;
  const MenuWidget({
    super.key,
    required this.menuItem,
  });

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        Navigator.of(context).pushNamed(menuItem.route);
      },
      child: Padding(
        padding: const EdgeInsets.only(
          left: 16,
          right: 16,
          bottom: 5,
        ),
        child: Card(
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(15.0),
          ),
          child: Padding(
            padding: const EdgeInsets.all(10.0),
            child: ListTile(
              title: AppText(
                text: menuItem.title,
                textSize: 20,
              ),
              subtitle: AppText(
                text: menuItem.description,
                textColor: Colors.grey[700],
                textSize: 14,
              ),
              trailing: Icon(
                Icons.arrow_forward_ios_rounded,
                color: Theme.of(context).colorScheme.primary,
              ),
            ),
          ),
        ),
      ),
    );
  }
}
