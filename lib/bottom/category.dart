import 'package:flutter/material.dart';

import 'homePage/Details/department.dart';

class CategoryPage extends StatefulWidget {
  final String categoryName;
  const CategoryPage({super.key, required this.categoryName});

  @override
  State<CategoryPage> createState() => CategoryPageState();
}

class CategoryPageState extends State<CategoryPage> {
  final List<CategoryItem> categories = [
    CategoryItem(
      imagePath: 'assets/images/ceng.png',
      label: 'Bilgisayar Mühendisliği',
    ),
    CategoryItem(imagePath: 'assets/images/tıp.png', label: 'Tıp'),
    CategoryItem(
      imagePath: 'assets/images/bseng.png',
      label: 'Bilişim Sistemleri Mühendisi',
    ),
    CategoryItem(
      imagePath: 'assets/images/so.png',
      label: 'Sınıf Öğretmenliği',
    ),
    CategoryItem(imagePath: 'assets/images/nur.png', label: 'Hemşirelik'),
    CategoryItem(imagePath: 'assets/images/co.png', label: 'Aşçılık'),
    CategoryItem(imagePath: 'assets/images/pyh.png', label: 'Fizik'),
    CategoryItem(
      imagePath: 'assets/images/air.png',
      label: 'Havacılık ve Uzay Mühendisliği',
    ),
    CategoryItem(imagePath: 'assets/images/h.png', label: 'Hukuk'),
    CategoryItem(imagePath: 'assets/images/mim.png', label: 'Mimarlık'),
  ];

  void onCategoryClicked(String label) {
    Navigator.push(
      context,
      MaterialPageRoute(builder: (context) => Department(categoryName: label)),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('CATEGORIES'),
        centerTitle: true,
        automaticallyImplyLeading: false,
        backgroundColor: Color(0xFFE9E9D9),
        actions: [IconButton(icon: const Icon(Icons.search), onPressed: () {})],
      ),
      body: Padding(
        padding: const EdgeInsets.all(8.0),
        child: GridView.builder(
          itemCount: categories.length,
          gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
            crossAxisCount: 3,
            crossAxisSpacing: 8.0,
            mainAxisSpacing: 8.0,
          ),
          itemBuilder: (context, index) {
            final category = categories[index];
            return GestureDetector(
              onTap: () => onCategoryClicked(category.label),
              child: Container(
                decoration: BoxDecoration(
                  color: const Color.fromARGB(255, 224, 224, 224),
                  borderRadius: BorderRadius.circular(8.0),
                  boxShadow: [
                    BoxShadow(
                      color: const Color.fromARGB(255, 136, 134, 134),
                      blurRadius: 4,
                      offset: Offset(0, 2),
                    ),
                  ],
                ),
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Expanded(
                      flex: 3,
                      child: Container(
                        margin: const EdgeInsets.all(8.0),
                        decoration: BoxDecoration(
                          color: Colors.grey.shade200,
                          borderRadius: BorderRadius.circular(8.0),
                          image: DecorationImage(
                            image: AssetImage(category.imagePath),
                            fit: BoxFit.cover,
                          ),
                        ),
                      ),
                    ),
                    Expanded(
                      flex: 1,
                      child: Center(
                        child: Text(
                          category.label,
                          style: const TextStyle(
                            fontSize: 12,
                            fontWeight: FontWeight.bold,
                          ),
                          textAlign: TextAlign.center,
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            );
          },
        ),
      ),
    );
  }
}

class CategoryItem {
  final String imagePath;
  final String label;

  CategoryItem({required this.imagePath, required this.label});
}
