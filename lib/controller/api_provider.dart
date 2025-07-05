// import 'dart:convert';
// import 'dart:developer';
// import 'package:firebase_crud_prac/model/user_model.dart';
// import 'package:flutter/cupertino.dart';
// import 'package:http/http.dart' as http;
//
// class ApiProvider with ChangeNotifier{
//
//   bool _isLoading = false;
//   List<UserModel> users = [];
//   String? _error;
//
//   List get getUser => users;
//   String? get error => _error;
//   bool get isLoading => _isLoading;
//
//
//   Future <void> fetchData() async{
//     _isLoading = true;
//     _error = null;
//     notifyListeners();
//
//     final url = Uri.parse('https://jsonplaceholder.typicode.com/posts');
//     try{
//       final response = await http.get(url);
//       if(response.statusCode == 200){
//         final List jsonData = jsonDecode(response.body);
//         users = jsonData.map((json) =>UserModel.fromJson(json)).toList();
//
//       }
//       else{
//         _error = " Server ${response.statusCode}";
//       }
//     }catch(e){
//       log('Something went wrong : $e');
//     }
//     _isLoading = false;
//     notifyListeners();
//
//   }
// }