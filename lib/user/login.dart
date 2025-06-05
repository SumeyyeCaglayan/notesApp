import 'package:flutter/material.dart';
import 'package:notes/bottom/bottom_page.dart';
import 'package:provider/provider.dart';
import '../bottom/home.dart';
import '../database/db_helper.dart';
import '../database/model.dart';
import '../database/provider.dart';
import 'register.dart';

class LoginScreen extends StatefulWidget {
  const LoginScreen({super.key});

  @override
  State<LoginScreen> createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  final TextEditingController emailController = TextEditingController();
  final TextEditingController passwordController = TextEditingController();
  bool _isRememberMeChecked = false;
  bool _isPasswordVisible = false;
  final _formSignupKey = GlobalKey<FormState>();
  late String name;
  late String surname;
  late String email;
  late String password;
  late String department;
  String grade = '';
  DateTime? birthDate;
  late String profile;
  late DateTime registerionDate;
  bool agreePersonalData = true;

  final TextEditingController birthDateController = TextEditingController();
  final TextEditingController nameController = TextEditingController();
  final TextEditingController surnameController = TextEditingController();
  final TextEditingController departmentController = TextEditingController();
  final TextEditingController gradeController = TextEditingController();

  final DataBaseHelper db = DataBaseHelper();

  @override
  void initState() {
    super.initState();
    db.connectToDatabase();
  }

  Future<void> loginUser() async {
    String email = emailController.text.trim();
    String password = passwordController.text.trim();

    if (email.isEmpty || password.isEmpty) {
      print("Lütfen tüm alanları doldurun.");
      return;
    }

    // Kullanıcıyı doğrula ve bilgilerini al
    UserModel? user = await db.validateUser(email, password);

    if (user != null) {
      // Kullanıcı bilgilerini providera kaydet
      Provider.of<UserProvider>(context, listen: false).setUser(user);

      // Ana sayfaya yönlendir
      Navigator.pushReplacement(
        context,
        MaterialPageRoute(builder: (context) => const BottomPage()),
      );
    } else {
      print("Geçersiz email veya şifre.");
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.transparent,
        elevation: 0,
        leading: IconButton(
          icon: const Icon(Icons.arrow_back, color: Colors.black),
          onPressed: () {
            Navigator.pop(context);
          },
        ),
      ),
      body: Form(
        key: _formSignupKey,
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 30.0),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              TextField(
                controller: emailController,
                keyboardType: TextInputType.emailAddress,
                decoration: const InputDecoration(
                  labelText: 'Email',
                  prefixIcon: Icon(Icons.email_outlined),
                ),
              ),
              const SizedBox(height: 20),
              TextField(
                controller: passwordController,
                obscureText: !_isPasswordVisible,
                keyboardType: TextInputType.visiblePassword,
                decoration: InputDecoration(
                  labelText: 'Şifre',
                  prefixIcon: const Icon(Icons.lock_outline),
                  suffixIcon: IconButton(
                    icon: Icon(
                      _isPasswordVisible
                          ? Icons.visibility_off
                          : Icons.visibility,
                    ),
                    onPressed: () {
                      setState(() {
                        _isPasswordVisible = !_isPasswordVisible;
                      });
                    },
                  ),
                ),
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Row(
                    children: [
                      Checkbox(
                        value: _isRememberMeChecked,
                        onChanged: (value) {
                          setState(() {
                            _isRememberMeChecked = value!;
                          });
                        },
                      ),
                      const Text("Beni Hatırla"),
                    ],
                  ),
                  TextButton(
                    onPressed: () {
                      print("Şifremi Unuttum butonuna tıklandı.");
                    },
                    child: const Text(
                      "Şifremi Unuttum",
                      style: TextStyle(color: Colors.black54),
                    ),
                  ),
                ],
              ),
              const SizedBox(height: 20),
              ElevatedButton(
                onPressed: loginUser,
                style: ElevatedButton.styleFrom(
                  backgroundColor: const Color(0xFF87986A),
                  padding: const EdgeInsets.symmetric(
                    horizontal: 50,
                    vertical: 12,
                  ),
                ),
                child: const Text("Giriş"),
              ),
              const SizedBox(height: 20),
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  IconButton(
                    onPressed: () {
                      print("Facebook ile giriş yapılacak.");
                    },
                    icon: const Icon(Icons.facebook, color: Colors.blue),
                  ),
                  IconButton(
                    onPressed: () {
                      print("Google ile giriş yapılacak.");
                    },
                    icon: const Icon(Icons.g_mobiledata, color: Colors.red),
                  ),
                ],
              ),
              TextButton(
                onPressed: () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (context) => const RegisterScreen(),
                    ),
                  );
                },
                child: const Text("Yeni Hesap Oluştur"),
              ),
            ],
          ),
        ),
      ),
    );
  }

  @override
  void dispose() {
    db.connection.close();
    super.dispose();
  }
}
