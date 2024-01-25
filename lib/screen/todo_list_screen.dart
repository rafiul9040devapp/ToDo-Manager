import 'package:flutter/material.dart';
import 'package:todo_manager/model/todo.dart';
import 'package:todo_manager/model/todo_service.dart';
import 'package:todo_manager/screen/add_todo_screen.dart';

class TodoListScreen extends StatefulWidget {
  const TodoListScreen({super.key});

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
        onPressed: () async => await addToList(context),
        backgroundColor: Colors.amberAccent,
        foregroundColor: Colors.white,
        child: const Icon(
          Icons.add,
          size: 25,
        ),
      ),
      body: ListView.separated(
        itemCount: _toDoService.listOfTodo.length,
        itemBuilder: (context, index) {
          final item = _toDoService.listOfTodo[index];
          return ListTile(
            title: Text(item.title),
            subtitle: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(item.description),
                Text(item.date.toString()),
              ],
            ),
            trailing: Wrap(
              children: [
                IconButton(
                  onPressed: () {
                    removeFromList(index);
                  },
                  icon: const Icon(
                    Icons.delete_forever_outlined,
                    size: 20,
                    color: Colors.redAccent,
                  ),
                ),
                IconButton(
                  onPressed: () async {
                    await updateTheList(context, item, index);
                  },
                  icon: const Icon(
                    Icons.edit,
                    size: 20,
                    color: Colors.blueAccent,
                  ),
                ),
              ],
            ),
          );
        },
        separatorBuilder: (context, index) {
          return Divider(
            color: Colors.grey.shade200,
            height: 12,
            indent: 16,
          );
        },
      ),
    );
  }

  Future<void> updateTheList(BuildContext context, Todo item, int index) async {
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

  Future<void> addToList(BuildContext context) async {
    final result = await Navigator.push(
      context,
      MaterialPageRoute(
        builder: (context) => AddTodoScreen(),
      ),
    );
    if (result != null && result is Todo) {
      _toDoService.addItemToList(result);
      setState(() {});
    }
  }

  void removeFromList(int index) {
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
        content: const Text('Are you Sure About this?'),
        actions: [
          TextButton(
            onPressed: () {
              _toDoService.removeItemOfList(index);
              setState(() {});
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
          ),
          const SizedBox(
            width: 10,
          ),
          TextButton(
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
          ),
        ],
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(16),
        ),
      ),
    );
  }
}
