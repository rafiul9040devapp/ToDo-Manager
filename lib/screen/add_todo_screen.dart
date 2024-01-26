import 'package:flutter/material.dart';
import 'package:todo_manager/components/custom_text_form_field.dart';
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
    initializeControllers();

    return Scaffold(
      resizeToAvoidBottomInset: false,
      appBar: AppBar(
        title: Text(todo == null ? 'Add Todo' : 'Edit Todo'),
      ),
      body: buildForm(context),
    );
  }

  Widget buildForm(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(16.0),
      child: Form(
        key: _formKey,
        child: Column(
          children: [
            CustomTextFormField(
              controller: _titleTEController,
              hintText: 'Title',
              validator: (value) => validateInput(value, 'Enter Your Title'),
              textInputAction: TextInputAction.next,
            ),
            const SizedBox(height: 16),
            CustomTextFormField(
              controller: _descriptionTEController,
              hintText: 'Description',
              validator: (value) =>
                  validateInput(value, 'Enter Your Description'),
              textInputAction: TextInputAction.done,
              maxLines: 5,
              maxLength: 100,
            ),
            const SizedBox(height: 16),
            buildElevatedButton(context),
          ],
        ),
      ),
    );
  }
  Widget buildElevatedButton(BuildContext context) {
    return SizedBox(
      width: MediaQuery.of(context).size.width,
      child: ElevatedButton(
        onPressed: () => addingOrUpdatingTheList(context),
        child: Padding(
          padding: const EdgeInsets.all(8.0),
          child: Text(todo == null ? 'Save' : 'Update'),
        ),
      ),
    );
  }

  void initializeControllers() {
    _titleTEController.text = todo?.title ?? '';
    _descriptionTEController.text = todo?.description ?? '';
  }

  String? validateInput(String? value, String errorMessage) {
    return value?.trim().isEmpty ?? true ? errorMessage : null;
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
