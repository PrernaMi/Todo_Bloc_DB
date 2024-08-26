import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:todo_bloc_db/bloc/todo_events.dart';
import 'package:todo_bloc_db/bloc/todo_states.dart';

import '../database/local/db_helper.dart';

class TodoBloc extends Bloc<TodoEvents, TodoStates> {
  DbHelper? mainDb;

  TodoBloc({required this.mainDb}) : super(InitialState()) {
    on<AddTaskBloc>((event, emit) async {
      emit(LoadingState());
      bool check = await mainDb!.addInDb(newModel: event.newModel);
      if (check) {
        var currentTask = await mainDb!.getFromDb();
        emit(LoadedState(allTask: currentTask));
      } else {
        emit(ErrorState(msg: "No Task Added"));
      }
    });

    on<UpdateTaskBloc>((event, emit) async {
      emit(LoadingState());
      bool check =
          await mainDb!.updateInDb(newModel: event.newModel, s_no: event.s_no);
      if (check) {
        var task = await mainDb!.getFromDb();
        emit(LoadedState(allTask: task));
      } else {
        emit(ErrorState(msg: "No Task Updated"));
      }
    });

    on<DeleteTaskBloc>((event, emit) async {
      emit(LoadingState());
      bool check = await mainDb!.deleteInDb(s_no: event.s_no);
      if (check) {
        var task = await mainDb!.getFromDb();
        emit(LoadedState(allTask: task));
      } else {
        emit(ErrorState(msg: "No Task deleted"));
      }
    });

    on<GetInitialTaskBloc>((event, emit) async {
      emit(LoadingState());
      var allTasks = await mainDb!.getFromDb();
      emit(LoadedState(allTask: allTasks));
    });

    on<AddIsCompBloc>((event, emit) async {
      emit(LoadingState());
      bool check =
          await mainDb!.updateIsComInDb(isComp: event.isComp, s_no: event.s_no);
      if (check) {
        var data = await mainDb!.getFromDb();
        emit(LoadedState(allTask: data));
      } else {
        emit(ErrorState(msg: "No Task updated"));
      }
    });

    on<GetIsCompBloc>((event, emit) async {
      double isCom = await mainDb!.getIsCompDb();
      var data = await mainDb!.getFromDb();
      emit(LoadedState(allTask: data));
    });
  }
}
