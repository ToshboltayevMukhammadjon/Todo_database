import 'package:todo/database/todo_dao.dart';
import 'package:todo/model/model_todo.dart';

class TodoRepository {
  final todoDao = TodoDao();

  Future getAllTodos({String? query}) => todoDao.getTodo(query: query);

  Future insertTodo(Todo todo) => todoDao.createTodo(todo);

  Future updateTodo(Todo todo) => todoDao.updateTodo(todo);

  Future deleteTodoById(int id) => todoDao.deleteTodo(id);

  //We are not going to use this in the demo
  Future deleteAllTodo() => todoDao.deleteAllTodos();
}
