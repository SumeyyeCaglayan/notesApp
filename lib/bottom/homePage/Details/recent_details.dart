import 'package:flutter/material.dart';
import '../../home.dart';
import 'book.dart';

class RecentDetails extends StatefulWidget {
  const RecentDetails({super.key});

  @override
  State<RecentDetails> createState() => _RecentDetailsState();
}

class _RecentDetailsState extends State<RecentDetails> {
  final List<Book> books = [
    Book(
      title: "Körlük",
      author: "Jose Saramago",
      pages: "350 pages",
      rating: 4.5,
      price: "176,02 ₺",
      isPaid: true,
      imageUrl: "assets/images/korluk.png",
    ),
    Book(
      title: "Kurtlarla Koşan Kadınlar",
      author: "Clarissa Pinkola Estes",
      pages: "550 pages",
      rating: 4.1,
      price: "ücretsiz",
      isPaid: false,
      imageUrl: "assets/images/kkk.png",
    ),
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        leading: IconButton(
          icon: Icon(Icons.arrow_back),
          onPressed: () {
            Navigator.pop(context);
          },
        ),
        backgroundColor: Colors.white,
        foregroundColor: Colors.black,
        elevation: 0,
      ),
      body: ListView.builder(
        itemCount: books.length,
        itemBuilder: (context, index) {
          final book = books[index];
          return Card(
            margin: EdgeInsets.symmetric(horizontal: 10, vertical: 5),
            child: ListTile(
              leading: Image.asset(
                book.imageUrl,
                width: 50,
                height: 50,
                fit: BoxFit.cover,
              ),
              title: Text(
                book.title,
                style: TextStyle(fontWeight: FontWeight.bold),
              ),
              subtitle: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(book.author),
                  Text(book.pages),
                  Row(
                    children: [
                      Icon(Icons.star, color: Colors.amber, size: 16),
                      SizedBox(width: 4),
                      Text(book.rating.toString()),
                    ],
                  ),
                ],
              ),
              trailing: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Text(
                    book.price,
                    style: TextStyle(
                      color:
                          book.isPaid
                              ? Colors.red
                              : Colors
                                  .green, // Ücretli ise kırmızı, ücretsiz ise yeşil renk
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ],
              ),
            ),
          );
        },
      ),
    );
  }
}
