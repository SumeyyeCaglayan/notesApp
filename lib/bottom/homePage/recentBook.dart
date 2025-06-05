import 'package:flutter/material.dart';
import 'package:notes/bottom/homePage/Details/recent_details.dart';
import 'package:notes/database/provider.dart';
import 'package:provider/provider.dart';

import 'Details/bookDetail.dart';

class RecentBooksSection extends StatefulWidget {
  const RecentBooksSection({super.key});

  @override
  State<RecentBooksSection> createState() => _RecentBooksSectionState();
}

class _RecentBooksSectionState extends State<RecentBooksSection> {

  @override
  Widget build(BuildContext context) {
    final favoritesProvider = Provider.of<UserProvider>(context);

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Text(
              'Güncel Notlar',
              style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
            ),
            TextButton(
              onPressed: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (context) => RecentDetails(),
                  ),
                );
              },
              child: Text('Tümü'),
            ),
          ],
        ),
        ListView.builder(
          itemCount: favoritesProvider.recentBooks.length,
          shrinkWrap: true,
          physics: NeverScrollableScrollPhysics(),
          itemBuilder: (context, index) {
            final book = favoritesProvider.recentBooks[index];
            return Card(
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(20),
              ),
              child: ListTile(
                contentPadding: EdgeInsets.symmetric(
                  horizontal: 16,
                  vertical: 8,
                ),
                leading: Icon(Icons.book, size: 40),
                title: Text(book['title'] ?? 'Başlık Yok'),
                subtitle: Text(book['description'] ?? 'Açıklama Yok'),
                trailing: IconButton(
                  onPressed: () => favoritesProvider.toggleFavorite(book),
                  icon: Icon(
                    book['isFav'] ? Icons.favorite : Icons.favorite_border,
                    color: book['isFav'] ? Colors.red : Colors.grey,
                  ),
                ),
                onTap: () {
                   Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (context) => BookDetailPage(book: book),
                    ),
                  );
                },
              ),
              
            );
          },
        ),
        
      ],
    );
  }
}
