import 'package:firebase_core/firebase_core.dart';
import 'package:firebase_crud_prac/controller/auth_provider.dart';
import 'package:firebase_crud_prac/view/hive_add_update_page/hive_model.dart';
import 'package:firebase_crud_prac/view/intro_screen/splash_screen.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:path_provider/path_provider.dart' as path_provider;
import 'package:hive_flutter/hive_flutter.dart';

import 'firebase_options.dart';

void main() async{
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(
    options: DefaultFirebaseOptions.currentPlatform,
  );

  final appDocumentDir = await path_provider.getApplicationDocumentsDirectory();
  await Hive.initFlutter(appDocumentDir.path);
  Hive.registerAdapter(UserModelAdapter());
  await Hive.openBox<HiveModel>('users');

  runApp( MultiProvider(providers: [
    ChangeNotifierProvider(create: (context) => AuthProvider()),

  ],
  child: MyApp()));
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        colorScheme: ColorScheme.fromSeed(seedColor: Colors.deepPurple),
      ),
      home: const SplashScreen(),
    );
  }
}


