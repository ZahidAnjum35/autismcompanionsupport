import 'package:autismcompanionsupport/services/cloud/cloud_profile.dart';
import 'package:autismcompanionsupport/services/cloud/cloud_storage_constants.dart';
import 'package:autismcompanionsupport/services/cloud/cloud_storage_exception.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

class FirebaseCloudStorage {
  final profile = FirebaseFirestore.instance.collection('Test_000');

  Future<void> deleteProfile({required String documentId}) async {
    try {
      await profile.doc(documentId).delete();
    } catch (e) {
      throw CouldNotDeleteProfileException();
    }
  }

  Future<void> updateProfile({
    required String documentId,
    required String name,
    required String age,
    required String gender,
    required String height,
    required String weight,
    required String history,
    required String habits,
    required String profileAvatar,
  }) async {
    try {
      await profile.doc(documentId).update({
        nameFieldName: name,
        ageFieldName: age,
        genderFieldName: gender,
        heightFieldName: height,
        weightFieldName: weight,
        historyFieldName: history,
        habitsFieldName:habits,
        profileAvatarFieldName: profileAvatar,
      });
    } catch (e) {
      throw CouldNotUpdateProfileException();
    }
  }

  Future<CloudProfile> createProfile({
    required String ownerUserId,
    required String name,
    required String age,
    required String gender,
    required String height,
    required String weight,
    required String history,
    required String habits,
    required String profileAvatar,
  }) async {
    final document = await profile.add({
      ownerUserIdFieldName: ownerUserId,
      nameFieldName: name,
      ageFieldName: age,
      genderFieldName: gender,
      heightFieldName: height,
      weightFieldName: weight,
      historyFieldName: history,
      habitsFieldName:habits,
      profileAvatarFieldName: profileAvatar,
    });
    final fetchedProfile = await document.get();
    return CloudProfile(
      documentId: fetchedProfile.id,
      ownerUserId: ownerUserId,
      name: name,
      age: age,
      gender: gender,
      height: height,
      weight: weight,
      history: history,
      habits: habits,
      profileAvatar: profileAvatar,
    );
  }

  static final FirebaseCloudStorage _shared =
      FirebaseCloudStorage._sharedInstance();
  FirebaseCloudStorage._sharedInstance();
  factory FirebaseCloudStorage() => _shared;
}