import 'package:calender/page/todo.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:riverpod/riverpod.dart';
import 'package:uuid/uuid.dart';

const _uuid = Uuid();

class Todo {
  Todo({
    required this.description,
    required this.id,
    this.completed = false,
  });

  final String id;
  final String description;
  final bool completed;

  @override
  String toString() {
    return 'Todo(description: $description, completed: $completed)';
  }
}

class TodoList extends StateNotifier<List<Todo>> {
  TodoList([List<Todo>? initialTodos]) : super(initialTodos ?? []);

  void add(String description) {
    state = [
      ...state,
      Todo(
        id: _uuid.v4(),
        description: description,
      ),
    ];
  }

  void toggle(String id) {
    state = [
      for (final todo in state)
        if (todo.id == id)
          Todo(
            id: todo.id,
            completed: !todo.completed,
            description: todo.description,
          )
        else
          todo,
    ];
  }

  void counter(String id,WidgetRef ref) {
    if(id=='1'){
      ref.read(iconCount1Provider.state).state+=3;
      final iconNumber1=ref.read(iconCount1Provider);
      if(iconNumber1==13){
        ref.read(iconCount1Provider.state).state=1;
      }
    }
    if(id=='2'){
      ref.read(iconCount2Provider.state).state+=3;
      final iconNumber2=ref.read(iconCount2Provider);
      if(iconNumber2==14){
        ref.read(iconCount2Provider.state).state=2;
      }
    }
    if(id=='3'){
      ref.read(iconCount3Provider.state).state+=3;
      final iconNumber3=ref.read(iconCount3Provider);
      if(iconNumber3==15){
        ref.read(iconCount3Provider.state).state=3;
      }
    }
  }

  void edit({required String id, required String description}) {
    state = [
      for (final todo in state)
        if (todo.id == id)
          Todo(
            id: todo.id,
            completed: todo.completed,
            description: description,
          )
        else
          todo,
    ];
  }

  void remove(Todo target) {
    state = state.where((todo) => todo.id != target.id).toList();
  }
}