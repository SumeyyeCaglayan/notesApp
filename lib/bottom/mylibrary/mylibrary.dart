import 'package:flutter/material.dart';
import 'download.dart';
import 'upload.dart';

class MyLibraryPage extends StatefulWidget {
  const MyLibraryPage({super.key});

  @override
  State<MyLibraryPage> createState() => _MyLibraryPageState();
}

class _MyLibraryPageState extends State<MyLibraryPage> {
  @override
  Widget build(BuildContext context) {
    return DefaultTabController(
      length: 2,
      child: Scaffold(
        appBar: AppBar(
          elevation: 0.0,
          excludeHeaderSemantics: false,
          backgroundColor: const Color(0xFFE9E9D9),
          automaticallyImplyLeading: false,
          title: Row(
            children: [
              Expanded(
                child: TabBar(
                  tabs: [Tab(text: 'Yüklenenler'), Tab(text: 'İndirilenler')],
                  indicator: BoxDecoration(
                    color:
                        Colors.white70, 
                    borderRadius: BorderRadius.circular(25), 
                    border: Border.all(
                      color: Colors.black, 
                      width: 1.5, 
                    ),
                  ),
                  labelColor: Colors.black,
                  unselectedLabelColor:
                      Colors.black, 
                  unselectedLabelStyle: const TextStyle(
                    fontWeight: FontWeight.normal,
                  ),
                  labelStyle: const TextStyle(
                    fontWeight: FontWeight.bold,
                    color: Colors.black,
                  ),
                  indicatorSize:
                      TabBarIndicatorSize.tab,
                ),
              ),
            ],
          ),
        ),
        body: TabBarView(
          children: [
            UploadPage(),
            DownloadPage(),
          ],
        ),
      ),
    );
  }
}
