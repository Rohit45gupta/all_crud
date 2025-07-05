import 'package:firebase_crud_prac/utils/ui_helper.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:hive_flutter/adapters.dart';

import 'hive_model.dart';

class HiveAddData extends StatefulWidget {
  const HiveAddData({super.key});

  @override
  State<HiveAddData> createState() => _HiveAddDataState();
}

class _HiveAddDataState extends State<HiveAddData> {
  @override
  Widget build(BuildContext context) {
    var nameController = TextEditingController();
    var emailController  = TextEditingController();

    return Scaffold(
      body: Center(
        child: Padding(
          padding: const EdgeInsets.symmetric(vertical: 15,horizontal: 25),
          child: SizedBox(
            height: 300,
            child: Card(
              elevation: 5,
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Text('Add Item',style: TextStyle(fontSize: 20),),
                  SizedBox(height: 15,),
                  UiHelper.buildTextField(controller: nameController, label: "Enter Name", icon: CupertinoIcons.person),
                  SizedBox(height: 15,),
                  UiHelper.buildTextField(controller: emailController, label: "Enter Email", icon: CupertinoIcons.mail),
                  SizedBox(height: 15,),
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
                      await box.add(HiveModel(name: name, email: email));
                      UiHelper.showSnackBar(context, 'Data added!');

                      Navigator.pop(context); // wapas HiveScreen pe jao
                    },
                    text: 'Add',
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
