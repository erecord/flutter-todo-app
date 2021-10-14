import 'package:flutter/material.dart';
import 'package:testapp/models/todo.dart';
import 'package:testapp/services/todo_service.dart';
import 'package:testapp/widgets/popup_form.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
        title: 'Title',
        theme: ThemeData(
          primarySwatch: Colors.green,
        ),
        home: MyHomePage(title: ' Simple Todo App'));
  }
}

class MyHomePage extends StatefulWidget {
  MyHomePage({Key? key, required this.title}) : super(key: key);

  final String title;

  @override
  _MyHomePageState createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  TodoService todoService = TodoService();

  void _createTodo(Todo todo) {
    setState(() {
      todoService.create(todo);
    });
  }

  void _toggleStatus(int index) {
    setState(() {
      todoService.toggle(index);
    });
  }

  void _deleteTodo(int index) {
    setState(() {
      todoService.delete(index);
    });
  }

  Icon _getCheckboxIcon(int index) {
    return todoService.find(index).status
        ? Icon(
            Icons.check_box_outlined,
            size: 20,
            color: Colors.green[400],
          )
        : Icon(
            Icons.check_box_outline_blank,
            size: 20,
            color: Colors.green[400],
          );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: Text(widget.title),
        ),
        body: ListView.builder(
            itemCount: todoService.count(), itemBuilder: listViewBuilder),
        floatingActionButton: PopupForm(callback: _createTodo));
  }

  Card listViewBuilder(BuildContext context, int index) {
    var todo = todoService.find(index);
    return Card(
        key: UniqueKey(),
        child: ListTile(
          title: Text(
            todo.title,
            style: todo.status
                ? const TextStyle(decoration: TextDecoration.lineThrough)
                : const TextStyle(decoration: TextDecoration.none),
          ),
          trailing: Row(
            mainAxisSize: MainAxisSize.min,
            children: <Widget>[
              IconButton(
                icon: _getCheckboxIcon(index),
                onPressed: () {
                  _toggleStatus(index);
                },
              ),
              IconButton(
                icon: Icon(
                  Icons.delete_outline,
                  size: 20.0,
                  color: Colors.green[400],
                ),
                onPressed: () {
                  _deleteTodo(index);
                },
              ),
            ],
          ),
        ));
  }
}
