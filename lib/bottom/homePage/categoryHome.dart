import 'package:flutter/material.dart';

import 'Details/category_details.dart';

class CategorySection extends StatefulWidget {
  const CategorySection({super.key});

  @override
  State<CategorySection> createState() => _CategorySectionState();
}

class _CategorySectionState extends State<CategorySection> {
  final List<String> categories = [
    'Kategori1',
    'Kategori2',
    'Kategori3',
    'Kategori4',
    'Kategori5'
  ];

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Text(
              'Kategoriler',
              style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
            ),
            TextButton(
              onPressed: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(builder: (context) => CategoryDetails()),
                );
              }, 
              child: Text('Tümünü Gör'),
            ),
          ],
        ),
        Wrap(
          spacing: 8.0,
          children:
              categories
                  .map(
                    (category) => Chip(
                      label: Text(category),
                      labelStyle: TextStyle(color: Colors.black),
                      backgroundColor: Colors.grey[200],
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(50),
                        side: BorderSide(width: 2),
                      ),
                    ),
                  )
                  .toList(),
        ),
      ],
    );
  }
}
