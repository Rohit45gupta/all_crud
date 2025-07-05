import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../../controller/auth_provider.dart';

class UpdateScreen extends StatefulWidget {

  final String name;
   final String email;

  const UpdateScreen({super.key, required this.name, required this.email});

  @override
  State<UpdateScreen> createState() => _UpdateScreenState();
}

class _UpdateScreenState extends State<UpdateScreen> {
  @override
  void initState(){
    super.initState();
   final provider = Provider.of<AuthProvider>(context, listen: false);
   provider.nameController.text = widget.name;
   provider.emailController.text = widget.email;

  }

  @override
  Widget build(BuildContext context) {

    var provider = Provider.of<AuthProvider>(context);
    return Scaffold(
    backgroundColor: Colors.grey.shade500,
      body: Center(
        child: Padding(
          padding: const EdgeInsets.all(8.0),
          child: Container(
            height: 300,
            color: Colors.white,
           child: Column(
             mainAxisAlignment: MainAxisAlignment.start,
             children: [
               Text('Update Screen',style: TextStyle(fontSize: 35,fontWeight: FontWeight.bold,color: Colors.black),),
               SizedBox(height: 15,),
               Padding(
                 padding: const EdgeInsets.all(10.0),
                 child: TextField(
                     controller: provider.nameController,
                     keyboardType: TextInputType.text,
                     decoration: InputDecoration(
                         labelText: 'Enter Name',
                         prefixIcon: Icon(Icons.person_2_outlined,color: Colors.blueAccent,),fillColor: Colors.grey.shade500,
                         focusedBorder: OutlineInputBorder(
                             borderSide: BorderSide(color: Colors.blueAccent,width: 3),
                             borderRadius: BorderRadius.circular(15)
                         ),
                         enabledBorder: OutlineInputBorder(
                             borderSide: BorderSide(color: Colors.grey,width: 3),
                             borderRadius: BorderRadius.circular(15)

                         )
                     )

                 ),
               ),
               SizedBox(height: 10,),
               Padding(
                 padding: const EdgeInsets.all(10.0),
                 child: TextField(
                     controller: provider.emailController,
                     keyboardType: TextInputType.text,
                     decoration: InputDecoration(
                         labelText: 'Enter Email',
                         prefixIcon: Icon(Icons.person_2_outlined,color: Colors.blueAccent,),fillColor: Colors.grey.shade500,
                         focusedBorder: OutlineInputBorder(
                             borderSide: BorderSide(color: Colors.blueAccent,width: 3),
                             borderRadius: BorderRadius.circular(15)
                         ),
                         enabledBorder: OutlineInputBorder(
                             borderSide: BorderSide(color: Colors.grey,width: 3),
                             borderRadius: BorderRadius.circular(15)

                         )
                     )

                 ),
               ),
               SizedBox(height: 10,),
               Padding(
                 padding: const EdgeInsets.all(8.0),
                 child: ElevatedButton(
                   style: ElevatedButton.styleFrom(side: BorderSide(color: Colors.grey,width: 3,),
                       foregroundColor: Colors.white,
                       backgroundColor: Colors.blueAccent,
                       padding: EdgeInsets.symmetric(
                         horizontal: 35,
                         vertical: 13,
                       )),

                   onPressed: () {
                       provider.updateUserData(context);

                   },

                   child: Text('Update'),
                 ),
               ),

             ],
           ),
          ),
        ),
      ),
    );
  }
}
