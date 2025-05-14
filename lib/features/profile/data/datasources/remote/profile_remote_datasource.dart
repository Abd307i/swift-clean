import 'dart:io';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:testing_firebase/features/profile/data/models/profile_model.dart';
import 'package:testing_firebase/features/profile/domain/entities/profile_entity.dart';

class ProfileRemoteDataSources {
  final FirebaseFirestore _firestore;
  final FirebaseStorage _storage;

  ProfileRemoteDataSources(this._firestore, this._storage);

  Future<ProfileEntity> loadProfile(String userId) async{
    try{
      final doc =  await _firestore.collection('users').doc(userId).get();
      return ProfileModel.fromJson(doc.data()!);
    } catch(e){
      throw e.toString();
    }
  }

  Future<void> updateProfile(ProfileModel profile) async{
    try{
      await _firestore.collection('users').doc(profile.userId).update(profile.toJson());
    } catch(e){
      throw e.toString();
    }
  }

  Future<void> deleteImage(String imageUrl) async{
    try{
      await _storage.refFromURL(imageUrl).delete();
    } catch (e){
      throw e.toString();
    }
  }

  Future<String> uploadImage(String userId, File image)async{
    try{
      final ref = _storage.ref('profile_images/${userId}.jpg');
      await ref.putFile(image);
      final imageUrl =  await ref.getDownloadURL();
      await _firestore.collection('users').doc(userId).update({'imageUrl' : imageUrl});
      return imageUrl;
    } catch(e){
      throw e.toString();
    }
  }

}