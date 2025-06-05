import 'package:flutter/material.dart';
import 'model.dart';
import 'package:mysql1/mysql1.dart';

class UserProvider with ChangeNotifier {
  UserModel? _user;

  UserModel? get user => _user;

  void setUser(UserModel user) {
    _user = user;
    notifyListeners();
  }

  void clearUser() {
    _user = null;
    notifyListeners();
  }

  void updateUser(UserModel updatedUser) {
    _user = updatedUser;
    notifyListeners();
  }

  Future<bool> saveUserToDatabase(UserModel user) async {
    try {
     
     
      return true;
    } catch (e) {
      return false; 
    }
  }

  //kitap için 
  final List<Map<String, dynamic>> _recentBooks = [
    {
      'id': '1',
      'title': 'Not1',
      'description': 'Açıklama 1',
      'author': 'Yazar1',
      'isFav': false,
    },
    {
      'id': '2',
      'title': 'Not2',
      'description': 'Açıklama 2',
      'author': 'Yazar2',
      'isFav': false,
    },
    {
      'id': '3',
      'title': 'Not3',
      'description': 'Açıklama 3',
      'author': 'Yazar3',
      'isFav': false,
    },
  ];

  List<Map<String, dynamic>> _favoriteBooks = [];

  List<Map<String, dynamic>> get recentBooks => _recentBooks;

  List<Map<String, dynamic>> get favoriteBooks => _favoriteBooks;

  void toggleFavorite(Map<String, dynamic> book) {
    book['isFav'] = !book['isFav'];
    if (book['isFav']) {
      _favoriteBooks.add(book);
    } else {
      _favoriteBooks.remove(book);
    }
    notifyListeners();
  }
}// await Future.delayed(Duration(seconds: 1)); 

