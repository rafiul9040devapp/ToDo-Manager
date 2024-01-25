import 'package:flutter/material.dart';
import 'package:todo_manager/model/todo.dart';

class AddTodoScreen extends StatelessWidget {

  final Function(Todo) addNewTodo;

  AddTodoScreen(this.addNewTodo, {super.key});

  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();

  final TextEditingController _titleTEController = TextEditingController();

  final TextEditingController _descriptionTEController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Add Todo'),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Form(
          key: _formKey,
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              TextFormField(
                controller: _titleTEController,
                decoration: const InputDecoration(
                  hintText: 'Title'
                ),
                validator: (String? value){
                  final v = value ?? '';
                  if(v.trim().isEmpty){
                    return 'Enter Your Title';
                  }
                   return null;
                },
              ),
              const SizedBox(height: 16,),
              TextFormField(
                controller: _descriptionTEController,
                maxLines: 5,
                maxLength: 100,
                decoration: const InputDecoration(
                    hintText: 'Title'
                ),
                validator: (String? value){
                  final v = value ?? '';
                  if(v.trim().isEmpty){
                    return 'Enter Your Description';
                  }
                  return null;
                },
              ),
              const SizedBox(height: 16,),
              SizedBox(
                width: MediaQuery.sizeOf(context).width,
                child: ElevatedButton(
                  onPressed: (){
                    if(_formKey.currentState!.validate()){
                      addNewTodo( Todo(_titleTEController.text,_descriptionTEController.text,DateTime.now()));
                      Navigator.pop(context);
                    }
                  },
                  child: Text('Add'),
                ),
              )
            ],
          ),
        ),
      ),
    );
  }
}
