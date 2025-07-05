
import 'package:firebase_crud_prac/model/student_model.dart';
import 'package:firebase_crud_prac/view/intro_screen/signin_screen.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import '../services/auth_service.dart';
import '../view/buttom_navigation_bar/bottom_navigation_bar_screen.dart';

class AuthProvider with ChangeNotifier {
  final nameController = TextEditingController();
  final emailController = TextEditingController();
  final passwordController = TextEditingController();

  final AuthService _authService = AuthService();
  Map<String, dynamic> user = {};
  bool isLoading = false;


  Future<void> signUpWithEmail(BuildContext context) async {
    final name = nameController.text.trim();
    final email = emailController.text.trim();
    final password = passwordController.text.trim();

    if (name.isEmpty || email.isEmpty || password.isEmpty) {
      Fluttertoast.showToast(msg: 'All fields are required');
      return;
    }

    isLoading = true;
    notifyListeners();

    final userModel = StudentModel(name: name, email: email, password: password);
    final result = await _authService.signUpUser(userModel,context);

    isLoading = false;
    notifyListeners();

    if (result != null) {
      clearText();
      Navigator.pushReplacement(context, MaterialPageRoute(builder: (_) => const BottomNavigationBarScreen()));
    }
  }

  Future<void> signInWithEmail(BuildContext context) async {
    final email = emailController.text.trim();
    final password = passwordController.text.trim();

    if (email.isEmpty || password.isEmpty) {
      Fluttertoast.showToast(msg: 'Email & Password are required');
      return;
    }

    isLoading = true;
    notifyListeners();

    final result = await _authService.signInUser(email, password,context);

    isLoading = false;
    notifyListeners();

    if (result != null) {
      clearText();
      Navigator.pushReplacement(context, MaterialPageRoute(builder: (_) => const BottomNavigationBarScreen()));
    }
  }

  Future<void> signOut(BuildContext context) async {
    await _authService.signOutUser(context);
    Navigator.pushReplacement(context, MaterialPageRoute(builder: (_) => const SignInScreen()));
  }

  Future<void> fetchUserData(BuildContext context) async {
    final data = await _authService.fetchUserProfile(context);
    if (data != null) {
      user = data;
      notifyListeners();
    }
  }

  Future<void> updateUserData(BuildContext context) async {
    final updatedName = nameController.text.trim();
    final updatedEmail = emailController.text.trim();

    if (updatedName.isEmpty || updatedEmail.isEmpty) {
      Fluttertoast.showToast(msg: 'Fields cannot be empty');
      return;
    }

    await _authService.updateUserProfile(updatedName, updatedEmail,context);
    user['name'] = updatedName;
    user['email'] = updatedEmail;
    notifyListeners();
    Navigator.pop(context);
    Fluttertoast.showToast(msg: 'Profile updated');
  }

  void clearText() {
    nameController.clear();
    emailController.clear();
    passwordController.clear();
  }
}
