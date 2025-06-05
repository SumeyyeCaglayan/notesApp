import 'dart:io';

import 'package:flutter/material.dart';
import 'package:flutter_speed_dial/flutter_speed_dial.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:image_picker/image_picker.dart';
import 'package:notes/welcome/welcome_page.dart';
import 'package:provider/provider.dart';
import '../../database/provider.dart';
import '../../database/db_helper.dart';
import '../../welcome/welcome_screen.dart';
import 'Details/calendar.dart';

class ProfilePage extends StatefulWidget {
  const ProfilePage({super.key});

  @override
  State<ProfilePage> createState() => _ProfilePageState();
}

class _ProfilePageState extends State<ProfilePage> {
  final TextEditingController emailController = TextEditingController();
  final TextEditingController nameController = TextEditingController();
  final TextEditingController surnameController = TextEditingController();
  final TextEditingController departmentController = TextEditingController();
  final TextEditingController gradeController = TextEditingController();

  final DataBaseHelper db = DataBaseHelper();

  @override
  void initState() {
    super.initState();
    final user = Provider.of<UserProvider>(context, listen: false).user;
    nameController.text = user?.name ?? '';
    emailController.text = user?.email ?? '';
    surnameController.text = user?.surname ?? '';
    departmentController.text = user?.department ?? '';
    gradeController.text = user?.grade ?? '';
    db.connectToDatabase();
  }

  void _updateUserInfo() async {
    final userProvider = Provider.of<UserProvider>(context, listen: false);

    final updatedUser = userProvider.user?.copyWith(
      name: nameController.text,
      email: emailController.text,
      surname: surnameController.text,
      department: departmentController.text,
      grade: gradeController.text,
    );

    if (updatedUser != null) {
      userProvider.updateUser(updatedUser);

      // Veritabanında güncelleme işlemi
      final success = await userProvider.saveUserToDatabase(updatedUser);

      if (success) {
        // ScaffoldMessenger.of(context).showSnackBar(
        //   const SnackBar(content: Text('Bilgiler başarıyla güncellendi.')),
        // );
      } else {
        // ScaffoldMessenger.of(context).showSnackBar(
        //   const SnackBar(content: Text('Bilgiler güncellenirken hata oluştu.')),
        // );
      }
    }
  }

  File? _image;

  Future<void> _pickImage() async {
    final picker = ImagePicker();
    final pickedFile = await picker.pickImage(source: ImageSource.gallery);

    if (pickedFile != null) {
      setState(() {
        _image = File(pickedFile.path);
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    final user = Provider.of<UserProvider>(context).user;

    return Scaffold(
      appBar: AppBar(
        backgroundColor: Color(0xFFE9E9D9),
        elevation: 1,
        title: const Text(
          'Profili Düzenle',
          style: TextStyle(color: Colors.black),
        ),
        iconTheme: const IconThemeData(color: Colors.black),
        actions: [
          IconButton(
            onPressed: () {
              Navigator.push(
                context,
                MaterialPageRoute(builder: (context) => CalendarAA()),
              );
            },
            icon: Icon(Icons.calendar_month),
          ),
        ],
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: ListView(
          children: [
            Center(
              child: Stack(
                children: [
                  CircleAvatar(
                    radius: 50,
                    backgroundImage:
                        _image != null
                            ? FileImage(_image!) as ImageProvider
                            : const AssetImage('assets/images/a.png'),
                  ),
                  Positioned(
                    bottom: 0,
                    right: 0,
                    child: Container(
                      height: 30,
                      width: 30,
                      decoration: BoxDecoration(
                        shape: BoxShape.circle,
                        color: Colors.blue,
                      ),
                      child: IconButton(
                        icon: const Icon(Icons.edit),
                        color: Colors.white,
                        iconSize: 20,
                        onPressed: _pickImage,
                      ),
                    ),
                  ),
                ],
              ),
            ),
            Divider(),
            Row(
              children: [
                const Text(
                  'Email ',
                  style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
                ),
                const SizedBox(width: 20),
                Expanded(
                  child: buildTextField(user?.email ?? 'Email Adresiniz'),
                ),
              ],
            ),
            Divider(),
            Row(
              children: [
                const Text(
                  'Ad      ',
                  style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
                ),
                const SizedBox(width: 20),
                Expanded(child: buildTextField(user?.name ?? 'Adınız')),
              ],
            ),
            Divider(),
            Row(
              children: [
                const Text(
                  'Soyad',
                  style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
                ),
                const SizedBox(width: 20),
                Expanded(child: buildTextField(user?.surname ?? 'Soyadınız')),
              ],
            ),
            Divider(),
            Row(
              children: [
                const Text(
                  'Bölüm',
                  style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
                ),
                const SizedBox(width: 20),
                Expanded(
                  child: buildTextField(user?.department ?? 'Bölümünüz'),
                ),
              ],
            ),
            Divider(),
            Row(
              children: [
                const Text(
                  'Sınıf   ',
                  style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
                ),
                const SizedBox(width: 20),
                Expanded(child: buildTextField(user?.grade ?? 'Sınıfınız')),
              ],
            ),
            SizedBox(height: 20),
            ElevatedButton(
              style: ElevatedButton.styleFrom(
                backgroundColor: Colors.green,
                padding: const EdgeInsets.symmetric(vertical: 15),
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(10),
                ),
              ),
              onPressed: _updateUserInfo,
              child: const Text(
                'BİLGİLERİMİ GÜNCELLE',
                style: TextStyle(
                  fontSize: 16,
                  fontWeight: FontWeight.bold,
                  color: Colors.white,
                ),
              ),
            ),

            SizedBox(height: 10),
            ElevatedButton(
              style: ElevatedButton.styleFrom(
                backgroundColor: const Color.fromARGB(255, 226, 97, 87),
                padding: const EdgeInsets.symmetric(vertical: 15),
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(10),
                ),
              ),
              onPressed: () {
                Provider.of<UserProvider>(context, listen: false).clearUser();
                Navigator.pushAndRemoveUntil(
                  context,
                  MaterialPageRoute(builder: (context) => WelcomeScreen()),
                  (route) => false,
                );
              },
              child: const Text(
                'ÇIKIŞ YAP',
                style: TextStyle(
                  fontSize: 16,
                  fontWeight: FontWeight.bold,
                  color: Colors.white,
                ),
              ),
            ),
            SizedBox(height: 10),

            ElevatedButton(
              style: ElevatedButton.styleFrom(
                backgroundColor: Colors.red,
                padding: const EdgeInsets.symmetric(vertical: 15),
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(10),
                ),
              ),
              onPressed: () async {
                bool confirm = await showDialog(
                  context: context,
                  builder:
                      (context) => AlertDialog(
                        title: const Text('Hesabı Sil'),
                        content: const Text(
                          'Hesabınızı silmek istediğinizden emin misiniz?',
                        ),
                        actions: [
                          TextButton(
                            onPressed: () => Navigator.of(context).pop(false),
                            child: const Text('İptal'),
                          ),
                          ElevatedButton(
                            style: ElevatedButton.styleFrom(
                              backgroundColor: Colors.red,
                            ),
                            onPressed: () => Navigator.of(context).pop(true),
                            child: const Text('Sil'),
                          ),
                        ],
                      ),
                );

                if (confirm) {
                  final userProvider = Provider.of<UserProvider>(
                    context,
                    listen: false,
                  );
                  final email = userProvider.user?.email;

                  if (email != null) {
                    bool isDeleted = await db.deleteUser(email);

                    if (isDeleted) {
                      userProvider.clearUser();
                      Navigator.pushAndRemoveUntil(
                        context,
                        MaterialPageRoute(
                          builder: (context) => WelcomeScreen(),
                        ),
                        (route) => false,
                      );
                      ScaffoldMessenger.of(context).showSnackBar(
                        const SnackBar(
                          content: Text('Hesabınız başarıyla silindi.'),
                        ),
                      );
                    } else {
                      ScaffoldMessenger.of(context).showSnackBar(
                        const SnackBar(
                          content: Text('Hesap silinirken bir hata oluştu.'),
                        ),
                      );
                    }
                  }
                }
              },
              child: const Text(
                'HESABIMI SİL',
                style: TextStyle(
                  fontSize: 16,
                  fontWeight: FontWeight.bold,
                  color: Colors.white,
                ),
              ),
            ),
          ],
        ),
      ),
      floatingActionButtonLocation: FloatingActionButtonLocation.endDocked,
      floatingActionButton: SpeedDial(
        icon: Icons.share,
        overlayColor: Colors.black,
        backgroundColor: Colors.red,
        activeBackgroundColor: Colors.deepOrange,
        overlayOpacity: 0.4,
        spacing: 12,
        spaceBetweenChildren: 12,
        closeManually: true,
        onOpen: () => 'Paylaşma Seçenekleri',
        children: [
          SpeedDialChild(
            child: Icon(Icons.mail),
            //backgroundColor: Colors.blue,
            label: 'Mail',
            //labelBackgroundColor: Colors.yellow,
            onTap: () {},
          ),
          SpeedDialChild(
            child: Icon(Icons.copy),
            label: 'Bilgilerimi Kopyala',
            onTap: () {},
          ),
          SpeedDialChild(
            child: Icon(FontAwesomeIcons.facebook),
            label: 'Facebook',
            onTap: () {},
          ),
          SpeedDialChild(
            child: Icon(FontAwesomeIcons.instagram),
            label: 'Instagram',
            onTap: () {},
          ),
          SpeedDialChild(
            child: Icon(FontAwesomeIcons.twitter),
            label: 'X',
            onTap: () {},
          ),
          SpeedDialChild(
            child: Icon(FontAwesomeIcons.linkedin),
            label: 'LinkedIn',
            onTap: () {},
          ),
        ],
      ),
    );
  }

  Widget buildTextField(String placeholder) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        TextField(
          decoration: InputDecoration(
            contentPadding: const EdgeInsets.only(bottom: 8),
            hintText: placeholder,
            hintStyle: const TextStyle(
              color: Color.fromARGB(255, 46, 45, 45),
              fontSize: 14,
            ),
          ),
        ),
      ],
    );
  }

  @override
  void dispose() {
    db.connection.close();
    super.dispose();
  }
}
