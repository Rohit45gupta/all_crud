import 'package:firebase_crud_prac/view/sqflite_directory/database_model.dart';
import 'package:hive_flutter/adapters.dart';

part 'hive_model.g.dart';

@HiveType(typeId: 0)
class HiveModel extends HiveObject {
  @HiveField(0)
  String name;

  @HiveField(1)
  String email;

  HiveModel({required this.name, required this.email,});

}

