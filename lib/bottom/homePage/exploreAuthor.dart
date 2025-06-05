import 'package:flutter/material.dart';

import 'Details/authorpage.dart';

class ExploreAuthorsSection extends StatefulWidget {
  const ExploreAuthorsSection({super.key});

  @override
  State<ExploreAuthorsSection> createState() => _ExploreAuthorsSectionState();
}

class _ExploreAuthorsSectionState extends State<ExploreAuthorsSection> {
  final List<String> authors = ['Yazar1', 'Yazar2', 'Yazar3', 'Yazar3'];

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Text(
              'Yazarları Keşfedin',
              style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
            ),
            TextButton(
              onPressed: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(builder: (context) => AuthorPage()),
                );
              }, // Y?azarlar için yeni bir sayfa
              child: Text('Tümünü Gör'),
            ),
          ],
        ),
        SizedBox(height: 10),
        SizedBox(
          height: 80,
          child: ListView.builder(
            scrollDirection: Axis.horizontal,
            itemCount: authors.length,
            itemBuilder: (context, index) {
              return Padding(
                padding: const EdgeInsets.symmetric(horizontal: 4.0),
                child: Column(
                  children: [
                    CircleAvatar(
                      radius: 30, // Burada yazarın adının ilk harfi gösterilkir
                      child: Text(authors[index][0]),
                    ),
                    SizedBox(height: 3),
                    Text(authors[index], style: TextStyle(fontSize: 12)),
                  ],
                ),
              );
            },
          ),
        ),
      ],
    );
  }
}
