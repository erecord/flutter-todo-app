import 'package:testapp/models/todo.dart';

class TodoService {
  final List<Todo> _todoTasks = [];

  TodoService();

  void create(Todo task) {
    _todoTasks.add(task);
  }

  void delete(int index) {
    var todoId = _todoTasks[index].id;
    var todo = _todoTasks.firstWhere((element) => element.id == todoId);
    _todoTasks.remove(todo);
  }

  Todo find(int index) => _todoTasks[index];

  void toggle(int index) {
    var todo = _todoTasks[index];
    todo.status = !todo.status;
  }

  int count() => _todoTasks.length;
}
