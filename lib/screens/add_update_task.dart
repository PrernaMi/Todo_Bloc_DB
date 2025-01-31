import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:todo_bloc_db/bloc/todo_bloc.dart';
import 'package:todo_bloc_db/bloc/todo_events.dart';

import '../models/todo_model.dart';

class AddUpdate extends StatelessWidget {
  bool flag;
  String? prevTitle;
  String? prevDesc;
  int? s_no;

  AddUpdate({required this.flag, this.prevTitle, this.prevDesc, this.s_no});

  TextEditingController titleController = TextEditingController();
  TextEditingController descController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    if (flag == false) {
      titleController.text = prevTitle!;
      descController.text = prevDesc!;
    }
    return Scaffold(
      appBar: AppBar(
        title: flag == true ? Center(child: Text("Add Your Note")) : Center(child: Text("Update your Note")),
      ),
      body: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          Padding(
            padding: EdgeInsets.symmetric(horizontal: 20.0, vertical: 10),
            child: TextField(
              controller: titleController,
              decoration: InputDecoration(
                  border: OutlineInputBorder(
                borderRadius: BorderRadius.circular(12),
              )),
            ),
          ),
          Padding(
            padding: EdgeInsets.symmetric(horizontal: 20.0, vertical: 10),
            child: TextField(
              controller: descController,
              decoration: InputDecoration(
                  border: OutlineInputBorder(
                borderRadius: BorderRadius.circular(12),
              )),
            ),
          ),
          ElevatedButton(
              onPressed: () {
                flag == true
                    ? context.read<TodoBloc>().add(AddTaskBloc(
                        newModel: ListModel(
                            title: titleController.text.toString(),
                            desc: descController.text.toString(),
                            isComp: 0)))
                    : context.read<TodoBloc>().add(UpdateTaskBloc(
                        newModel: ListModel(
                            title: titleController.text.toString(),
                            desc: descController.text.toString()),
                        s_no: s_no!));
                Navigator.pop(context);
              },
              child: flag == true ? Text("Add") : Text("Update"))
        ],
      ),
    );
  }
}
