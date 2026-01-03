import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:tasky/feature/auth/data/model/user_dto.dart';
import 'package:tasky/core/network/result_firbase.dart';

  class FBFSAuthUser {
    CollectionReference<UserDto> get _getcollection {
    return FirebaseFirestore.instance
        .collection(UserDto.collection)
        .withConverter(
            fromFirestore: (sanp, _) => UserDto.fromJson(sanp.data()!),
            toFirestore: (usermodel, _) => usermodel.toJson());
  }

   Future<void> addUser(UserDto user) async {
    try {
      await _getcollection.doc(user.id).set(user);
    } catch (e) {
      throw "Error from add user";
    }
  }

   Future<ResultFB> registerUser(UserDto user) async {
    try {
      final crediantal = await FirebaseAuth.instance
          .createUserWithEmailAndPassword(
              email: user.email ?? "", password: user.password ?? "");
      user.id = crediantal.user?.uid;
      await _getcollection.doc(user.id).set(user);
      return SucessFB(data: user);
    } catch (e) {
      return ErrorFB(e.toString());
    }
  }

  Future<ResultFB<UserDto>> loginuser(UserDto user) async {
    try {
      final userCredential = await FirebaseAuth.instance
          .signInWithEmailAndPassword(email: user.email??"",password: user.password??"");
      user.id = userCredential.user?.uid;
      await _getcollection.doc(user.id).set(user);
      return SucessFB(data: user);
    } catch (e) {
      return ErrorFB(e.toString());
    }
  }
}

FBFSAuthUser injectAuthFB() => FBFSAuthUser();