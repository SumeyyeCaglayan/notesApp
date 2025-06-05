import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:mysql_client/mysql_client.dart';
import 'package:notes/database/provider.dart';
import 'package:provider/provider.dart';
import 'bottom/home.dart';
import 'database/db_helper.dart';
import 'welcome/welcome_screen.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:mysql_manager/src/mysql_manager.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  DataBaseHelper dbHelper = DataBaseHelper();
  await dbHelper.connectToDatabase();
  runApp(
    MultiProvider(
      providers: [
        ChangeNotifierProvider(create: (context) => UserProvider()),
      ],
      child: MyApp(),
    ),
  );
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      theme: ThemeData(scaffoldBackgroundColor: const Color(0xFFE9E9D9)),
      home: const WelcomeScreen(),
    );
  }
}

//mysql -u root -p -h 127.0.0.1 -P 3306 veri tabanına bağlan