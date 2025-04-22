import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:todo_riverpod/models/todo.dart';
import 'package:todo_riverpod/providers/todo_provider.dart';

class TodoScreen extends ConsumerStatefulWidget {
  const TodoScreen({super.key});

  @override
  ConsumerState<TodoScreen> createState() => _TodoScreenState();
}

class _TodoScreenState extends ConsumerState<TodoScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Todo List')),
      floatingActionButton: FloatingActionButton(
        onPressed: () => buildAdd(),
        child: Icon(Icons.add),
      ),
      body: Consumer(
        builder: (context, wiRef, child) {
          List<Todo> todos = wiRef.watch(todoNotifierProvider);
          return ListView.builder(
            itemCount: todos.length,
            itemBuilder: (context, index) {
              Todo todo = todos[index];
              return ListTile(
                leading: IconButton.outlined(
                  onPressed: () => buildUpdate(todo),
                  icon: Icon(Icons.edit),
                ),
                title: Text(todo.title),
                subtitle: Text(todo.body),
                trailing: IconButton.outlined(
                  onPressed: () {
                    ref
                        .watch(todoNotifierProvider.notifier)
                        .deleteTodo(todo.id);
                  },
                  icon: Icon(Icons.delete),
                ),
              );
            },
          );
        },
      ),
    );
  }

  buildAdd() {
    final edtTitle = TextEditingController();
    final edtBody = TextEditingController();

    showDialog(
      context: context,
      builder:
          (context) => SimpleDialog(
            title: Text('Add Todo'),
            contentPadding: EdgeInsets.all(20),
            children: [
              TextField(
                controller: edtTitle,
                decoration: InputDecoration(labelText: 'Title'),
              ),
              SizedBox(height: 10),
              TextField(
                controller: edtBody,
                decoration: InputDecoration(labelText: 'Body'),
              ),
              SizedBox(height: 10),
              ElevatedButton(
                onPressed: () {
                  Navigator.pop(context);
                  ref
                      .read(todoNotifierProvider.notifier)
                      .addTodo(edtTitle.text, edtBody.text);
                },
                child: Text('Save'),
              ),
            ],
          ),
    );
  }

  buildUpdate(Todo oldTodo) {
    final edtTitle = TextEditingController();
    final edtBody = TextEditingController();
    edtTitle.text = oldTodo.title;
    edtBody.text = oldTodo.body;

    showDialog(
      context: context,
      builder:
          (context) => SimpleDialog(
            title: Text('Update Todo'),
            contentPadding: EdgeInsets.all(20),
            children: [
              TextField(
                controller: edtTitle,
                decoration: InputDecoration(labelText: 'Title'),
              ),
              SizedBox(height: 10),
              TextField(
                controller: edtBody,
                decoration: InputDecoration(labelText: 'Body'),
              ),
              SizedBox(height: 10),
              ElevatedButton(
                onPressed: () {
                  Navigator.pop(context);
                  Todo updatedTodo = oldTodo.copyWith(
                    title: edtTitle.text,
                    body: edtBody.text,
                  );
                  ref
                      .read(todoNotifierProvider.notifier)
                      .updateTodo(updatedTodo);
                },
                child: Text('Save'),
              ),
            ],
          ),
    );
  }
}
