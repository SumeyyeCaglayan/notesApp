import 'package:flutter/material.dart';

class HorizontalBookSection extends StatefulWidget {
  final String title; 
  final List<Map<String, String>> books; 

  const HorizontalBookSection({
    super.key,
    required this.title, 
    required this.books, 
  });

  @override
  State<HorizontalBookSection> createState() => _HorizontalBookSectionState();
}

class _HorizontalBookSectionState extends State<HorizontalBookSection> {
  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          widget.title, 
          style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold), 
        ),
        SizedBox(height: 10),
        SizedBox(
          height: 180,
          child: ListView.builder(
            scrollDirection: Axis.horizontal, 
            itemCount: widget.books.length, 
            itemBuilder: (context, index) {
              return Container(
                margin: EdgeInsets.only(right: 10), 
                width: 150,
                child: Card(
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(20),
                  ),
                  child: Padding(
                    padding: const EdgeInsets.all(8.0), 
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start, 
                      children: [
                        Container(
                          height: 100, 
                          decoration: BoxDecoration(
                            color: Colors.grey[300], 
                            borderRadius: BorderRadius.circular(8), 
                          ),
                          child: Center(
                            child: Text(widget.books[index]['title']!), 
                          ),
                        ),
                        SizedBox(height: 5), 
                        Text(
                          widget.books[index]['author']!, 
                          style: TextStyle(fontSize: 12), 
                        ),
                      ],
                    ),
                  ),
                ),
              );
            },
          ),
        ),
        SizedBox(height: 20), 
      ],
    );
  }
}
