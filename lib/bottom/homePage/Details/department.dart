import 'package:flutter/material.dart';


class Department extends StatefulWidget {
  final String categoryName;

  const Department({super.key, required this.categoryName});

  @override
  State<Department> createState() => _DepartmentState();
}

class _DepartmentState extends State<Department> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(widget.categoryName),
        backgroundColor: Color(0xFFE9E9D9),
      ),
      body: Center(
        child: Text(
          '${widget.categoryName} notları gösterilecek',
          style: const TextStyle(fontSize: 24),
        ),
      ),
    );
  }
}
