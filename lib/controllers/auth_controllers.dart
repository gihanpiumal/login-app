import 'package:awesome_dialog/awesome_dialog.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:logger/logger.dart';

import '../models/objects.dart';
import '../utils/alert_helper.dart';

class AuthController {
  /// firebase auth instance
  final FirebaseAuth auth = FirebaseAuth.instance;

  /// create the user collection reference
  CollectionReference users = FirebaseFirestore.instance.collection('users');

  /// signup function
  Future<void> registerUser(
    BuildContext context,
    String email,
    String password,
    String name,
  ) async {
    try {
      /// send email password to the firebase and create a user
      await auth
          .createUserWithEmailAndPassword(
        email: email,
        password: password,
      )
          .then((value) async {
        /// check if the user credential object user not null
        if (value.user != null) {
          /// save other user data in cloude firestore
          await saveUserData(value.user!.uid, name, email);

          /// if user create successfully show alert
          AlertHelper.showAlert(context, DialogType.SUCCES, "SUCCESS",
              "User created successfully!");
        }
      });
    } on FirebaseAuthException catch (e) {
      /// show error dialog
      AlertHelper.showAlert(context, DialogType.ERROR, "ERROR", e.code);
    } catch (e) {
      /// show error dialog
      AlertHelper.showAlert(context, DialogType.ERROR, "ERROR", e.toString());
    }
  }

  /// save user data to firestore
  Future<void> saveUserData(String uid, String name, String email) async {
    return users
        .doc(uid)
        .set(
          {
            'uid': uid,
            'name': name,
            'email': email,
          },
          SetOptions(merge: true),
        )
        .then((value) => Logger().i("user data saved"))
        .catchError((error) => Logger().e("Failed to merge data: $error"));
  }

  /// signin function
  Future<void> signinUser(
    BuildContext context,
    String email,
    String password,
  ) async {
    try {
      /// send email password to the firebase and check is user is exsists or not
      await auth.signInWithEmailAndPassword(
        email: email,
        password: password,
      );

      // await fetchUserData(credential.user!.uid);
    } on FirebaseAuthException catch (e) {
      /// show error dialog
      AlertHelper.showAlert(context, DialogType.ERROR, "ERROR", e.code);
    } catch (e) {
      /// show error dialog
      AlertHelper.showAlert(context, DialogType.ERROR, "ERROR", e.toString());
    }
  }

  /// signout function
  Future<void> logout() async {
    await FirebaseAuth.instance.signOut();
  }

  /// fetch user data saved in cloud firestore
  Future<UserModel?> fetchUserData(String uid) async {
    try {
      /// firebase query that fetch user data
      // ignore: unused_local_variable
      DocumentSnapshot snapshot = await users.doc(uid).get();

      /// mapping fetched data to user model
      UserModel model =
          UserModel.fromJson(snapshot.data() as Map<String, dynamic>);

      return model;
    } catch (e) {
      Logger().e(e);
      return null;
    }
  }

  /// send password reset email
  Future<void> sendPasswordResetEmail(
      BuildContext context, String email) async {
    await FirebaseAuth.instance
        .sendPasswordResetEmail(email: email)
        .then((value) {
      /// show infor msg
      AlertHelper.showAlert(
          context, DialogType.INFO, "Email sent", "Please check your email!");
    });
  }
}
