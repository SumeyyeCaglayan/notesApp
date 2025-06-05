import 'package:flutter/material.dart';
import 'package:google_nav_bar/google_nav_bar.dart';
import 'category.dart';
import 'favorite.dart';
import 'home.dart';
import 'mylibrary/mylibrary.dart';

class BottomPage extends StatefulWidget {
  const BottomPage({super.key});

  @override
  _BottomPageState createState() => _BottomPageState();
}

class _BottomPageState extends State<BottomPage> {
  int _pageIndex = 0;
  final PageController _pageController = PageController(initialPage: 0);

  @override
  void dispose() {
    _pageController.dispose();
    super.dispose();
  }

  final List<Widget> _pages = [
    HomePage(),
    FavoritePage(),
    CategoryPage(categoryName: '',),
    MyLibraryPage(),
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: PageView(
        controller: _pageController,
        onPageChanged: (index) {
          setState(() {
            _pageIndex = index;
          });
        },
        children: _pages,
      ),
      bottomNavigationBar: _buildBottomNavigationBar(),
    );
  }

  Widget _buildBottomNavigationBar() {
    return Padding(
      padding: const EdgeInsets.all(12.0),
      child: ClipRRect(
        borderRadius: BorderRadius.circular(50),
        child: Container(
          decoration: BoxDecoration(
            color: Color(0xFFF5F5F5),
            boxShadow: [
              BoxShadow(
                color: Colors.grey.withOpacity(0.3),
                spreadRadius: 2,
                blurRadius: 10,
                offset: Offset(0, 3),
              ),
            ],
          ),
          child: Padding(
            padding: const EdgeInsets.symmetric(horizontal: 7.0, vertical: 7.0),
            child: GNav(
              selectedIndex: _pageIndex,
              color: Colors.grey,
              activeColor: Colors.black,
              gap: 8,
              padding: EdgeInsets.symmetric(horizontal: 20, vertical: 10),
              tabBackgroundColor: Colors.transparent,
              duration: Duration(milliseconds: 350),
              tabs: const [
                GButton(icon: Icons.home_outlined, text: 'Ana Sayfa'),
                GButton(icon: Icons.favorite_border, text: 'Favoriler'),
                GButton(icon: Icons.grid_view, text: 'Kategoriler'),
                GButton(icon: Icons.library_books_outlined, text: 'Kütüphanem'),
              ],
              onTabChange: (index) {
                setState(() {
                  _pageIndex = index;
                });
                _pageController.jumpToPage(index);
              },
            ),
          ),
        ),
      ),
    );
  }
}
