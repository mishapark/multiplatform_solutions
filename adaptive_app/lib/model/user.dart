class User {
  final int id;
  final String firstname;
  final String lastname;
  final String email;
  final String pic;

  const User({
    required this.id,
    required this.firstname,
    required this.lastname,
    required this.email,
    required this.pic,
  });

  factory User.fromJson(Map<String, dynamic> json) {
    return User(
      id: json['id'] as int,
      firstname: json['firstName'] as String,
      lastname: json['lastName'] as String,
      email: json['email'] as String,
      pic: json['pic'] as String,
    );
  }
}
