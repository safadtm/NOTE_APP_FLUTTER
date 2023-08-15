// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

import 'package:note_app_sample/custom/todo_card.dart';
import 'package:note_app_sample/services/auth_service.dart';
import 'package:note_app_sample/view/add_todo.dart';
import 'package:note_app_sample/view/view_data.dart';

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  AuthClass authClass = AuthClass();

  final Stream<QuerySnapshot?> _strem =
      FirebaseFirestore.instance.collection("ToDo").snapshots();

  List<Select> selected = [];

  @override
  Widget build(BuildContext context) {
    final now = DateTime.now();
    final formattedDate = DateFormat('EEEE d').format(now);
    final formattedTime = DateFormat('hh:mm').format(now);

    return Scaffold(
      backgroundColor: Colors.black87,
      appBar: AppBar(
        backgroundColor: Colors.black87,
        title: const Text(
          "Today's Schedule",
          style: TextStyle(
            fontSize: 34,
            fontWeight: FontWeight.bold,
            color: Colors.white,
          ),
        ),
        actions: const [
          CircleAvatar(
            backgroundColor: Colors.white,
          ),
          SizedBox(width: 25),
        ],
        bottom: PreferredSize(
          child: Align(
            alignment: Alignment.centerLeft,
            child: Padding(
              padding: const EdgeInsets.only(left: 22),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                   Text(
                   formattedDate,
                    style: const TextStyle(
                      fontSize: 33,
                      fontWeight: FontWeight.w600,
                      color: Color(0xff8a32f1),
                    ),
                  ),
                  IconButton(
                    onPressed: () {
                      var instance =
                          FirebaseFirestore.instance.collection("ToDo");

                      for (int i = 0; i < selected.length; i++) {
                        // instance.doc().collection('ToDo');
                        instance.doc().delete();
                      }
                    },
                    icon: const Icon(
                      Icons.delete,
                      color: Colors.red,
                      size: 28,
                    ),
                  ),
                ],
              ),
            ),
          ),
          preferredSize: const Size.fromHeight(35),
        ),
      ),
      bottomNavigationBar: BottomNavigationBar(
        backgroundColor: Colors.black87,
        items: [
          const BottomNavigationBarItem(
            label: '',
            icon: Icon(
              Icons.home,
              size: 32,
              color: Colors.white,
            ),
          ),
          BottomNavigationBarItem(
            label: '',
            icon: InkWell(
              onTap: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(builder: (builder) => const AddTodoPage()),
                );
              },
              child: Container(
                height: 52,
                width: 52,
                decoration: const BoxDecoration(
                  shape: BoxShape.circle,
                  gradient: LinearGradient(
                    colors: [
                      Colors.indigoAccent,
                      Colors.purple,
                    ],
                  ),
                ),
                child: const Icon(
                  Icons.add,
                  size: 32,
                  color: Colors.white,
                ),
              ),
            ),
          ),
          const BottomNavigationBarItem(
            label: '',
            icon: Icon(
              Icons.settings,
              size: 32,
              color: Colors.white,
            ),
          ),
        ],
      ),
      body: StreamBuilder(
        stream: _strem,
        builder: (context, snapshot) {
          if (!snapshot.hasData) {
            return const Center(child: CircularProgressIndicator());
          }
          return ListView.builder(
            itemCount: snapshot.data!.docs.length,
            itemBuilder: (context, index) {
              IconData icon;
              Color iconColor;

              Map<String, dynamic> document =
                  snapshot.data!.docs[index].data() as Map<String, dynamic>;

              switch (document["category"].toString()) {
                case "Food":
                  icon = Icons.local_grocery_store;
                  iconColor = Colors.blue;
                  break;
                case "WorkOut":
                  icon = Icons.alarm;
                  iconColor = Colors.teal;
                  break;
                case "Work":
                  icon = Icons.run_circle_outlined;
                  iconColor = Colors.red;
                  break;
                case "Design":
                  icon = Icons.design_services;
                  iconColor = Colors.green;
                  break;
                case "Run":
                  icon = Icons.work;
                  iconColor = Colors.blue;
                  break;

                default:
                  icon = Icons.run_circle_outlined;
                  iconColor = Colors.red;
              }

              selected.add(
                Select(
                  id: snapshot.data!.docs[index].id,
                  checkValue: false,
                ),
              );

              return InkWell(
                onTap: () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (builder) => ViewTodo(
                        document: document,
                        id: snapshot.data!.docs[index].id,
                      ),
                    ),
                  );
                },
                child: ToDoCard(
                  title: document['title'] ?? "Hey there",
                  check: selected[index].checkValue,
                  iconBgColor: Colors.white,
                  iconColor: iconColor,
                  iconData: icon,
                  time: formattedTime,
                  index: index,
                  onChange: onChange,
                ),
              );
            },
          );
        },
      ),
    );
  }

  void onChange(int index) {
    setState(() {
      selected[index].checkValue = !selected[index].checkValue;
    });
  }
}

class Select {
  String id;
  bool checkValue = false;
  Select({
    required this.id,
    required this.checkValue,
  });
}
//////////for future use 
/// IconButton(
///            icon: const Icon(Icons.logout),
///            onPressed: () async {
///              await authClass.logout(context: context);
///              Navigator.pushAndRemoveUntil(
///                  context,
///                  MaterialPageRoute(
///                    builder: (context) => const MyApp(),
///                  ),
///                  (route) => false);
///            },
///          ),
///
