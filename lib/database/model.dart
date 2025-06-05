class UserModel {
  //id tut
  final String name;
  final String surname;
  final String email;
  final String password;
  final String department;
  final String grade;
  // final String birthDate;

  UserModel({
    required this.name,
    required this.surname,
    required this.email,
    required this.password,
    required this.department,
    required this.grade,
    // required this.birthDate,
  });

  /// `copyWith` metodu, mevcut nesneyi kopyalayıp sadece belirtilen alanları değiştirir.
  UserModel copyWith({
    String? name,
    String? surname,
    String? email,
    String? password,
    String? department,
    String? grade,
    // String? birthDate,
  }) {
    return UserModel(
      name: name ?? this.name,
      surname: surname ?? this.surname,
      email: email ?? this.email,
      password: password ?? this.password,
      department: department ?? this.department,
      grade: grade ?? this.grade,
      // birthDate: birthDate ?? this.birthDate,
    );
  }

  /// Debug amaçlı modelin string formatında gösterimi
  @override
  String toString() {
    return 'UserModel(name: $name, surname: $surname, email: $email, password: $password, department: $department, grade: $grade)';
  }
}
