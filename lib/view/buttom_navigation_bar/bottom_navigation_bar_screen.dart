import 'package:firebase_crud_prac/view/buttom_navigation_bar/hive_screen.dart';
import 'package:firebase_crud_prac/view/buttom_navigation_bar/firebase_screen.dart';
import 'package:firebase_crud_prac/view/buttom_navigation_bar/realtime_screen.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../../controller/auth_provider.dart';
import '../../utils/ui_helper.dart';
import '../intro_screen/update_screen.dart';
import 'sqf_screen.dart';

class BottomNavigationBarScreen extends StatefulWidget {
  const BottomNavigationBarScreen({super.key});

  @override
  State<BottomNavigationBarScreen> createState() => _BottomNavigationBarScreenState();
}

class _BottomNavigationBarScreenState extends State<BottomNavigationBarScreen> {


  @override
  void initState() {
    super.initState();
    Provider.of<AuthProvider>(context, listen: false).fetchUserData(context);

  }

  int selectIndex = 0;
  var listPage = [
    HiveScreen(),
    SqfLiteScreen(),
    FirebaseScreen(),
    RealTimeScreen(),
  ];
  var listTitle = [
    "Hive DataBase",
    "SqfLite Database",
    "Firebase Storage",
    "RealTime Database"
  ];


  @override
  Widget build(BuildContext context) {
    final authProvider = Provider.of<AuthProvider>(context);

    return Scaffold(

      appBar: AppBar(
        title:  Text(listTitle[selectIndex]),
        centerTitle: true,
        actions: [
          PopupMenuButton(
            itemBuilder: (context) => [
              PopupMenuItem(
                child: ListTile(
                  leading: const Icon(Icons.hive_outlined),
                  title: const Text('Hive'),
                  onTap: () {
                    Navigator.pop(context);
                    UiHelper.showSnackBar(context, 'Hive Clicked ');
                    setState(() {
                      selectIndex = 0;
                    });
                  },
                ),
              ),
              PopupMenuItem(
                child: ListTile(
                  leading: const Icon(Icons.lightbulb_circle_outlined),
                  title: const Text('SqfLite'),
                  onTap: () {
                    Navigator.pop(context);
                    UiHelper.showSnackBar(context, 'SqfLite Clicked ');
                    setState(() {
                      selectIndex = 1;
                    });
                  },
                ),
              ),
              PopupMenuItem(
                child: ListTile(
                  leading: const Icon(Icons.factory),
                  title: const Text('Firebase'),
                  onTap: () {
                    Navigator.pop(context);
                    UiHelper.showSnackBar(context, 'Firebase Clicked ');

                    setState(() {
                      selectIndex = 2;
                    });
                  },
                ),
              ),
              PopupMenuItem(
                child: ListTile(
                  leading: const Icon(Icons.real_estate_agent),
                  title: const Text('Realtime'),
                  onTap: () {
                    Navigator.pop(context);
                    UiHelper.showSnackBar(context, 'Realtime Clicked ');

                    setState(() => selectIndex = 3);
                  },
                ),
              ),
              PopupMenuItem(
                child: ListTile(
                  leading: const Icon(Icons.logout_outlined),
                  title: const Text('Logout'),
                  onTap: () {
                    authProvider.signOut(context);
                  },
                ),
              ),
              PopupMenuItem(
                child: ListTile(
                  leading: const Icon(Icons.help_outline),
                  title: const Text('Help'),
                  onTap: () {
                    Navigator.pop(context);
                  },
                ),
              ),
            ],
          )
        ],
      ),
      drawer: Drawer(
        child: ListView(
          children: [
            Card(
              elevation: 7,
              child: Consumer<AuthProvider>(
                builder: (context, provider, child) {
                  return Container(
                    color: Colors.blueAccent,
                    padding: const EdgeInsets.all(16),
                    child: Row(
                      children: [
                        const CircleAvatar(
                          radius: 30,
                          backgroundColor: Colors.white,
                          child: Icon(Icons.person, color: Colors.blueAccent, size: 30),
                        ),
                        const SizedBox(width: 20),
                        Expanded(
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              Text(
                                provider.user['name'] ?? 'No Name',
                                style: const TextStyle(color: Colors.white, fontSize: 18),
                              ),
                              Row(
                                children: [
                                  Expanded(
                                    child: Text(
                                      provider.user['email'] ?? 'No Email',
                                      style: const TextStyle(color: Colors.white70, fontSize: 14),
                                      overflow: TextOverflow.ellipsis,
                                    ),
                                  ),
                                  IconButton(
                                    icon: const Icon(Icons.edit, color: Colors.white, size: 24),
                                    onPressed: () {
                                      Navigator.push(
                                        context,
                                        MaterialPageRoute(
                                          builder: (builder) => UpdateScreen(
                                            name: provider.user['name'] ?? '',
                                            email: provider.user['email'] ?? '',
                                          ),
                                        ),
                                      );
                                    },
                                  ),
                                ],
                              ),
                            ],
                          ),
                        ),
                      ],
                    ),
                  );
                },
              ),
            ),
            ListTile(
              leading: const Icon(Icons.home),
              title: const Text("Home"),
              onTap: () {
                UiHelper.showSnackBar(context, 'Home Clicked ');
              },
            ),

            ListTile(
              leading: const Icon(Icons.wallet),
              title: const Text("Wallet"),
                onTap: () => UiHelper.showSnackBar(context, 'Wallet Clicked ')
            ),
            ListTile(
              leading: const Icon(Icons.person),
              title: const Text("Profile"),
              onTap: () => UiHelper.showSnackBar(context, 'Profile Clicked '),
            ),
            ListTile(
              leading: const Icon(Icons.settings),
              title: const Text("Setting"),
                onTap: () => UiHelper.showSnackBar(context, 'Setting Clicked '),
            ),
          ],
        ),
      ),
      body: listPage[selectIndex],
      bottomNavigationBar: BottomNavigationBar(
        currentIndex: selectIndex,
        unselectedItemColor: Colors.grey,
        selectedItemColor: Colors.blueAccent,
        type: BottomNavigationBarType.fixed,
        iconSize: 25,
      onTap: (value){
        setState(() {

          selectIndex = value;
        });
      },
           items:[
            BottomNavigationBarItem(icon: Icon(Icons.hive_outlined),label: 'Hive'),
        BottomNavigationBarItem(icon: Icon(Icons.lightbulb_circle_outlined),label: 'SqfLite'),
        BottomNavigationBarItem(icon: Icon(Icons.factory),label: 'Firebase'),
        BottomNavigationBarItem(icon: Icon(Icons.real_estate_agent),label: 'RealTime'),
      ],
      ),
    );
  }
}
