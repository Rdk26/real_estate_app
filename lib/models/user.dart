class User {
  final String? id;
  final String name;
  final String lastname;
  final String email;
  final String password;

  const User(
      {this.id,
      required this.name,
      required this.lastname,
      required this.email,
      required this.password});

  Map<String, dynamic> toJson() {
    return {
      'Name': name,
      'Lastname': lastname,
      'Email': email,
      'Password': password
    };
  }
}
