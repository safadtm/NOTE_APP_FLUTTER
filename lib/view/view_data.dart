// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class ViewTodo extends StatefulWidget {
  const ViewTodo({
    Key? key,
    required this.document,
    required this.id,
  }) : super(key: key);

  final Map<String, dynamic> document;
  final String id;

  @override
  State<ViewTodo> createState() => _ViewTodoState();
}

class _ViewTodoState extends State<ViewTodo> {
  late TextEditingController _titleController;
  late TextEditingController _descriptionController;

  late String task;
  late String category;

  bool edit = false;

  @override
  void initState() {
    super.initState();

    _titleController = TextEditingController(text: widget.document["title"]);
    _descriptionController =
        TextEditingController(text: widget.document["description"]);
    task = widget.document["task"];
    category = widget.document["category"];
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        height: MediaQuery.of(context).size.height,
        width: MediaQuery.of(context).size.width,
        decoration: const BoxDecoration(
          gradient: LinearGradient(
            colors: [
              Color(0xff1d1e26),
              Color(0xff252041),
            ],
          ),
        ),
        child: Padding(
          padding: const EdgeInsets.all(8.0),
          child: SingleChildScrollView(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                const SizedBox(height: 30),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    IconButton(
                      onPressed: () {
                        Navigator.pop(context);
                      },
                      icon: const Icon(
                        CupertinoIcons.arrow_left,
                        color: Colors.white,
                        size: 28,
                      ),
                    ),
                    Row(
                      children: [
                        IconButton(
                          onPressed: () {
                            FirebaseFirestore.instance
                                .collection("ToDo")
                                .doc(widget.id)
                                .delete()
                                .then((value) {
                              Navigator.pop(context);
                            });
                          },
                          icon: const Icon(
                            Icons.delete,
                            color: Colors.red,
                            size: 28,
                          ),
                        ),
                        IconButton(
                          onPressed: () {
                            setState(() {
                              edit = !edit;
                            });
                          },
                          icon: Icon(
                            Icons.edit,
                            color: edit ? Colors.yellowAccent : Colors.white,
                            size: 28,
                          ),
                        ),
                      ],
                    ),
                  ],
                ),
                Padding(
                  padding: const EdgeInsets.symmetric(),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        edit ? "Editing" : 'View',
                        style: const TextStyle(
                          fontSize: 33,
                          color: Colors.white,
                          fontWeight: FontWeight.bold,
                          letterSpacing: 4,
                        ),
                      ),
                      const SizedBox(height: 8),
                      const Text(
                        'Your Todo',
                        style: TextStyle(
                          fontSize: 33,
                          color: Colors.white,
                          fontWeight: FontWeight.bold,
                          letterSpacing: 2,
                        ),
                      ),
                      const SizedBox(height: 25),
                      label('Task Title'),
                      const SizedBox(height: 12),
                      title(context),
                      const SizedBox(height: 30),
                      label('Task Type'),
                      const SizedBox(height: 12),
                      Row(
                        children: [
                          taskSelected("Important", 0xff2664fa),
                          const SizedBox(width: 20),
                          taskSelected("Planned", 0xff2bc8d9),
                        ],
                      ),
                      const SizedBox(height: 25),
                      label('Description'),
                      const SizedBox(height: 12),
                      description(context),
                      const SizedBox(height: 25),
                      label('Category'),
                      const SizedBox(height: 12),
                      Wrap(
                        spacing: 10,
                        children: [
                          categorySelected("Food", 0xffff6d6e),
                          const SizedBox(width: 15),
                          categorySelected("WorkOut", 0xfff29732),
                          const SizedBox(width: 15),
                          categorySelected("Work", 0xff6557ff),
                          const SizedBox(width: 15),
                          categorySelected("Design", 0xff234ebd),
                          const SizedBox(width: 15),
                          categorySelected("Run", 0xff2bc8d9),
                        ],
                      ),
                      const SizedBox(height: 50),
                      edit ? button(context) : const SizedBox(),
                      const SizedBox(height: 30),
                    ],
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }

  Widget button(BuildContext context) {
    return InkWell(
      onTap: () {
        FirebaseFirestore.instance.collection("ToDo").doc(widget.id).update({
          "title": _titleController.text,
          "task": task,
          "category": category,
          "description": _descriptionController.text,
        });
        Navigator.pop(context);
      },
      child: Container(
        height: 56,
        width: MediaQuery.of(context).size.width,
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(20),
          gradient: const LinearGradient(
            colors: [
              Color(0xff8a32f1),
              Color(0xffad32f9),
            ],
          ),
        ),
        child: const Center(
          child: Text(
            "Update ToDo",
            style: TextStyle(
              color: Colors.white,
              fontSize: 18,
            ),
          ),
        ),
      ),
    );
  }

  Widget description(BuildContext context) {
    return Container(
      height: 150,
      width: MediaQuery.of(context).size.width,
      decoration: BoxDecoration(
        color: const Color(0xff2a2e3d),
        borderRadius: BorderRadius.circular(15),
      ),
      child: TextFormField(
        enabled: edit,
        controller: _descriptionController,
        style: const TextStyle(
          color: Colors.white,
          fontSize: 17,
        ),
        maxLines: null,
        decoration: const InputDecoration(
          border: InputBorder.none,
          hintText: "Discription",
          hintStyle: TextStyle(
            color: Colors.grey,
            fontSize: 17,
          ),
          contentPadding: EdgeInsets.only(left: 20, right: 20),
        ),
      ),
    );
  }

  Widget taskSelected(String label, int color) {
    return InkWell(
      onTap: edit
          ? () {
              setState(() {
                task = label;
              });
            }
          : null,
      child: Chip(
        backgroundColor: task == label ? Colors.white : Color(color),
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(10)),
        label: Text(
          label,
          style: TextStyle(
            color: task == label ? Colors.black : Colors.white,
            fontSize: 15,
            fontWeight: FontWeight.w600,
          ),
        ),
        labelPadding: const EdgeInsets.symmetric(horizontal: 17, vertical: 3.8),
      ),
    );
  }

  Widget categorySelected(String label, int color) {
    return InkWell(
      onTap: edit
          ? () {
              setState(() {
                category = label;
              });
            }
          : null,
      child: Chip(
        backgroundColor: category == label ? Colors.white : Color(color),
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(10)),
        label: Text(
          label,
          style: TextStyle(
            color: category == label ? Colors.black : Colors.white,
            fontSize: 15,
            fontWeight: FontWeight.w600,
          ),
        ),
        labelPadding: const EdgeInsets.symmetric(horizontal: 17, vertical: 3.8),
      ),
    );
  }

  Widget title(BuildContext context) {
    return Container(
      height: 55,
      width: MediaQuery.of(context).size.width,
      decoration: BoxDecoration(
        color: const Color(0xff2a2e3d),
        borderRadius: BorderRadius.circular(15),
      ),
      child: TextFormField(
        controller: _titleController,
        enabled: edit,
        style: const TextStyle(
          color: Colors.white,
          fontSize: 17,
        ),
        decoration: const InputDecoration(
          border: InputBorder.none,
          hintText: "Task Title",
          hintStyle: TextStyle(
            color: Colors.grey,
            fontSize: 17,
          ),
          contentPadding: EdgeInsets.only(left: 20, right: 20),
        ),
      ),
    );
  }

  Widget label(String label) {
    return Text(
      label,
      style: const TextStyle(
        fontSize: 16.5,
        color: Colors.white,
        fontWeight: FontWeight.w600,
        letterSpacing: 0.2,
      ),
    );
  }
}
