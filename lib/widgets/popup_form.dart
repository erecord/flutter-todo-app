import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import 'package:testapp/models/todo.dart';

class PopupForm extends StatefulWidget {
  Function callback;

  PopupForm({Key? key, required this.callback}) : super(key: key);

  @override
  _PopupFormState createState() => _PopupFormState();
}

class _PopupFormState extends State<PopupForm> {
  final _formKey = GlobalKey<FormState>();
  var titleController = TextEditingController();
  var descriptionController = TextEditingController();

  void _addTodo() {
    var task = Todo(
        title: titleController.text,
        description: descriptionController.text,
        status: false);

    setState(() {
      titleController.clear();
      descriptionController.clear();
    });

    widget.callback(task);
    Navigator.pop(context);
  }

  void onFormSubmitted(value) {
    if (_formKey.currentState!.validate()) {
      _addTodo();
    }
  }

  String? titleValidator(String? value) {
    if (value == null || value.isEmpty) {
      return "Please enter a title";
    }
    return null;
  }

  Widget _openDialog() {
    return AlertDialog(
      scrollable: true,
      title: const Text('Add task'),
      content: Center(
        child: Column(
          key: _formKey,
          children: [
            TextFormField(
              controller: titleController,
              validator: titleValidator,
              onFieldSubmitted: onFormSubmitted,
              autofocus: true,
              decoration: const InputDecoration(
                  labelText: 'Title', icon: Icon(Icons.task)),
            ),
            TextFormField(
              controller: descriptionController,
              onFieldSubmitted: onFormSubmitted,
              decoration: const InputDecoration(hintText: 'Description'),
            )
          ],
        ),
      ),
      actions: [
        TextButton(
          onPressed: () {
            _addTodo();
          },
          child: const Text('Add'),
        ),
        TextButton(
            onPressed: () {
              Navigator.pop(context);
            },
            child: const Text('Cancel'))
      ],
    );
  }

  @override
  Widget build(BuildContext context) {
    return FloatingActionButton(
      onPressed: () {
        showDialog(context: context, builder: (_) => _openDialog());
      },
      tooltip: 'Add Task',
      child: const Icon(Icons.add),
    );
  }
}
