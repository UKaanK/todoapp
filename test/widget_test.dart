// This is a basic Flutter widget test.
//
// To perform an interaction with a widget in your test, use the WidgetTester
// utility in the flutter_test package. For example, you can send tap and scroll
// gestures. You can also use WidgetTester to find child widgets in the widget
// tree, read text, and verify that the values of widget properties are correct.

import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:isar/isar.dart';
import 'package:path_provider/path_provider.dart';
import 'package:todoapp/data/models/isar_todo.dart';
import 'package:todoapp/data/repository/isar_todo_repo.dart';
import 'package:todoapp/domain/repository/todo_repo.dart';

import 'package:todoapp/main.dart';

void main() async{
   //get directory path for storing data
  final dir = await getApplicationDocumentsDirectory();

  //oper isar database
  final isar = await Isar.open([TodoIsarSchema],directory:dir.path);

  //initialize the repo with isar database
  final isarTodoRepo = IsarTodoRepo(isar);
  testWidgets('Counter increments smoke test', (WidgetTester tester) async {
    // Build our app and trigger a frame.
    await tester.pumpWidget( MyApp(todoRepo: isarTodoRepo,));

    // Verify that our counter starts at 0.
    expect(find.text('0'), findsOneWidget);
    expect(find.text('1'), findsNothing);

    // Tap the '+' icon and trigger a frame.
    await tester.tap(find.byIcon(Icons.add));
    await tester.pump();

    // Verify that our counter has incremented.
    expect(find.text('0'), findsNothing);
    expect(find.text('1'), findsOneWidget);
  });
}
