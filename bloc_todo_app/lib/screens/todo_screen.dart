import 'package:bloc_todo_app/cubit/todo_state.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import '../cubit/todo_cubit.dart';

class TodoScreen extends StatelessWidget {
  final TextEditingController _controller = TextEditingController();

  TodoScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('BLoC To-Do App')),
      body: Column(
        children: [
          // Input Field
          Padding(
            padding: const EdgeInsets.all(12.0),
            child: Row(
              children: [
                Expanded(
                  child: TextField(
                    controller: _controller,
                    decoration: InputDecoration(
                      labelText: 'Enter a task',
                      border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(8.0),
                      ),
                    ),
                  ),
                ),
                const SizedBox(width: 8),
                ElevatedButton(
                  onPressed: () {
                    final text = _controller.text.trim();
                    if (text.isNotEmpty) {
                      context.read<TodoCubit>().addTodo(text);
                      _controller.clear();
                    }
                  },
                  child: const Text('Add'),
                ),
              ],
            ),
          ),

          // To-Do List
          Expanded(
            child: BlocBuilder<TodoCubit, TodoState>(
              builder: (context, state) {
                if (state.todos.isEmpty) {
                  return const Center(child: Text('No tasks yet.'));
                }

                return ListView.builder(
                  itemCount: state.todos.length,
                  itemBuilder: (context, index) {
                    final todo = state.todos[index];
                    return ListTile(
                      title: Center(
                        child: Text(
                          todo.title,
                          style: TextStyle(
                            decoration:
                                todo.isCompleted
                                    ? TextDecoration.lineThrough
                                    : TextDecoration.none,
                          ),
                        ),
                      ),
                      leading: Checkbox(
                        value: todo.isCompleted,
                        onChanged: (_) {
                          context.read<TodoCubit>().toggleTodo(todo.id);
                        },
                      ),
                      trailing: IconButton(
                        icon: const Icon(Icons.delete),
                        onPressed: () {
                          context.read<TodoCubit>().deleteTodo(todo.id);
                        },
                      ),
                    );
                  },
                );
              },
            ),
          ),
        ],
      ),
    );
  }
}
