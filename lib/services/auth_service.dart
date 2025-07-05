
  import 'dart:developer';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_crud_prac/utils/ui_helper.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:fluttertoast/fluttertoast.dart';

import '../model/student_model.dart';

  class AuthService {
    final FirebaseAuth _auth = FirebaseAuth.instance;
    final FirebaseFirestore firestore = FirebaseFirestore.instance;


    Future<UserCredential?> signUpUser(StudentModel data, BuildContext context) async {
      try {
        final cred = await _auth.createUserWithEmailAndPassword(
          email: data.email!,
          password: data.password!,
        );
        data.id = cred.user!.uid;
        await firestore.collection('students').doc(data.id).set(data.toJson());
        UiHelper.showSnackBar(context, 'SignUp Success');
        Fluttertoast.showToast(msg: 'SignUp Success');
        return cred;
      } catch (e) {
        log('SignUp error: $e');
        UiHelper.showSnackBar(context, 'SignUp failed');
        return null;
      }
    }

    Future<UserCredential?> signInUser(String email, String password,BuildContext context) async {
      try {
        final cred = await _auth.signInWithEmailAndPassword(
          email: email,
          password: password,
        );
        UiHelper.showSnackBar(context, 'SignIn Success');
        Fluttertoast.showToast(msg: 'SignIn Success');
        return cred;
      } catch (e) {
        log('SignIn error: $e');
        UiHelper.showSnackBar(context, 'SignIn failed');
        return null;
      }
    }

    Future<void> signOutUser(BuildContext context) async {
      try {
        await _auth.signOut();
        UiHelper.showSnackBar(context, 'SignOut Success');
        Fluttertoast.showToast(msg: 'SignOut Success');
      } catch (e) {
        log('SignOut error: $e');
        UiHelper.showSnackBar(context, 'SignOut failed');
      }
    }

    Future<Map<String, dynamic>?> fetchUserProfile(BuildContext context) async {
      final uid = _auth.currentUser?.uid;
      if (uid == null) return null;
      try {
        final doc = await firestore.collection('students').doc(uid).get();
        if (doc.exists) {
          return doc.data();
        }
      } catch (e) {
        UiHelper.showSnackBar(context, 'Fetch failed :$e');
      }
      return null;
    }

    Future<void> updateUserProfile(String name, String email,BuildContext context) async {
      final uid = _auth.currentUser?.uid;
      if (uid == null) return;

      try {
        await firestore.collection('students').doc(uid).update({
          'name': name,
          'email': email,
        });

        await _auth.currentUser?.updateEmail(email);
      } catch (e) {
        log('Update user error: $e');
        UiHelper.showSnackBar(context, 'Update failed');
      }
    }
  }