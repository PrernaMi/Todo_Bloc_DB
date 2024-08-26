import '../models/todo_model.dart';

abstract class TodoStates {}

class InitialState extends TodoStates {}

class LoadedState extends TodoStates {
  List<ListModel> allTask = [];
  LoadedState({required this.allTask});
}

class LoadingState extends TodoStates {}

class ErrorState extends TodoStates {
  String msg;
  ErrorState({required this.msg});
}
