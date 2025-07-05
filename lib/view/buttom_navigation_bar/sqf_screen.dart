import 'dart:io';
import 'package:flutter/material.dart';
import '../sqflite_directory/add_update_screen.dart';
import '../sqflite_directory/database_model.dart';
import '../sqflite_directory/db_helper.dart';


class SqfLiteScreen extends StatefulWidget {
  const SqfLiteScreen({super.key});

  @override
  State<SqfLiteScreen> createState() => _SqfLiteScreenState();
}

class _SqfLiteScreenState extends State<SqfLiteScreen> {
  List<DetailModel> userList = [];

  Future<void> fetchUsers() async {
    final data = await DBHelper.getUsers();
    setState(() {
      userList = data.cast<DetailModel>();
    });
  }

  @override
  void initState() {
    super.initState();
    fetchUsers();
  }

  void _deleteUser(int id) async {
    await DBHelper.deleteUser(id);
    fetchUsers();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: userList.isEmpty
          ? const Center(child: Text("No users found"))
          : ListView.builder(
        itemCount: userList.length,
        itemBuilder: (context, index) {
          final user = userList[index];
          return ListTile(
            leading: (user.image?.isNotEmpty ?? false)
                ? CircleAvatar(backgroundImage: FileImage(File(user.image!)))
                : const CircleAvatar(child: Icon(Icons.person)),
            title: Text(user.name),
            subtitle: Text(user.email),
            trailing: Row(
              mainAxisSize: MainAxisSize.min,
              children: [
                IconButton(
                  icon: const Icon(Icons.edit),
                  onPressed: () async {
                    await Navigator.push(
                      context,
                      MaterialPageRoute(builder: (_) => UserFormScreen(user: user)),
                    );
                    fetchUsers();
                  },
                ),
                IconButton(
                  icon: const Icon(Icons.delete),
                  onPressed: () => _deleteUser(user.id!),
                ),
              ],
            ),
          );
        },
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () async {
          await Navigator.push(
            context,
            MaterialPageRoute(builder: (context) => const UserFormScreen()),
          );
          fetchUsers();
        },
        foregroundColor: Colors.white,
        backgroundColor: Colors.blueAccent,
        child: const Icon(Icons.plus_one),
      ),
    );
  }
}
