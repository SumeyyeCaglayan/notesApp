import 'package:flutter/material.dart';

class UploadPage extends StatefulWidget {
  const UploadPage({super.key});

  @override
  State<UploadPage> createState() => _UploadPageState();
}

class _UploadPageState extends State<UploadPage> {
  final List<String> _notes = [];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Column(
        children: [
          Expanded(
            child:
                _notes.isEmpty
                    ? const Center(child: Text('henüz not eklmenmedi'))
                    : ListView.builder(
                      itemCount: _notes.length,
                      itemBuilder: (context, index) {
                        return ListTile(
                          leading: const Icon(Icons.note),
                          title: Text(_notes[index]),
                          trailing: IconButton(
                            icon: Icon(Icons.delete, color: Colors.red),
                            onPressed: () {
                              setState(() {
                                _notes.removeAt(index);
                              });
                            },
                          ),
                        );
                      },
                    ),
          ),
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: ElevatedButton(
              onPressed: () {
                setState(() {
                  _notes.add('Not ${_notes.length + 1}');
                });
              },
              style: ButtonStyle(
                backgroundColor: MaterialStateProperty.all(Colors.white), 
                foregroundColor: MaterialStateProperty.all(Colors.black),
                side: MaterialStateProperty.all(
                  BorderSide(
                    color: Colors.black,
                    width: 2,
                  ), 
                ),
                shadowColor: MaterialStateProperty.all(Colors.transparent), 
              ),
              child: const Text('Not Yükle'),
            ),
          ),
        ],
      ),
    );
  }
}
// not yüklemede önce yükleyeceği şeyi seçtir daha sonra yüklediği not hakkında bilgi al