import 'dart:convert';

class RequestItemModel {
  final String id;
  final String uid;
  final String subject;
  final String description;
  final bool isApproved;
  final String approvedBy;
  final String startDate;
  final String endDate;
  final bool isDenied;
  final String deniedBy;
  RequestItemModel({
    required this.id,
    required this.uid,
    required this.subject,
    required this.description,
    required this.isApproved,
    required this.approvedBy,
    required this.startDate,
    required this.endDate,
    required this.isDenied,
    required this.deniedBy,
  });

  RequestItemModel copyWith({
    String? id,
    String? uid,
    String? subject,
    String? description,
    bool? isApproved,
    String? approvedBy,
    String? startDate,
    String? endDate,
    bool? isDenied,
    String? deniedBy,
  }) {
    return RequestItemModel(
      id: id ?? this.id,
      uid: uid ?? this.uid,
      subject: subject ?? this.subject,
      description: description ?? this.description,
      isApproved: isApproved ?? this.isApproved,
      approvedBy: approvedBy ?? this.approvedBy,
      startDate: startDate ?? this.startDate,
      endDate: endDate ?? this.endDate,
      isDenied: isDenied ?? this.isDenied,
      deniedBy: deniedBy ?? this.deniedBy,
    );
  }

  Map<String, dynamic> toMap() {
    final result = <String, dynamic>{};
  
    result.addAll({'id': id});
    result.addAll({'uid': uid});
    result.addAll({'subject': subject});
    result.addAll({'description': description});
    result.addAll({'isApproved': isApproved});
    result.addAll({'approvedBy': approvedBy});
    result.addAll({'startDate': startDate});
    result.addAll({'endDate': endDate});
    result.addAll({'isDenied': isDenied});
    result.addAll({'deniedBy': deniedBy});
  
    return result;
  }

  factory RequestItemModel.fromMap(Map<String, dynamic> map) {
    return RequestItemModel(
      id: map['id'] ?? '',
      uid: map['uid'] ?? '',
      subject: map['subject'] ?? '',
      description: map['description'] ?? '',
      isApproved: map['isApproved'] ?? false,
      approvedBy: map['approvedBy'] ?? '',
      startDate: map['startDate'] ?? '',
      endDate: map['endDate'] ?? '',
      isDenied: map['isDenied'] ?? false,
      deniedBy: map['deniedBy'] ?? '',
    );
  }

  String toJson() => json.encode(toMap());

  factory RequestItemModel.fromJson(String source) =>
      RequestItemModel.fromMap(json.decode(source));

  @override
  String toString() {
    return 'RequestItemModel(id: $id, uid: $uid, subject: $subject, description: $description, isApproved: $isApproved, approvedBy: $approvedBy, startDate: $startDate, endDate: $endDate, isDenied: $isDenied, deniedBy: $deniedBy)';
  }

  @override
  bool operator ==(Object other) {
    if (identical(this, other)) return true;
  
    return other is RequestItemModel &&
      other.id == id &&
      other.uid == uid &&
      other.subject == subject &&
      other.description == description &&
      other.isApproved == isApproved &&
      other.approvedBy == approvedBy &&
      other.startDate == startDate &&
      other.endDate == endDate &&
      other.isDenied == isDenied &&
      other.deniedBy == deniedBy;
  }

  @override
  int get hashCode {
    return id.hashCode ^
      uid.hashCode ^
      subject.hashCode ^
      description.hashCode ^
      isApproved.hashCode ^
      approvedBy.hashCode ^
      startDate.hashCode ^
      endDate.hashCode ^
      isDenied.hashCode ^
      deniedBy.hashCode;
  }
}
