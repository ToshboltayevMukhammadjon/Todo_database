import 'dart:async';

import 'package:todo/model/model_todo.dart';
import 'package:todo/repository/todo_repository.dart';

class TodoBloc {
  //Get instance of the Repository
  final _todoRepository = TodoRepository();

  final _todoController = StreamController<List<Todo>>.broadcast();

  get todo => _todoController.stream;

  TodoBloc() {
    getTodo();
  }

  getTodo({String? query}) async {
    _todoController.sink.add(await _todoRepository.getAllTodos(query: query));
  }

  addTodo(Todo todo) async {
    await _todoRepository.insertTodo(todo);
    getTodo();
  }

  updateTodo(Todo todo) async {
    await _todoRepository.updateTodo(todo);
    getTodo();
  }

  deleteTodoById(int id) async {
    _todoRepository.deleteTodoById(id);
    getTodo();
  }

  dispose() {
    _todoController.close();
  }
}
