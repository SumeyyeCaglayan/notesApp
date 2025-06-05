import 'package:flutter/material.dart';

class WelcomePage extends StatelessWidget {
  final String title;
  final VoidCallback onPressedCreate;
  final VoidCallback onPressedLogin;

  const WelcomePage({
    super.key,
    required this.title,
    required this.onPressedCreate,
    required this.onPressedLogin,
  });

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Stack(
        children: [
          Positioned(
            child: Transform.scale(
              scale: 1.35, // Resmin boyutunu büyütmek için
              child: Transform.translate(
                offset: Offset(0.0, -MediaQuery.of(context).size.width / 1.5), // Resmi yukarıya kaydırma
                child: Container(
                  height: MediaQuery.of(context).size.height,
                  width: MediaQuery.of(context).size.width,
                  decoration: BoxDecoration(
                    image: DecorationImage(
                      image: AssetImage('assets/images/a.png'), 
                      fit: BoxFit.cover, 
                    ),
                    borderRadius: BorderRadius.circular(
                        MediaQuery.of(context).size.width / 1.5), 
                  ),
                ),
              ),
            ),
          ),
          Padding(
            padding: EdgeInsets.only(bottom: 150), 
            child: Column(
              mainAxisAlignment: MainAxisAlignment.end, 
              children: [
                Center(
                  child: Text(
                    title, 
                    style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold),
                    textAlign: TextAlign.center,
                  ),
                ),
                SizedBox(height: 30),
                ElevatedButton(
                  onPressed: onPressedCreate,
                  style: ElevatedButton.styleFrom(
                    backgroundColor: Color(0xFF87986A), 
                    padding: EdgeInsets.symmetric(horizontal: 50, vertical: 12), 
                  ),
                  child: Text("Yeni Hesap Oluştur"), 
                ),
                SizedBox(height: 10),
                TextButton(
                  onPressed: onPressedLogin, 
                  child: Text("Giriş", style: TextStyle(color: Colors.black)), 
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}