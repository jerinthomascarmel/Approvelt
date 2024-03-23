import 'dart:convert';

class RequestItemModel {
  final String id;
  final String uid;
  final String uidEmail;
  final String uidPhotoUrl;
  final String subject;
  final String description;
  final bool isApproved;
  final String approvedBy;
  final String startDate;
  final String endDate;
  final bool isDenied;
  final String deniedBy;
  final String nameSentBy;
  RequestItemModel({
    required this.id,
    required this.uid,
    required this.uidEmail,
    required this.uidPhotoUrl,
    required this.subject,
    required this.description,
    required this.isApproved,
    required this.approvedBy,
    required this.startDate,
    required this.endDate,
    required this.isDenied,
    required this.deniedBy,
    required this.nameSentBy,
  });

  RequestItemModel copyWith({
    String? id,
    String? uid,
    String? uidEmail,
    String? uidPhotoUrl,
    String? subject,
    String? description,
    bool? isApproved,
    String? approvedBy,
    String? startDate,
    String? endDate,
    bool? isDenied,
    String? deniedBy,
    String? nameSentBy,
  }) {
    return RequestItemModel(
      id: id ?? this.id,
      uid: uid ?? this.uid,
      uidEmail: uidEmail ?? this.uidEmail,
      uidPhotoUrl: uidPhotoUrl ?? this.uidPhotoUrl,
      subject: subject ?? this.subject,
      description: description ?? this.description,
      isApproved: isApproved ?? this.isApproved,
      approvedBy: approvedBy ?? this.approvedBy,
      startDate: startDate ?? this.startDate,
      endDate: endDate ?? this.endDate,
      isDenied: isDenied ?? this.isDenied,
      deniedBy: deniedBy ?? this.deniedBy,
      nameSentBy: nameSentBy ?? this.nameSentBy,
    );
  }

  Map<String, dynamic> toMap() {
    final result = <String, dynamic>{};

    result.addAll({'id': id});
    result.addAll({'uid': uid});
    result.addAll({'uidEmail': uidEmail});
    result.addAll({'uidPhotoUrl': uidPhotoUrl});
    result.addAll({'subject': subject});
    result.addAll({'description': description});
    result.addAll({'isApproved': isApproved});
    result.addAll({'approvedBy': approvedBy});
    result.addAll({'startDate': startDate});
    result.addAll({'endDate': endDate});
    result.addAll({'isDenied': isDenied});
    result.addAll({'deniedBy': deniedBy});
    result.addAll({'nameSentBy': nameSentBy});

    return result;
  }

  factory RequestItemModel.fromMap(Map<String, dynamic> map) {
    return RequestItemModel(
      id: map['id'] ?? '',
      uid: map['uid'] ?? '',
      uidEmail: map['uidEmail'] ?? '',
      uidPhotoUrl: map['uidPhotoUrl'] ?? '',
      subject: map['subject'] ?? '',
      description: map['description'] ?? '',
      isApproved: map['isApproved'] ?? false,
      approvedBy: map['approvedBy'] ?? '',
      startDate: map['startDate'] ?? '',
      endDate: map['endDate'] ?? '',
      isDenied: map['isDenied'] ?? false,
      deniedBy: map['deniedBy'] ?? '',
      nameSentBy: map['nameSentBy'] ?? '',
    );
  }

  String toJson() => json.encode(toMap());

  factory RequestItemModel.fromJson(String source) =>
      RequestItemModel.fromMap(json.decode(source));

  @override
  String toString() {
    return 'RequestItemModel(id: $id, uid: $uid, uidEmail: $uidEmail, uidPhotoUrl: $uidPhotoUrl, subject: $subject, description: $description, isApproved: $isApproved, approvedBy: $approvedBy, startDate: $startDate, endDate: $endDate, isDenied: $isDenied, deniedBy: $deniedBy, nameSentBy: $nameSentBy)';
  }

  @override
  bool operator ==(Object other) {
    if (identical(this, other)) return true;

    return other is RequestItemModel &&
        other.id == id &&
        other.uid == uid &&
        other.uidEmail == uidEmail &&
        other.uidPhotoUrl == uidPhotoUrl &&
        other.subject == subject &&
        other.description == description &&
        other.isApproved == isApproved &&
        other.approvedBy == approvedBy &&
        other.startDate == startDate &&
        other.endDate == endDate &&
        other.isDenied == isDenied &&
        other.deniedBy == deniedBy &&
        other.nameSentBy == nameSentBy;
  }

  @override
  int get hashCode {
    return id.hashCode ^
        uid.hashCode ^
        uidEmail.hashCode ^
        uidPhotoUrl.hashCode ^
        subject.hashCode ^
        description.hashCode ^
        isApproved.hashCode ^
        approvedBy.hashCode ^
        startDate.hashCode ^
        endDate.hashCode ^
        isDenied.hashCode ^
        deniedBy.hashCode ^
        nameSentBy.hashCode;
  }
}
