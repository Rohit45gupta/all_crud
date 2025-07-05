import 'package:firebase_crud_prac/view/hive_add_update_page/hive_add_data.dart';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:hive_flutter/adapters.dart';
import '../hive_add_update_page/hive_model.dart';
import '../hive_add_update_page/hive_update_data.dart';

class HiveScreen extends StatefulWidget {
  const HiveScreen({super.key});

  @override
  State<HiveScreen> createState() => _HiveScreenState();
}

class _HiveScreenState extends State<HiveScreen> {
  @override
  Widget build(BuildContext context) {
    final Box<HiveModel> userBox = Hive.box<HiveModel>('users');

    return Scaffold(
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          Navigator.push(context, MaterialPageRoute(builder: (context) => HiveAddData()),
          );
        },
        foregroundColor: Colors.white,
        backgroundColor: Colors.blueAccent,
        child: Icon(Icons.plus_one),
      ),
      body: ValueListenableBuilder(
        valueListenable: userBox.listenable(),
        builder: (context, Box<HiveModel> box, _) {
          if (box.isEmpty) {
            return const Center(child: Text('No data added yet.'));
          }
          return ListView.builder(
            itemCount: box.length,
            itemBuilder: (context, index) {
              final user = box.getAt(index);
              return Card(
                elevation: 5,
                margin: const EdgeInsets.all(8),
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.only(topLeft: Radius.circular(15), topRight: Radius.circular(25)),
                ),
                color: Colors.blueAccent,
                shadowColor: Colors.black,
                child: ListTile(
                  leading: CircleAvatar(backgroundColor: Colors.white,maxRadius: 40,
                    child: Icon(Icons.person),),
                  title: Text(user?.name ?? '',style: TextStyle(color: Colors.white,fontSize: 20),),
                  subtitle: Text(user?.email ?? '',style: TextStyle(color: Colors.white,fontSize: 16),),
                  
                  trailing: PopupMenuButton(
                    color: Colors.white,
                    icon: Icon(Icons.more_vert,color: Colors.white,),
                    itemBuilder: (context) {
                      return [
                        PopupMenuItem(
                          child: ListTile(
                            leading: Icon(Icons.edit,color: Colors.blueAccent),
                            title: Text('Edit'),
                            onTap: () {
                              Navigator.pop(context);
                              Navigator.push(
                                context,
                                MaterialPageRoute(
                                  builder: (context) => HiveUpdateData(index: index, user: user!),

                                ),
                              );
                            },
                          ),
                        ),

                        PopupMenuItem(
                          child: ListTile(
                            leading: Icon(Icons.delete,color: Colors.red,),
                            title: Text('Delete'),
                            onTap: () {
                              Navigator.pop(context);
                              showDialog(
                                context: context,
                                builder: (context) {
                                  return AlertDialog(
                                    title: Text('Are you sure?'),
                                    content: Text(
                                      'Do you want to delete this item?',
                                    ),
                                    actions: [
                                      TextButton(
                                        onPressed: () {
                                          Navigator.pop(
                                            context,
                                          ); // close the dialog
                                        },
                                        child: Text('No'),
                                      ),
                                      TextButton(
                                        onPressed: () {
                                          box.deleteAt(
                                            index,
                                          ); // delete from Hive or wherever box refers to
                                          Navigator.pop(
                                            context,
                                          ); // close the dialog
                                          Fluttertoast.showToast(
                                            msg: 'Deleted',
                                          );
                                        },
                                        child: Text('Yes'),
                                      ),
                                    ],
                                  );
                                },
                              );
                            },
                          ),
                        ),
                      ];
                    },
                  ),
                ),
              );
            },
          );
        },
      ),
    );
  }
}
