import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:autismcompanionsupport/services/cloud/cloud_storage_constants.dart';
import 'package:flutter/foundation.dart';

@immutable
class CloudProfile {
  final String documentId;
  final String ownerUserId;
  final String name;
  final String age;
  final String gender;
  final String height;
  final String weight;
  final String history;
  final String habits;
  final String profileAvatar;

  const CloudProfile({
    required this.documentId,
    required this.ownerUserId,
    required this.name,
    required this.age,
    required this.gender,
    required this.height,
    required this.weight,
    required this.history,
    required this.habits,
    required this.profileAvatar,
  });

  CloudProfile.fromSnapshot(QueryDocumentSnapshot<Map<String, dynamic>> snapshot)
      : documentId = snapshot.id,
        ownerUserId = snapshot.data()[ownerUserIdFieldName],
        name = snapshot.data()[nameFieldName] as String,
        age = snapshot.data()[ageFieldName] as String,
        gender = snapshot.data()[genderFieldName] as String,
        height = snapshot.data()[heightFieldName] as String,
        weight = snapshot.data()[weightFieldName] as String,
        history = snapshot.data()[historyFieldName] as String,
        habits = snapshot.data()[habitsFieldName] as String,
        profileAvatar = snapshot.data()[profileAvatarFieldName] as String;
}