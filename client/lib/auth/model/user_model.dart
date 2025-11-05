class UserModel {
  final String token;
  final String name;
  final String email;
  final String id;

  const UserModel({
    required this.token,
    required this.name,
    required this.email,
    required this.id,
  });

  /// 🧱 Create a copy with some fields changed
  UserModel copyWith({
    String? token,
    String? name,
    String? email,
    String? id,
  }) {
    return UserModel(
      token: token ?? this.token,
      name: name ?? this.name,
      email: email ?? this.email,
      id: id ?? this.id,
    );
  }

  /// 🗃️ Convert object to Map
  Map<String, dynamic> toMap() {
    return {
      'token': token,
      'name': name,
      'email': email,
      'id': id,
    };
  }

  /// 🏗️ Create object from Map
  factory UserModel.fromMap(Map<String, dynamic> map) {
    return UserModel(
      token: map['token'] ?? '', // JWT may be provided directly
      name: map['name'] ?? '',
      email: map['email'] ?? '',
      id: map['id'] ?? '',
    );
  }

  /// 📤 Convert object to JSON String
  String toJson() => toMap().toString();

  /// 📥 Create object from JSON (server response)
  ///
  /// Supports cases like:
  /// {
  ///   "token": "jwt_token_here",
  ///   "user": { "name": "John", "email": "john@mail.com", "id": "123" }
  /// }
  factory UserModel.fromJson(Map<String, dynamic> json) {
    // Check if the server wraps user details in "user"
    final userData = json['user'] ?? json;
    return UserModel(
      token: json['token'] ?? userData['token'] ?? '',
      name: userData['name'] ?? '',
      email: userData['email'] ?? '',
      id: userData['id'] ?? '',
    );
  }

  /// 🧠 Equality override
  @override
  bool operator ==(Object other) {
    if (identical(this, other)) return true;
    return other is UserModel &&
        other.token == token &&
        other.name == name &&
        other.email == email &&
        other.id == id;
  }

  /// 🧮 Hashcode override
  @override
  int get hashCode =>
      token.hashCode ^ name.hashCode ^ email.hashCode ^ id.hashCode;

  /// 📝 Readable debug string
  @override
  String toString() =>
      'UserModel(name: $name, email: $email, id: $id, token: $token)';
}
