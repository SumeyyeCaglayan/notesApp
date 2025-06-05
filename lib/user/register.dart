import 'dart:convert';
import 'package:custom_scaffold/custom_scaffold.dart';
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:intl/intl.dart';
import 'package:notes/bottom/home.dart';
import 'package:provider/provider.dart';
import '../bottom/bottom_page.dart';
import '../database/db_helper.dart';
import '../database/model.dart';
import '../database/provider.dart';
import 'login.dart';
import 'package:intl/intl.dart';
import 'package:http/http.dart' as http;

class RegisterScreen extends StatefulWidget {
  const RegisterScreen({super.key});

  @override
  State<RegisterScreen> createState() => _RegisterScreenState();
}

class _RegisterScreenState extends State<RegisterScreen> {
  final _formSignupKey = GlobalKey<FormState>();
  late String name;
  late String surname;
  late String email;
  late String password;
  late String department;
  late String grade;
  DateTime? birthDate;
  late String profile;
  late DateTime registerionDate;
  bool agreePersonalData = true;

  final TextEditingController birthDateController = TextEditingController();
  final TextEditingController emailController = TextEditingController();
  final TextEditingController passwordController = TextEditingController();
  final TextEditingController nameController = TextEditingController();
  final TextEditingController surnameController = TextEditingController();
  final TextEditingController departmentController = TextEditingController();
  final TextEditingController gradeController = TextEditingController();

  DataBaseHelper db = DataBaseHelper();

  @override
  void initState() {
    super.initState();
    db.connectToDatabase();
  }

  // Tarih seçici
  Future<void> _selectDate(BuildContext context) async {
    final DateTime? picked = await showDatePicker(
      context: context,
      initialDate: DateTime.now(),
      firstDate: DateTime(1900),
      lastDate: DateTime(2100),
      helpText: 'Doğum Gününüzü Seçin',
    );
    if (picked != null && picked != birthDate) {
      setState(() {
        birthDate = picked;
        birthDateController.text = DateFormat('dd/MM/yyyy').format(birthDate!);
      });
    }
  }

  String formatDate(String date) {
    DateTime parsedDate = DateFormat('dd/MM/yyyy').parse(date);
    return DateFormat('yyyy-MM-dd').format(parsedDate);
  }

  Future<void> insertUser() async {
    // Verileri al
    String currentDate = DateTime.now().toIso8601String();
    String name = nameController.text.trim();
    String surname = surnameController.text.trim();
    String email = emailController.text.trim();
    String password = passwordController.text.trim();
    String department = departmentController.text.trim();
    String gradeValue = grade;
    String birthDateValue = formatDate(birthDateController.text.trim());

    if (name.isEmpty ||
        surname.isEmpty ||
        email.isEmpty ||
        password.isEmpty ||
        department.isEmpty ||
        gradeValue.isEmpty ||
        birthDateValue.isEmpty) {
      print("Lütfen tüm alanları doldurun.");
      return;
    }

    Map<String, dynamic> newUser = {
      'name': name,
      'surname': surname,
      'email': email,
      'password': password,
      'department': department,
      'grade': gradeValue,
      'birth_date': birthDateValue,
      'registration_date': currentDate,
    };

    // Kullanıcıyı veritabanına ekle
    int userId = await db.insertUser(newUser);

    if (userId > 0 && _formSignupKey.currentState!.validate()) {
      // Kullanıcı Verilerini Al
      String name = nameController.text.trim();
      String surname = surnameController.text.trim();
      String email = emailController.text.trim();
      String department = departmentController.text.trim();
      String gradeValue = grade;
      String birthDateValue = birthDateController.text.trim();

      UserModel newUser = UserModel(
        name: name,
        surname: surname,
        email: email,
        department: department,
        grade: gradeValue,
        //birthDate: birthDateValue, 
        password: password,
      );

      // Kullanıcıyı Provider ile Kaydet
      Provider.of<UserProvider>(context, listen: false).setUser(newUser);
      print("Kullanıcı başarıyla eklendi. ID: $userId");
      Navigator.push(
        context,
        MaterialPageRoute(builder: (context) => const BottomPage()),
      );
    } else {
      print("Kullanıcı eklenirken bir hata oluştu.");
    }
  }

  @override
  Widget build(BuildContext context) {
    return CustomScaffold(
      child: Column(
        children: [
          const Expanded(flex: 1, child: SizedBox(height: 10)),
          Expanded(
            flex: 7,
            child: Container(
              padding: const EdgeInsets.fromLTRB(25.0, 50.0, 25.0, 20.0),
              decoration: const BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.only(
                  topLeft: Radius.circular(40.0),
                  topRight: Radius.circular(40.0),
                ),
              ),
              child: SingleChildScrollView(
                child: Form(
                  key: _formSignupKey,
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: [
                      Text(
                        'Haydi Başlayalım',
                        style: TextStyle(
                          fontSize: 30.0,
                          fontWeight: FontWeight.w900,
                        ),
                      ),
                      const SizedBox(height: 40.0),
                      TextFormField(
                        controller: nameController,
                        keyboardType: TextInputType.name,
                        validator:
                            (value) =>
                                value == null || value.isEmpty
                                    ? 'Adınızı giriniz'
                                    : null,
                        onChanged: (value) {
                          setState(() {
                            name = value;
                          });
                        },
                        decoration: InputDecoration(
                          label: const Text('Adınız'),
                          hintText: 'Adınız',
                          hintStyle: const TextStyle(color: Colors.black26),
                          border: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(10),
                          ),
                        ),
                      ),
                      const SizedBox(height: 25.0),
                      TextFormField(
                        controller: surnameController,
                        keyboardType: TextInputType.name,
                        validator: (value) {
                          if (value == null || value.isEmpty) {
                            return 'Soyadınızı giriniz';
                          }
                          return null;
                        },
                        onChanged: (value) {
                          setState(() {
                            surname = value;
                          });
                        },
                        decoration: InputDecoration(
                          label: const Text('Soyadınız'),
                          hintText: 'Soyadınız',
                          hintStyle: const TextStyle(color: Colors.black26),
                          border: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(10),
                          ),
                        ),
                      ),
                      const SizedBox(height: 25.0),
                      TextFormField(
                        controller: departmentController,
                        keyboardType: TextInputType.name,
                        validator: (value) {
                          if (value == null || value.isEmpty) {
                            return 'Okuduğunuz Bölümü Giriniz';
                          }
                          return null;
                        },
                        onChanged: (value) {
                          setState(() {
                            department = value;
                          });
                        },
                        decoration: InputDecoration(
                          label: const Text('Okuduğunuz Bölüm'),
                          hintText: 'Okuduğunuz Bölüm',
                          hintStyle: const TextStyle(color: Colors.black26),
                          border: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(10),
                          ),
                        ),
                      ),
                      const SizedBox(height: 25.0),
                      DropdownButtonFormField<String>(
                        validator: (value) {
                          if (value == null || value.isEmpty) {
                            return 'Kaçıncı Sınıfta Olduğunuzu Giriniz';
                          }
                          return null;
                        },
                        onChanged: (value) {
                          setState(() {
                            grade = value!;
                          });
                        },
                        decoration: InputDecoration(
                          labelText: 'Sınıf Seçin',
                          hintText: 'Kaçıncı sınıfta olduğunuzu seçin',
                          hintStyle: const TextStyle(color: Colors.black26),
                          border: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(10),
                          ),
                        ),
                        items: [
                          DropdownMenuItem(value: '1', child: Text('1. Sınıf')),
                          DropdownMenuItem(value: '2', child: Text('2. Sınıf')),
                          DropdownMenuItem(value: '3', child: Text('3. Sınıf')),
                          DropdownMenuItem(value: '4', child: Text('4. Sınıf')),
                          DropdownMenuItem(value: '5', child: Text('5. Sınıf')),
                          DropdownMenuItem(value: '6', child: Text('6. Sınıf')),
                          DropdownMenuItem(
                            value: 'Mezun',
                            child: Text('Mezun'),
                          ),
                        ],
                      ),

                      const SizedBox(height: 25.0),
                      TextFormField(
                        controller: birthDateController,
                        readOnly: true,
                        decoration: InputDecoration(
                          labelText: 'Doğum Tarihi',
                          hintText: 'GG/AA/YYYY',
                          hintStyle: TextStyle(color: Colors.black26),
                          border: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(10),
                          ),
                          suffixIcon: GestureDetector(
                            child: Icon(Icons.calendar_today),
                            onTap: () {
                              _selectDate(context);
                            },
                          ),
                        ),
                        validator: (value) {
                          if (value == null || value.isEmpty) {
                            return 'Lütfen doğum tarihinizi seçiniz';
                          }
                          return null;
                        },
                      ),
                      const SizedBox(height: 25.0),
                      TextFormField(
                        controller: emailController,
                        keyboardType: TextInputType.emailAddress,
                        validator: (value) {
                          if (value == null || value.isEmpty) {
                            return 'E-posta adresinizi giriniz';
                          }
                          final emailRegExp = RegExp(
                            r'^[a-zA-Z0-9._%+-]+@[a-zA-Z0-9.-]+\.[a-zA-Z]{2,4}$',
                          );
                          if (!emailRegExp.hasMatch(value)) {
                            return 'Geçerli bir e-posta adresi giriniz';
                          }
                          return null;
                        },
                        onChanged: (value) {
                          setState(() {
                            email = value;
                          });
                        },
                        decoration: InputDecoration(
                          label: const Text('E-posta'),
                          hintText: 'E-posta',
                          hintStyle: const TextStyle(color: Colors.black26),
                          border: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(10),
                          ),
                        ),
                      ),
                      const SizedBox(height: 25.0),
                      TextFormField(
                        controller: passwordController,
                        keyboardType: TextInputType.visiblePassword,
                        validator: (value) {
                          if (value == null || value.isEmpty) {
                            return 'Şifrenizi giriniz';
                          }
                          return null;
                        },
                        onChanged: (value) {
                          setState(() {
                            password = value;
                          });
                        },
                        obscureText: true,
                        decoration: InputDecoration(
                          label: const Text('Şifre'),
                          hintText: 'Şifre',
                          hintStyle: const TextStyle(color: Colors.black26),
                          border: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(10),
                          ),
                        ),
                      ),
                      const SizedBox(height: 30.0),
                      Row(
                        children: [
                          Checkbox(
                            value: agreePersonalData,
                            onChanged: (value) {
                              setState(() {
                                agreePersonalData = value!;
                              });
                            },
                          ),
                          const Text(
                            'Kişisel verilerimin işlenmesine onay veriyorum.',
                            style: TextStyle(fontSize: 12.0),
                          ),
                        ],
                      ),
                      const SizedBox(height: 50.0),
                      GestureDetector(
                        onTap: () {
                          insertUser();
                        },
                        child: Container(
                          padding: const EdgeInsets.symmetric(vertical: 18.0),
                          alignment: Alignment.center,
                          decoration: BoxDecoration(
                            color: const Color.fromARGB(255, 161, 159, 155),
                            borderRadius: BorderRadius.circular(10.0),
                          ),
                          child: const Text(
                            'Kayıt Ol',
                            style: TextStyle(
                              fontSize: 20.0,
                              fontWeight: FontWeight.bold,
                              color: Colors.white,
                            ),
                          ),
                        ),
                      ),
                      const SizedBox(height: 15.0),
                    ],
                  ),
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }

  @override
  void dispose() {
    birthDateController.dispose();
    db.connection.close();
    super.dispose();
  }
}
