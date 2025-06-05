import 'package:flutter/material.dart';
import 'package:notes/database/model.dart';
import 'package:notes/database/provider.dart';
import '/database/db_helper.dart';
import 'package:provider/provider.dart';
import 'bottom_page.dart';
import 'homePage/categoryHome.dart';
import 'homePage/exploreAuthor.dart';
import 'homePage/horizontalBook.dart';
import 'homePage/notifications.dart';
import 'homePage/profile_page.dart';
import 'homePage/recentBook.dart';

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  //String get email => email;
  @override
  Widget build(BuildContext context) {
    final user = Provider.of<UserProvider>(context).user;
    return Scaffold(
      appBar: AppBar(
        automaticallyImplyLeading: false,
        title: Row(
          children: [
            GestureDetector(
              onTap: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(builder: (context) => ProfilePage()),
                );
              },
              child: CircleAvatar(
                radius: 20, // Resim ekle!
                backgroundColor: Colors.grey.shade700,
              ),
            ),
            const SizedBox(width: 12),
            Expanded(
              child:
                  user != null
                      ? Text(
                        //'Merhaba ${context.watch<UserProvider>().user!.name}',
                        'Merhaba, ${user.name}!',
                        //${context.watch<Counter>().count}
                        style: TextStyle(
                          fontSize: 24,
                          fontWeight: FontWeight.bold,
                        ),
                      )
                      : Text('Hoş geldiniz!'),

              // Text(//comsumer kullanılabilir
              //   '${Provider.of<UserProvider>(context).name}',
              //   //'merhaba ${Provider.of<UserProvider>(context).name}',
              //   //'merhaba',
              //   //'Merhaba $userName!',
              //   style: const TextStyle(
              //     fontSize: 24,
              //     fontWeight: FontWeight.bold,
              //   ),
              //   overflow:
              //       TextOverflow.ellipsis, // Uzun isimlerin kesilmesi için
              // ),
            ),
          ],
        ),
        backgroundColor: Colors.transparent,
        elevation: 0,
        actions: [
          IconButton(
            icon: const Icon(Icons.notifications_none),
            onPressed: () {
              Navigator.push(
                context,
                MaterialPageRoute(builder: (context) => NotificationPage()),
              );
            },
          ),
        ],
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.symmetric(horizontal: 16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            SizedBox(height: 10),
            TextField(
              decoration: InputDecoration(
                hintText: 'Arama Butonu',
                prefixIcon: Icon(Icons.search),
                border: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(30),
                  borderSide: BorderSide.none,
                ),
                filled: true,
                fillColor: Colors.grey[200],
              ),
            ),
            SizedBox(height: 20),
            CategorySection(), // Kategoriler
            SizedBox(height: 20),
            RecentBooksSection(), //Güncel
            SizedBox(height: 20),
            HorizontalBookSection(
              title: 'En popüler Notlar',
              books: bookList,
            ), // En popüler kitaplar
            SizedBox(height: 20),
            HorizontalBookSection(
              title: 'En Çok Satanlar',
              books: bookList,
            ), // En çok satanlar
            SizedBox(height: 20),
            ExploreAuthorsSection(), // Yazarlar
            SizedBox(height: 20),
          ],
        ),
      ),
    );
  }
}

final List<Map<String, String>> bookList = [
  {'title': 'Not Başlığı 1', 'author': 'Yazar 1'},
  {'title': 'Not Başlığı 2', 'author': 'Yazar 2'},
  {'title': 'Not Başlığı 3', 'author': 'Yazar 3'},
  {'title': 'Not Başlığı 4', 'author': 'Yazar 4'},
  {'title': 'Not Başlığı 5', 'author': 'Yazar 5'},
];
