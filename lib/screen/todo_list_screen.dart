import 'package:flutter/material.dart';
import 'package:todo_manager/model/todo.dart';
import 'package:todo_manager/screen/add_todo_screen.dart';

class TodoListScreen extends StatefulWidget {
  const TodoListScreen({super.key});
  @override
  State<TodoListScreen> createState() => _TodoListScreenState();
}

class _TodoListScreenState extends State<TodoListScreen> {
  List<Todo> todoList = [];
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Todo'),
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: (){
          Navigator.push(context, MaterialPageRoute(builder: (context) => AddTodoScreen(addItem)));
        },
        backgroundColor: Colors.amberAccent,
        foregroundColor: Colors.white,
        child: Icon(Icons.add,size: 25,),
      ),

      body: ListView.separated(
        itemCount: todoList.length,
        itemBuilder: (context, index) {
          final item = todoList[index];
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
                    removeItem(index);
                  },
                  icon: const Icon(
                    Icons.delete_forever_outlined,
                    size: 20,
                    color: Colors.redAccent,
                  ),
                ),
                IconButton(
                  onPressed: () {

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


  void addItem(Todo todo){
    todoList.insert(0,todo);
    setState(() {});
  }

  void removeItem(int index){
    todoList.removeAt(index);
    setState(() {});
  }

}
