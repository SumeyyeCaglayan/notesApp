import 'package:flutter/material.dart';
import 'package:mysql1/mysql1.dart';

import 'model.dart';

class DataBaseHelper {
  late MySqlConnection connection;

  Future<void> connectToDatabase() async {
    try {
      connection = await MySqlConnection.connect(
        ConnectionSettings(
          host: '10.0.2.2', // 127.0.0.1 or localhost or 10.0.2.2.
          port: 3306,
          user: 'root',
          password: '100473',
          db: 'notesapp',
        ),
      );
      print("Veritabanına başarıyla bağlanıldı.");
    } catch (e) {
      print("Bağlantı hatası: $e");
    }
  }

  Future<UserModel?> validateUser(String email, String password) async {
    try {
      final results = await connection.query(
        'SELECT * FROM users WHERE email = ? AND password = ?',
        [email, password],
      );

      if (results.isNotEmpty) {
        var row = results.first;
        return UserModel(
          name: row['name'],
          surname: row['surname'],
          email: row['email'],
          password: row['password'],
          department: row['department'],
          grade: row['grade'],
          //birthDate: row['birth_date'],
        );
      } else {
        return null;
      }
    } catch (e) {
      print("Kullanıcı doğrulanırken hata: $e");
      return null;
    }
  }

  // Kullanıcı Ekleme
  Future<int> insertUser(Map<String, dynamic> user) async {
    try {
      final result = await connection.query(
        'INSERT INTO users (name, surname, email, password, department, grade, birth_date, registration_date) VALUES (?, ?, ?, ?, ?, ?, ?, ?)',
        [
          user['name'],
          user['surname'],
          user['email'],
          user['password'],
          user['department'],
          user['grade'],
          user['birth_date'],
          user['registration_date'],
        ],
      );
      print("Kullanıcı başarıyla eklendi. ID: ${result.insertId}");
      return result.insertId ?? 0;
    } catch (e) {
      print("Kullanıcı eklenirken hata: $e");
      return -1;
    }
  }

  // Kullanıcı Bilgilerini Güncelleme
  Future<bool> updateUser(Map<String, dynamic> user) async {
    try {
      final result = await connection.query(
        '''
      UPDATE users 
      SET name = ?, surname = ?, email = ?, password = ?, department = ?, grade = ?, birth_date = ?
      WHERE id = ?
      ''',
        [
          user['name'],
          user['surname'],
          user['email'],
          user['password'],
          user['department'],
          user['grade'],
          user['birth_date'],
          user['id'],
        ],
      );

      if (result.affectedRows! > 0) {
        print("Kullanıcı bilgileri başarıyla güncellendi.");
        return true;
      } else {
        print("Güncelleme işlemi başarısız.");
        return false;
      }
    } catch (e) {
      print("Kullanıcı güncellenirken hata: $e");
      return false;
    }
  }

    // Kullanıcı Silme
  Future<bool> deleteUser(String email) async {
    try {
      final result = await connection.query(
        'DELETE FROM users WHERE email = ?',
        [email],
      );

      if (result.affectedRows! > 0) {
        print("Kullanıcı başarıyla silindi.");
        return true;
      } else {
        print("Kullanıcı silme işlemi başarısız.");
        return false;
      }
    } catch (e) {
      print("Kullanıcı silinirken hata: $e");
      return false;
    }
  }


  


  // // Kullanıcı bilgilerini email ile getir
  // Future<Map<String, dynamic>> getUserByEmail(String userId) async {
  //   try {
  //     final results = await connection.query(
  //       'SELECT * FROM users WHERE user_id = ?',
  //       [userId],
  //     );
  //     // final results = await connection.query(
  //     //   'SELECT * FROM users WHERE email = ? AND name = ? AND surname = ?',
  //     //   [email, name, surname],
  //     // );

  //     if (results.isNotEmpty) {
  //       final row = results.first;
  //       return {
  //         'user_id': row['user_id'],
  //         'email': row['email'],
  //         'name': row['name'],
  //         'surname': row['surname'],
  //       };
  //     } else {
  //       throw Exception("Kullanıcı bulunamadı");
  //     }
  //   } catch (e) {
  //     print("Hata: $e");
  //     rethrow;
  //   }
  // }

  //   // Kullanıcının çıkış yapmasını sağla
  //   Future<void> logoutUser(String email) async {
  //     try {
  //       await connection.query(
  //         'UPDATE users SET is_logged_in = 0 WHERE email = ?',
  //         [email],
  //       );
  //       print("Kullanıcı çıkış yaptı.");
  //     } catch (e) {
  //       print("Çıkış işlemi sırasında hata: $e");
  //     }
  //   }
}
