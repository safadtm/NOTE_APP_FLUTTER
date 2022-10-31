import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:note_app_sample/custom/todo_card.dart';
import 'package:note_app_sample/services/auth_service.dart';
import 'package:note_app_sample/view/add_todo.dart';

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  AuthClass authClass = AuthClass();

  final Stream<QuerySnapshot?> _strem =
      FirebaseFirestore.instance.collection("ToDo").snapshots();

  @override
  Widget build(BuildContext context) {
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
        bottom: const PreferredSize(
          child: Align(
            alignment: Alignment.centerLeft,
            child: Padding(
              padding: EdgeInsets.only(left: 22),
              child: Text(
                "Monday 21",
                style: TextStyle(
                  fontSize: 33,
                  fontWeight: FontWeight.w600,
                  color: Colors.white,
                ),
              ),
            ),
          ),
          preferredSize: Size.fromHeight(35),
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

              switch (document["Category"]) {
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
                  icon = Icons.local_grocery_store;
                  iconColor = Colors.blue;
                  break;

                default:
                  icon = Icons.run_circle_outlined;
                  iconColor = Colors.red;
              }
              return ToDoCard(
                title: document['title'] ?? "Hey there",
                check: true,
                iconBgColor: Colors.white,
                iconColor: iconColor,
                iconData: icon,
                time: DateTime.now().hour.toString(),
              );
            },
          );
        },
      ),
    );
  }
}

///////////for future use 
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
