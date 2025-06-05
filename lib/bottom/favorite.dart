import 'package:flutter/material.dart';
import 'package:notes/database/provider.dart';
import 'package:provider/provider.dart';


class FavoritePage extends StatelessWidget {
  const FavoritePage({super.key});

  @override
  Widget build(BuildContext context) {
    final favoriteBooks = Provider.of<UserProvider>(context).favoriteBooks;

    return Scaffold(
      body: favoriteBooks.isEmpty
          ? Center(child: Text("Henüz favorilere eklenen kitap yok."))
          : ListView.builder(
              itemCount: favoriteBooks.length,
              itemBuilder: (context, index) {
                final book = favoriteBooks[index];
                return ListTile(
                  leading: Icon(Icons.book),
                  title: Text(book['title'] ?? 'Başlık Yok'),
                  subtitle: Text(book['description'] ?? 'Açıklama Yok'),
                );
              },
            ),
    );
  }
}
