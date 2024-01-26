import 'package:flutter/material.dart';
import 'package:todo_manager/constants/assets.dart';
import 'package:todo_manager/model/todo.dart';
import 'package:todo_manager/service/todo_service.dart';
import 'package:todo_manager/screen/add_todo_screen.dart';
import 'package:todo_manager/utils/date_fomat.dart';

class TodoListScreen extends StatefulWidget {
  const TodoListScreen({Key? key}) : super(key: key);

  @override
  State<TodoListScreen> createState() => _TodoListScreenState();
}

class _TodoListScreenState extends State<TodoListScreen> {
  final ToDoService _toDoService = ToDoService();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Todo'),
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () => _onTapAddNewTodoFAB(context),
        backgroundColor: Colors.amberAccent,
        foregroundColor: Colors.white,
        child: const Icon(
          Icons.add,
          size: 25,
        ),
      ),
      body: Visibility(
        visible: _toDoService.listOfTodo.isNotEmpty,
        replacement: Center(
          child: Image.asset(
            AppImages.emptyList,
            fit: BoxFit.fitWidth,
          ),
        ),
        child: _buildTodoList(),
      ),
    );
  }

  Widget _buildTodoList() {
    return ListView.separated(
      itemCount: _toDoService.listOfTodo.length,
      itemBuilder: (context, index) {
        final todo = _toDoService.listOfTodo[index];
        return _buildTodoItem(todo, index);
      },
      separatorBuilder: (context, index) {
        return Divider(
          color: Colors.grey.shade300,
          height: 12,
          indent: 16,
        );
      },
    );
  }

  ListTile _buildTodoItem(Todo item, int index) {
    return ListTile(
      title: Text(item.title),
      subtitle: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(item.description),
          Text(formattedDate(item.date)),
        ],
      ),
      trailing: Wrap(
        children: [
          buildDeleteButton(index),
          buildEditButton(item, index),
        ],
      ),
    );
  }

  Widget buildDeleteButton(int index) {
    return IconButton(
      onPressed: () {
        confirmDeleteDialog(index);
      },
      icon: const Icon(
        Icons.delete_forever_outlined,
        size: 20,
        color: Colors.redAccent,
      ),
    );
  }

  Widget buildEditButton(Todo item, int index) {
    return IconButton(
      onPressed: () => _onTapEditTodo(context, item, index),
      icon: const Icon(
        Icons.edit,
        size: 20,
        color: Colors.blueAccent,
      ),
    );
  }

  Future<void> _onTapAddNewTodoFAB(BuildContext context) async {
    final result = await Navigator.push(
      context,
      MaterialPageRoute(
        builder: (context) => AddTodoScreen(),
      ),
    );
    if (result != null && result is Todo) {
      _toDoService.createItemForList(result);
      setState(() {});
    }
  }

  Future<void> _onTapEditTodo(
      BuildContext context, Todo item, int index) async {
    final result = await Navigator.push(
      context,
      MaterialPageRoute(
        builder: (context) => AddTodoScreen(
          todo: item,
        ),
      ),
    );
    if (result != null && result is Todo) {
      _toDoService.updateItemOfList(result, index);
      setState(() {});
    }
  }

  void _removeTodo(int index) {
    _toDoService.removeItemOfList(index);
    setState(() {});
  }

  void confirmDeleteDialog(int index) {
    showDialog(
      context: context,
      builder: (context) => AlertDialog(
        title: const Text(
          'Delete The Todo!!!!',
          style: TextStyle(
            color: Colors.red,
            fontSize: 20,
            fontWeight: FontWeight.w600,
          ),
          textAlign: TextAlign.center,
        ),
        content: const Text(
          'Are you Sure About this?',
          textAlign: TextAlign.center,
        ),
        actions: [
          buildOkButton(index),
          buildCancelButton(),
        ],
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(16),
        ),
      ),
    );
  }

  Widget buildOkButton(int index) {
    return TextButton(
      onPressed: () {
        _removeTodo(index);
        Navigator.pop(context);
      },
      child: const Text(
        'Ok',
        style: TextStyle(
          color: Colors.greenAccent,
          fontSize: 20,
          fontWeight: FontWeight.w600,
        ),
      ),
    );
  }

  Widget buildCancelButton() {
    return TextButton(
      onPressed: () {
        Navigator.pop(context);
      },
      child: const Text(
        'Cancel',
        style: TextStyle(
          color: Colors.red,
          fontSize: 20,
          fontWeight: FontWeight.w600,
        ),
      ),
    );
  }
}
