import 'package:flutter/material.dart';
import 'package:dooit/widgets/category_button.dart';

class CategoryGrid extends StatelessWidget {
  final List<Map<String, dynamic>> categories;

  const CategoryGrid({super.key, required this.categories});

  @override
  Widget build(BuildContext context) {
    return Wrap(
      spacing: 30,
      runSpacing: 30,
      children:
          categories.map((category) {
            return CategoryButton(
              icon: category['icon'],
              label: category['label'],
            );
          }).toList(),
    );
  }
}
