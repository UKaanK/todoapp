/*

TO DO CUBİT - simple state management 

Each is a list of todos.

*/

import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:todoapp/domain/models/todo.dart';
import 'package:todoapp/domain/repository/todo_repo.dart';

class TodoCubit extends Cubit<List<Todo>> {
  TodoCubit() : super([]);

  void addTodo(String text) {
    final newTodo = Todo(
      id: state.length + 1, // Her todo'ya benzersiz bir id atıyoruz
      text: text,
    );
    emit([...state, newTodo]);
  }

  void toggleCompletion(Todo todo) {
    final updatedTodos = state.map((t) {
      return t.id == todo.id ? t.toggleCompletion() : t;
    }).toList();
    emit(updatedTodos); // Yeni durumu emit ediyoruz
  }

  void deleteTodo(Todo todo) {
    final updatedTodos = state.where((t) => t.id != todo.id).toList();
    emit(updatedTodos); // Durumu güncelleyip emit ediyoruz
  }
}