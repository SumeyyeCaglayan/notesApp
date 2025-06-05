
import 'package:flutter/material.dart';

class CategoryItem {
  final String imagePath;
  final String label;

  CategoryItem({required this.imagePath, required this.label});
}

// New page that will be shown when category is clicked
class CategoryPage extends StatelessWidget {
  final String categoryName;

  const CategoryPage({super.key, required this.categoryName});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(categoryName),
        backgroundColor: Color(0xFFE9E9D9),
      ),
      body: Center(
        child: Text(
          '$categoryName',
          style: const TextStyle(fontSize: 24),
        ),
      ),
    );
  }
}