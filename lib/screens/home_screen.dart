import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:todo_bloc_db/bloc/todo_bloc.dart';
import 'package:todo_bloc_db/bloc/todo_events.dart';
import 'package:todo_bloc_db/bloc/todo_states.dart';

import 'add_update_task.dart';

class HomeScreenDb extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    context.read<TodoBloc>().add(GetInitialTaskBloc());
    context.read<TodoBloc>().add(GetIsCompBloc());
    return Scaffold(
      appBar: AppBar(
        title: Center(child: Text("Home Page")),
      ),
      body: BlocBuilder<TodoBloc, TodoStates>(
        builder: (_, state) {
          if (state is LoadingState) {
            return Center(
              child: CircularProgressIndicator(),
            );
          }
          if (state is ErrorState) {
            return Center(
              child: Text(state.msg),
            );
          }
          if (state is LoadedState) {
            return ListView.builder(
                itemCount: state.allTask.length,
                itemBuilder: (_, Index) {
                  return ListTile(
                    leading: SizedBox(
                      width: 100,
                      child: Row(
                        children: [
                          state.allTask[Index].isComp == 0
                              ? IconButton(
                                  onPressed: () {
                                    context.read<TodoBloc>().add(AddIsCompBloc(
                                        s_no: state.allTask[Index].s_no!,
                                        isComp: 1));
                                  },
                                  icon: Icon(
                                    Icons.check_box_outline_blank,
                                    size: 30,
                                  ))
                              : IconButton(
                                  onPressed: () {
                                    context.read<TodoBloc>().add(AddIsCompBloc(
                                        s_no: state.allTask[Index].s_no!,
                                        isComp: 0));
                                  },
                                  icon: Icon(
                                    Icons.check_box,
                                    color: Colors.green,
                                    size: 30,
                                  ),
                                ),
                          CircleAvatar(
                            child: Text('${Index + 1}'),
                          ),
                        ],
                      ),
                    ),
                    title: Text(state.allTask[Index].title),
                    subtitle: Text(state.allTask[Index].desc),
                    trailing: SizedBox(
                      width: 100,
                      child: Row(
                        children: [
                          IconButton(
                              onPressed: () {
                                Navigator.push(context,
                                    MaterialPageRoute(builder: (context) {
                                  return AddUpdate(
                                    flag: false,
                                    prevTitle: state.allTask[Index].title,
                                    prevDesc: state.allTask[Index].desc,
                                    s_no: state.allTask[Index].s_no,
                                  );
                                }));
                              },
                              icon: Icon(Icons.edit)),
                          IconButton(
                              onPressed: () {
                                context.read<TodoBloc>().add(DeleteTaskBloc(
                                    s_no: state.allTask[Index].s_no!));
                              },
                              icon: Icon(Icons.delete))
                        ],
                      ),
                    ),
                  );
                });
          }
          return Container();
        },
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          Navigator.push(context, MaterialPageRoute(builder: (context) {
            return AddUpdate(
              flag: true,
            );
          }));
        },
        child: Icon(Icons.add),
      ),
    );
  }
}
