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
      body: SingleChildScrollView(
        child: Container(
          height: MediaQuery.of(context).size.height,
          width: MediaQuery.of(context).size.width,
          padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 20),
          child: Column(
            children: const [
              ToDoCard(
                title: "Wake up Bro",
                check: true,
                iconBgColor: Colors.white,
                iconColor: Colors.red,
                iconData: Icons.alarm,
                time: "10 AM",
              ),
              SizedBox(height: 10),
              ToDoCard(
                title: "Wake up Bro!",
                check: true,
                iconBgColor: Colors.white,
                iconColor: Colors.blueAccent,
                iconData: Icons.alarm,
                time: "10 AM",
              ),
              SizedBox(height: 10),
              ToDoCard(
                title: "Wake up Bro2",
                check: true,
                iconBgColor: Colors.white,
                iconColor: Colors.red,
                iconData: Icons.alarm,
                time: "10 AM",
              ),
              SizedBox(height: 10),
            ],
          ),
        ),
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
