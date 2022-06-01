class User {
  late final String id;
  late final String? username;
  late final double? sum;

  User({required this.id, required this.username, this.sum});

  factory User.fromJson(Map<String, dynamic> json) {
    return User(id: json['id'], username: json['name'], sum: json['sum']);
  }
}
