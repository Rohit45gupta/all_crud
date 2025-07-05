import 'dart:io';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'database_model.dart';
import 'db_helper.dart';

class UserFormScreen extends StatefulWidget {
  final DetailModel? user;

  const UserFormScreen({super.key, this.user});

  @override
  State<UserFormScreen> createState() => _UserFormScreenState();
}

class _UserFormScreenState extends State<UserFormScreen> {
  final _formKey = GlobalKey<FormState>();
  final nameCtrl = TextEditingController();
  final emailCtrl = TextEditingController();
  String imagePath = "";

  @override
  void initState() {
    super.initState();
    if (widget.user != null) {
      nameCtrl.text = widget.user!.name;
      emailCtrl.text = widget.user!.email;
      imagePath = widget.user!.image!;
    }
  }

  Future<void> _pickImage() async {
    final picked = await ImagePicker().pickImage(source: ImageSource.gallery);
    if (picked != null) setState(() => imagePath = picked.path);
  }

  void _saveData() async {
    if (_formKey.currentState!.validate()) {
      final user = DetailModel(
        id: widget.user?.id,
        name: nameCtrl.text,
        email: emailCtrl.text,
        image: imagePath,
      );
      if (widget.user == null) {
        await DBHelper.insertUser(user);
      } else {
        await DBHelper.updateUser(user);
      }
      Navigator.pop(context);
    }
  }

  @override
  void dispose() {
    nameCtrl.dispose();
    emailCtrl.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text(widget.user == null ? "Add User" : "Edit User")),
      body: Padding(
        padding: const EdgeInsets.all(16),
        child: Form(
          key: _formKey,
          child: SingleChildScrollView(
            child: Column(
              children: [
                GestureDetector(
                  onTap: _pickImage,
                  child: CircleAvatar(
                    radius: 50,
                    backgroundImage: imagePath.isNotEmpty ? FileImage(File(imagePath)) : null,
                    child: imagePath.isEmpty ? const Icon(Icons.camera_alt, size: 40) : null,
                  ),
                ),
                const SizedBox(height: 20),
                TextFormField(
                  controller: nameCtrl,
                  decoration: const InputDecoration(labelText: "Name"),
                  validator: (val) => val!.isEmpty ? "Enter name" : null,
                ),
                const SizedBox(height: 10),
                TextFormField(
                  controller: emailCtrl,
                  decoration: const InputDecoration(labelText: "Email"),
                  validator: (val) => val!.isEmpty ? "Enter email" : null,
                ),
                const SizedBox(height: 20),
                ElevatedButton(
                  onPressed: _saveData,
                  child: Text(widget.user == null ? "Save" : "Update"),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
