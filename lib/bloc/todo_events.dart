import 'package:todo_bloc_db/models/todo_model.dart';

abstract class TodoEvents{}

class AddTaskBloc extends TodoEvents{
  ListModel newModel;
  AddTaskBloc({required this.newModel});
}

class UpdateTaskBloc extends TodoEvents{
  ListModel newModel;
  int s_no;
  UpdateTaskBloc({required this.newModel,required this.s_no});
}

class DeleteTaskBloc extends TodoEvents{
  int s_no;
  DeleteTaskBloc({required this.s_no});
}

class GetInitialTaskBloc extends TodoEvents{}

class AddIsCompBloc extends TodoEvents{
  int s_no;
  int isComp;
  AddIsCompBloc({required this.s_no,required this.isComp});
}

class GetIsCompBloc extends TodoEvents{}

class SignUpBloc extends TodoEvents{
  String fname;
  String lname;
  String email;
  String phone;
  String pass;
  SignUpBloc({
    required this.fname,
    required this.lname,
    required this.email,
    required this.phone,
    required this.pass
  });
}
