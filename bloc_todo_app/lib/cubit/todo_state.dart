import 'package:equatable/equatable.dart';
import '../models/todo_model.dart';

class TodoState extends Equatable {
  final List<TodoModel> todos;

  const TodoState({this.todos = const []});

  @override
  List<Object> get props => [todos];
}
