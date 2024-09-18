import 'package:flutter/material.dart';
import 'package:isar/isar.dart';
import 'package:path_provider/path_provider.dart';
import 'package:todoapp/data/models/isar_todo.dart';
import 'package:todoapp/data/repository/isar_todo_repo.dart';
import 'package:todoapp/domain/repository/todo_repo.dart';
import 'package:todoapp/presentation/todo_page.dart';

void main()async  {
  WidgetsFlutterBinding.ensureInitialized();

  //get directory path for storing data
  final dir = await getApplicationDocumentsDirectory();

  //oper isar database
  final isar = await Isar.open([TodoIsarSchema],directory:dir.path);

  //initialize the repo with isar database
  final isarTodoRepo = IsarTodoRepo(isar);

  //runapp
  runApp( MyApp(todoRepo: isarTodoRepo,));
}
class MyApp extends StatelessWidget {
  final TodoRepo todoRepo;
  const MyApp({super.key, required this.todoRepo});

  @override
  Widget build(BuildContext context) {
    return  MaterialApp(
      debugShowCheckedModeBanner: false,
      home: TodoPage(todoRepo: todoRepo,),
    );
  }
}