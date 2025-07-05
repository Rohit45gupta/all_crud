import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:hive_flutter/hive_flutter.dart';

import '../../utils/ui_helper.dart';
import 'hive_model.dart';

class HiveUpdateData extends StatefulWidget {
  final int index;
  final HiveModel user;

  const HiveUpdateData({super.key, required this.index, required this.user});

  @override
  State<HiveUpdateData> createState() => _HiveUpdateDataState();
}

class _HiveUpdateDataState extends State<HiveUpdateData> {
  late TextEditingController nameController;
  late TextEditingController emailController;

  @override
  void initState() {
    super.initState();
    nameController = TextEditingController(text: widget.user.name);
    emailController = TextEditingController(text: widget.user.email);
  }

  @override
  void dispose() {
    nameController.dispose();
    emailController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: Padding(
          padding: const EdgeInsets.symmetric(vertical: 15, horizontal: 25),
          child: SizedBox(
            height: 300,
            child: Card(
              elevation: 5,
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Text('Update Item',style: TextStyle(fontSize: 20),),
                  SizedBox(height: 15,),
                  UiHelper.buildTextField(
                    controller: nameController,
                    label: "Enter Name",
                    icon: CupertinoIcons.person,
                  ),
                  const SizedBox(height: 15),
                  UiHelper.buildTextField(
                    controller: emailController,
                    label: "Enter Email",
                    icon: CupertinoIcons.mail,
                  ),
                  const SizedBox(height: 15),
                  UiHelper.buildButton(
                    height: 45,
                    width: 400,
                    onPressed: () async {
                      final name = nameController.text.trim();
                      final email = emailController.text.trim();

                      if (name.isEmpty || email.isEmpty) {
                        UiHelper.showSnackBar(context, 'Name & Email required');
                        return;
                      }

                      final box = Hive.box<HiveModel>('users');
                      await box.putAt(widget.index, HiveModel(name: name, email: email));

                      UiHelper.showSnackBar(context, 'Data updated!');
                      Navigator.pop(context);
                    },
                    text: 'Save',
                    background: Colors.blueAccent,
                  ),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}
