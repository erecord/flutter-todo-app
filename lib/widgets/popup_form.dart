import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:testapp/models/todo.dart';

class PopupForm extends StatefulWidget {
  Function callback;

  PopupForm({Key? key, required this.callback}) : super(key: key);

  @override
  _PopupFormState createState() => _PopupFormState();
}

class _PopupFormState extends State<PopupForm> {
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

  Widget _openDialog() {
    return AlertDialog(
      scrollable: true,
      title: const Text('Add task'),
      content: Center(
        child: Column(
          children: [
            TextFormField(
              controller: titleController,
              autofocus: true,
              decoration: const InputDecoration(
                  labelText: 'Title', icon: Icon(Icons.task)),
            ),
            TextFormField(
              controller: descriptionController,
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
