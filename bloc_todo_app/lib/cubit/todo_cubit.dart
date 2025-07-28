import 'package:bloc_todo_app/cubit/todo_state.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import '../models/todo_model.dart';

class TodoCubit extends Cubit<TodoState> {
  TodoCubit() : super(const TodoState());

  void addTodo(String title) {
    final newTodo = TodoModel(id: DateTime.now().toString(), title: title);
    emit(TodoState(todos: [...state.todos, newTodo]));
  }

  void toggleTodo(String id) {
    final updated =
        state.todos.map((todo) {
          if (todo.id == id) {
            return todo.copyWith(isCompleted: !todo.isCompleted);
          }
          return todo;
        }).toList();

    emit(TodoState(todos: updated));
  }

  void deleteTodo(String id) {
    final updated = state.todos.where((todo) => todo.id != id).toList();
    emit(TodoState(todos: updated));
  }
}
