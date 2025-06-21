import 'package:flutter/material.dart';
import 'package:dooit/widgets/category_button.dart';

class CategoryGrid extends StatelessWidget {
  final List<Map<String, dynamic>> categories;
  final Function(String id, String label)? onCategoryTap;
  final Function(String id, String label)? onCategoryLongPress;

  const CategoryGrid({
    super.key,
    required this.categories,
    this.onCategoryTap,
    this.onCategoryLongPress,
  });

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
          id: category['id'],
          onTap: onCategoryTap != null && category['id'] != null
              ? () => onCategoryTap!(category['id'], category['label'])
              : null,
          onLongPress: onCategoryLongPress != null && category['id'] != null
              ? () => onCategoryLongPress!(category['id'], category['label'])
              : null,
        );
          }).toList(),
    );
  }
}
