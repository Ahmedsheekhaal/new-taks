import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get/state_manager.dart';
import 'package:sqflite/sqflite.dart';
import 'package:test/about.dart';
import 'package:test/auth/SingInPage.dart';
import 'package:test/contact.dart';
import 'package:test/settings.dart';

class HomePage extends StatefulWidget {
  const HomePage({Key? key}) : super(key: key);

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  TextEditingController myController = TextEditingController();

  RxList tasks = <Map>[].obs;

  late Database myDatabase;

  var person = {};
  Getuser() async {
    final db = FirebaseFirestore.instance;

    final userId = FirebaseAuth.instance.currentUser!.uid;
    final collection = await db.collection("Users").doc(userId).get();
    print("--------------" + collection.data()!['username']);
    person = {
      "Name": collection.data()!['username'],
      "Email": collection.data()!['email']
    };
    print(person);
  }

  void saveTask() async {
    tasks.add({'title': myController.text, 'completed': false});
    final insertQuery = 'insert into tasks values ("${myController.text}", 0)';
    print(insertQuery);
    await myDatabase.rawInsert(insertQuery);
    myController.clear();
    Get.back();
  }

  void setup() async {
    String databasesFolder = await getDatabasesPath();
    String myDatabaseFile = databasesFolder + '/kandb.db';
    myDatabase = await openDatabase(myDatabaseFile, version: 1,
        onCreate: (Database db, v) {
      const sql = 'Create Table tasks (title text, completed int)';
      db.execute(sql);
    });

    const query = 'Select * from tasks';
    List savedTasks = await myDatabase.rawQuery(query);

    tasks.value = savedTasks.map((oldElement) {
      return {
        'title': oldElement['title'],
        'completed': oldElement['completed'] == 0 ? false : true
      };
    }).toList();
  }

  @override
  void initState() {
    super.initState();
    setup();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      drawer: Drawer(
        child: ListView(
          padding: const EdgeInsets.all(0),
          children: [
            const DrawerHeader(
              decoration: BoxDecoration(
                color: Colors.black,
              ), //BoxDecoration
              child: UserAccountsDrawerHeader(
                decoration: BoxDecoration(color: Colors.black),
                accountName: Text(
                  "Daily Taks",
                  style: TextStyle(fontSize: 18),
                ),
                accountEmail: Text("Application for you to use."),
              ), //UserAccountDrawerHeader
            ), //DrawerHeader
            ListTile(
              leading: const Icon(Icons.person),
              title: const Text('About'),
              onTap: () {
                Get.to(aboutScreen());
              },
            ),

            ListTile(
              leading: const Icon(Icons.book),
              title: const Text('Contact'),
              onTap: () {
                Get.off(contactScreen());
              },
            ),
            ListTile(
              leading: const Icon(Icons.workspace_premium),
              title: const Text('Back to Home'),
              onTap: () {
                Get.back();
              },
            ),
            ListTile(
              leading: const Icon(Icons.logout),
              title: const Text('LogOut'),
              onTap: () {
                FirebaseAuth.instance.signOut();
                Get.to(SingInScreen());
              },
            ),
          ],
        ),
      ),
      appBar: AppBar(
        backgroundColor: Colors.black,
        title: const Text('Daily Tasks'),
        actions: [
          IconButton(
              onPressed: () {
                tasks.clear();
              },
              icon: const Icon(Icons.delete_forever))
        ],
      ),
      floatingActionButton: FloatingActionButton(
        backgroundColor: Colors.black,
        onPressed: () {
          showModalBottomSheet(
              context: context,
              builder: (ctx) {
                return Container(
                  padding: EdgeInsets.fromLTRB(
                      24, 24, 24, MediaQuery.of(context).viewInsets.bottom),
                  child: Column(
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      TextField(
                        controller: myController,
                        decoration:
                            const InputDecoration(hintText: 'Enter Title Task'),
                      ),
                      const SizedBox(height: 12),
                      MaterialButton(
                        color: Colors.black,
                        onPressed: saveTask,
                        child: const Text(
                          'Save',
                          style: TextStyle(color: Colors.white),
                        ),
                      )
                    ],
                  ),
                );
              });
        },
        child: const Icon(Icons.add),
      ),
      body: buildList(),
    );
  }

  Widget buildList() {
    return Obx(() {
      return ListView.separated(
        itemCount: tasks.length, // 2
        separatorBuilder: (ctx, index) {
          return Divider(
            thickness: 0,
          );
        },
        itemBuilder: (ctx, int index) {
          Map task = tasks[index];

          return ListTile(
            title: Text(
              task['title'],
              style: TextStyle(
                  color: task['completed'] ? Colors.grey : Colors.black,
                  decoration: task['completed']
                      ? TextDecoration.lineThrough
                      : TextDecoration.none),
            ),
            leading: Checkbox(
              value: task['completed'],
              onChanged: (bool? val) {
                task['completed'] = val;
                tasks[index] = task;
                tasks.refresh();
              },
            ),
            trailing: IconButton(
              icon: const Icon(Icons.delete),
              onPressed: () {
                tasks.remove(task);
              },
            ),
          );
        },
      );
    });
  }
}
