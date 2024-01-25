import 'package:flutter/material.dart';
import 'package:todo_manager/model/todo.dart';

class AddTodoScreen extends StatelessWidget {
  final Todo? todo;

  AddTodoScreen({Key? key, this.todo}) : super(key: key);

  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();

  final TextEditingController _titleTEController = TextEditingController();

  final TextEditingController _descriptionTEController =
      TextEditingController();

  @override
  Widget build(BuildContext context) {
    if (todo != null) {
      _titleTEController.text = todo?.title ?? '';
      _descriptionTEController.text = todo?.description ?? '';
    }

    return Scaffold(
      appBar: AppBar(
        title: Text(todo == null ? 'Add Todo' : 'Edit Todo'),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Form(
          key: _formKey,
          child: Column(
            children: [
              TextFormField(
                controller: _titleTEController,
                decoration: const InputDecoration(hintText: 'Title'),
                validator: (String? value) {
                  return validationOfInput(value, 'Enter Your Title');
                },
              ),
              const SizedBox(
                height: 16,
              ),
              TextFormField(
                controller: _descriptionTEController,
                maxLines: 5,
                maxLength: 100,
                decoration: const InputDecoration(hintText: 'Title'),
                validator: (String? value) {
                  return validationOfInput(value, 'Enter Your Description');
                },
              ),
              const SizedBox(
                height: 16,
              ),
              SizedBox(
                width: MediaQuery.sizeOf(context).width,
                child: ElevatedButton(
                  onPressed: () {
                    addingOrUpdatingTheList(context);
                  },
                  child: Text(todo == null ? 'Save' : 'Update'),
                ),
              )
            ],
          ),
        ),
      ),
    );
  }

  String? validationOfInput(String? value, String errorMessage) {
    final v = value ?? '';
    if (v.trim().isEmpty) {
      return errorMessage;
    }
    return null;
  }

  void addingOrUpdatingTheList(BuildContext context) {
    if (_formKey.currentState!.validate()) {
      Navigator.pop(
        context,
        Todo(
          _titleTEController.text,
          _descriptionTEController.text,
          DateTime.now(),
        ),
      );
    }
  }
}
