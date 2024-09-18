/*

  TO DO VİEW: responsible for UI

  - use BlocBuilder

*/

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:todoapp/domain/models/todo.dart';
import 'package:todoapp/presentation/todo_cubit.dart';

class TodoView extends StatelessWidget {
  const TodoView({super.key});

  // show dialog box for user to type

  void _showAddTodoBox(BuildContext context) {
    final todoCubit = context.read<TodoCubit>();
    final textController = TextEditingController();

    showDialog(
      context: context,
      builder: (context) => AlertDialog(
        content: TextField(
          controller: textController,
        ),
        actions: [
          //cancel button
          TextButton(
              onPressed: () => Navigator.of(context).pop(),
              child: Text("Cancel")),
          //add button
          TextButton(
              onPressed: () {
                todoCubit.addTodo(textController.text);
                Navigator.of(context).pop();
              },
              child: Text("Add"))
        ],
      ),
    );
  }

//BUILD UI
  @override
  Widget build(BuildContext context) {
    final todoCubit = context.read<TodoCubit>();

    return Scaffold(
        floatingActionButton: FloatingActionButton(
          child: Icon(Icons.add),
          onPressed: () => _showAddTodoBox(context),
        ),
        //BLOC BUILDER
        body: BlocBuilder<TodoCubit, List<Todo>>(
          builder: (context, state) {
            //ListView
            return ListView.builder(
              itemCount: state.length,
              itemBuilder: (context, index) {
                //get individual todo from todos list
                final todo = state[index];

                // List tile uı
                return ListTile(
                    //text
                    title: Text(todo.text),
                    //checkbox
                    leading: Checkbox(value: todo.isCompleted, onChanged: (value) => todoCubit.toggleCompletion(todo) ,),
                    //delete button
                    trailing: IconButton(onPressed: () => todoCubit.deleteTodo(todo), icon: Icon(Icons.cancel)),
                    );
              },
            );
          },
        ));
  }
}
