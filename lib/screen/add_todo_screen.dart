import 'package:flutter/material.dart';
import 'package:todo_manager/model/todo.dart';

class AddTodoScreen extends StatelessWidget {
  final Todo? todo;

  AddTodoScreen({Key? key, this.todo}) : super(key: key);

  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();

  final TextEditingController _titleTEController = TextEditingController();

  final TextEditingController _descriptionTEController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    initializeControllers();
    return Scaffold(
      resizeToAvoidBottomInset : false,
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
                textInputAction: TextInputAction.next,
                decoration: const InputDecoration(hintText: 'Title'),
                validator: (String? value) => validateInput(value, 'Enter Your Title'),
              ),
              const SizedBox(
                height: 16,
              ),
              TextFormField(
                controller: _descriptionTEController,
                textInputAction: TextInputAction.done,
                maxLines: 5,
                maxLength: 100,
                decoration: const InputDecoration(hintText: 'Description'),
                validator: (String? value) => validateInput(value, 'Enter Your Description'),
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
                  child: Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: Text(todo == null ? 'Save' : 'Update'),
                  ),
                ),
              )
            ],
          ),
        ),
      ),
    );
  }

  void initializeControllers() {
    if (todo != null) {
      _titleTEController.text = todo?.title ?? '';
      _descriptionTEController.text = todo?.description ?? '';
    }
  }


  String? validateInput(String? value, String errorMessage) {
    return value?.trim().isEmpty ?? true ? errorMessage : null;
  }

  void addingOrUpdatingTheList(BuildContext context) {
    if (_formKey.currentState!.validate()) {
      Navigator.pop(
        context,
        Todo(
          _titleTEController.text.trim(),
          _descriptionTEController.text.trim(),
          DateTime.now(),
        ),
      );
    }
  }
}
