import 'dart:convert';

class UserModel {
  final String uid;
  final String email;
  final String password;
  final String name;
  final String type;
  final String uidPhotoUrl;

  UserModel({
    required this.uid,
    required this.email,
    required this.password,
    required this.name,
    required this.type,
    required this.uidPhotoUrl,
  });

  UserModel copyWith({
    String? uid,
    String? email,
    String? password,
    String? name,
    String? type,
    String? uidPhotoUrl,
  }) {
    return UserModel(
      uid: uid ?? this.uid,
      email: email ?? this.email,
      password: password ?? this.password,
      name: name ?? this.name,
      type: type ?? this.type,
      uidPhotoUrl: uidPhotoUrl ?? this.uidPhotoUrl,
    );
  }

  Map<String, dynamic> toMap() {
    final result = <String, dynamic>{};
  
    result.addAll({'uid': uid});
    result.addAll({'email': email});
    result.addAll({'password': password});
    result.addAll({'name': name});
    result.addAll({'type': type});
    result.addAll({'uidPhotoUrl': uidPhotoUrl});
  
    return result;
  }

  factory UserModel.fromMap(Map<String, dynamic> map) {
    return UserModel(
      uid: map['uid'] ?? '',
      email: map['email'] ?? '',
      password: map['password'] ?? '',
      name: map['name'] ?? '',
      type: map['type'] ?? '',
      uidPhotoUrl: map['uidPhotoUrl'] ?? '',
    );
  }

  String toJson() => json.encode(toMap());

  factory UserModel.fromJson(String source) =>
      UserModel.fromMap(json.decode(source));

  @override
  String toString() {
    return 'UserModel(uid: $uid, email: $email, password: $password, name: $name, type: $type, uidPhotoUrl: $uidPhotoUrl)';
  }

  @override
  bool operator ==(Object other) {
    if (identical(this, other)) return true;
  
    return other is UserModel &&
      other.uid == uid &&
      other.email == email &&
      other.password == password &&
      other.name == name &&
      other.type == type &&
      other.uidPhotoUrl == uidPhotoUrl;
  }

  @override
  int get hashCode {
    return uid.hashCode ^
      email.hashCode ^
      password.hashCode ^
      name.hashCode ^
      type.hashCode ^
      uidPhotoUrl.hashCode;
  }
}
