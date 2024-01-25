import 'package:todo_manager/model/todo.dart';

class ToDoService {
  final List<Todo> _listOfTodo = [];
  List<Todo> get listOfTodo => _listOfTodo;


  void addItemToList(Todo todo) => _listOfTodo.add(todo);

  void updateItemOfList(Todo todo, int index) => _listOfTodo[index] = todo;

  void removeItemOfList(int index) => _listOfTodo.removeAt(index);
}
