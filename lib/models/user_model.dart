import 'dart:convert';

class UserModel {
  final String uid;
  final String email;
  final String password;
  final String name;
  final String type;

  UserModel({
    required this.uid,
    required this.email,
    required this.password,
    required this.name,
    required this.type,
  });
  

  UserModel copyWith({
    String? uid,
    String? email,
    String? password,
    String? name,
    String? type,
  }) {
    return UserModel(
      uid: uid ?? this.uid,
      email: email ?? this.email,
      password: password ?? this.password,
      name: name ?? this.name,
      type: type ?? this.type,
    );
  }

  Map<String, dynamic> toMap() {
    final result = <String, dynamic>{};
  
    result.addAll({'uid': uid});
    result.addAll({'email': email});
    result.addAll({'password': password});
    result.addAll({'name': name});
    result.addAll({'type': type});
  
    return result;
  }

  factory UserModel.fromMap(Map<String, dynamic> map) {
    return UserModel(
      uid: map['uid'] ?? '',
      email: map['email'] ?? '',
      password: map['password'] ?? '',
      name: map['name'] ?? '',
      type: map['type'] ?? '',
    );
  }

  String toJson() => json.encode(toMap());

  factory UserModel.fromJson(String source) => UserModel.fromMap(json.decode(source));

  @override
  String toString() {
    return 'UserModel(uid: $uid, email: $email, password: $password, name: $name, type: $type)';
  }

  @override
  bool operator ==(Object other) {
    if (identical(this, other)) return true;
  
    return other is UserModel &&
      other.uid == uid &&
      other.email == email &&
      other.password == password &&
      other.name == name &&
      other.type == type;
  }

  @override
  int get hashCode {
    return uid.hashCode ^
      email.hashCode ^
      password.hashCode ^
      name.hashCode ^
      type.hashCode;
  }
}
