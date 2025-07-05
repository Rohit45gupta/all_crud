import 'package:firebase_crud_prac/utils/ui_helper.dart';
import 'package:firebase_crud_prac/view/intro_screen/signup_screen.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../../controller/auth_provider.dart';

class SignInScreen extends StatefulWidget {
  const SignInScreen({super.key});

  @override
  State<SignInScreen> createState() => _SignInScreenState();
}

class _SignInScreenState extends State<SignInScreen> {
  final _formKey = GlobalKey();
  bool isLoading = false;
  @override
  Widget build(BuildContext context) {
    var provider = Provider.of<AuthProvider>(context);
    return Scaffold(
        backgroundColor: Colors.white,
        body:Form(
            key: _formKey,
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Icon(Icons.person_pin,size: 100, color: Colors.blueAccent,),
                SizedBox(height: 10,),
                Padding(
                  padding: const EdgeInsets.all(10.0),
                ),
                SizedBox(height: 10,),
                Padding(
                  padding: const EdgeInsets.all(10.0),
                  child: TextField(
                      controller: provider.emailController,
                      keyboardType: TextInputType.emailAddress,
                      decoration: InputDecoration(
                          labelText: 'Enter Email',
                          prefixIcon: Icon(Icons.email_outlined,color: Colors.blueAccent,),fillColor: Colors.grey.shade500,
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
                      controller: provider.passwordController,
                      keyboardType: TextInputType.number,
                      decoration: InputDecoration(
                          labelText: 'Enter Password',
                          prefixIcon: Icon(Icons.lock,color: Colors.blueAccent,),fillColor: Colors.grey.shade500,
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

                // ElevatedButton(
                //   style: ElevatedButton.styleFrom(side: BorderSide(color: Colors.grey,width: 3,),
                //       foregroundColor: Colors.white,
                //       backgroundColor: Colors.blueAccent,
                //       padding: EdgeInsets.symmetric(
                //         horizontal: 35,
                //         vertical: 13,
                //       )),
                //
                //   onPressed: () {
                //     provider.signInWithEmail(context);
                //     provider.clearText();
                //
                //   },
                //
                //   child: Text('Sign In'),
                // ),
                UiHelper.buildButton(height: 45, width: 400, onPressed: (){
                  provider.signInWithEmail(context);
                  provider.clearText();
                }, text: 'SignIn', background: Colors.blueAccent),
                SizedBox(height: 10,),
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Text('Already have an account?',
                        style: TextStyle(color: Colors.black, fontSize: 15)),
                    TextButton(
                      onPressed: () {
                        Navigator.pushReplacement(
                            context,
                            MaterialPageRoute(
                                builder: (context) => SignUpScreen()));
                      },
                      child: Text(
                        'Please SignUp',
                        style: TextStyle(
                            color: Colors.blueAccent,
                            fontSize: 16,
                            fontWeight: FontWeight.bold),
                      ),
                    )],
                )

              ],
            ))

    );
  }
//
// void logIn() async {
//   final user = await auth.signInUserWithEmail(
//       emailController.text, passwordController.text);
//   if (user != null) {
//     Navigator.pushReplacement(
//         context, MaterialPageRoute(builder: (context) => HomeScreen()));
//     Fluttertoast.showToast(msg: 'LogIn SuccessFul');
//   }
//   log('LogIn failed');
// }
}


