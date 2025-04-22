import 'package:riverpod_annotation/riverpod_annotation.dart';
import 'package:todo_riverpod/models/todo.dart';
import 'package:uuid/uuid.dart';

part 'todo_provider.g.dart';

@riverpod
class TodoNotifier extends _$TodoNotifier {
  @override
  List<Todo> build() => <Todo>[];

  void addTodo(String title, String body) {
    Todo newTodo = Todo(id: const Uuid().v4(), title: title, body: body);

    state = [...state, newTodo];
  }

  void updateTodo(Todo newTodo) {
    int index = state.indexWhere((element) => element.id == newTodo.id);
    state[index] = newTodo;
    state = [...state];
  }

  void deleteTodo(String id) {
    state.removeWhere((element) => element.id == id);
    state = [...state];
  }
}
