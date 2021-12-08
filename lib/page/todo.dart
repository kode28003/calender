import 'package:calender/apps/count.dart';
import 'package:calender/data/storage.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter/widgets.dart';

import 'package:flutter_hooks/flutter_hooks.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:calender/data/todo_list.dart';

final addTodoKey = UniqueKey();
final activeFilterKey = UniqueKey();
final completedFilterKey = UniqueKey();
final allFilterKey = UniqueKey();

final list=[
  '',
  '古着で全身コーデ',
  '100円寄付する',
  '賞味期限が近い商品を買う',
  '節水・節電を心がける',
  'マイボトルを買う',
  '週１で歩いて通勤',
  '非常食を買う',
  '電子書籍を買う',
  '詰め替えのボトルを買う',
  'いらない物をメルカリで売る',
  'ごみ拾いをする',
  'SDGsについて調べる',
  '',
  '',
  '',
];

final company=[
  '',
  'アップル',
  'グーグル',
  'パナソニック',
  '花王',
  'ヤクルトグループ',
  'トヨタ自動車',
];

final companyInformation=[
  '',
  '　2019年、Appleでは1,100万台以上のiPhoneがリサイクルされました。',
  '　米国では、Googleマップで自動車でのルートを検索すると、燃料効率のいいルートを提案されます。',
  '　カンボジアで、子どもが売られない仕組みを作るために、最貧困層の女性向けの雇用の支援を行っています。',
  '　世界各国のジェンダー平等の取り組みが優れている企業に贈られる「2020年男女平等指数」に選ばれました。',
  '　女性が活躍し働きやすい環境づくりとして、ヤクルトレディのお子さんをお預かりする保育所を運営しています。',
  '　電気自動車をより早く普及させるため、車両電動化技術の特許を無償で共有しています。',
];


final iconCount1Provider = StateProvider((ref) {
  return 1;
});

final iconCount2Provider = StateProvider((ref) {
  return 2;
});

final iconCount3Provider = StateProvider((ref) {
  return 3;
});

final updateCompanyProvider=StateProvider((ref){
  return 1;
});


final todoListProvider = StateNotifierProvider<TodoList, List<Todo>>((ref) {
  final iconNumber1=ref.watch(iconCount1Provider);
  final iconNumber2=ref.watch(iconCount2Provider);
  final iconNumber3=ref.watch(iconCount3Provider);

  return TodoList([
    Todo(id: '1', description: list[iconNumber1]),
    Todo(id: '2', description: list[iconNumber2]),
    Todo(id: '3', description: list[iconNumber3]),
  ]);
});

enum TodoListFilter {
  all,
  active,
  completed,
}

final todoListFilter = StateProvider((_) => TodoListFilter.active);

final uncompletedTodosCount = Provider<int>((ref) {
  return ref.watch(todoListProvider).where((todo) => !todo.completed).length;
});
final filteredTodos = Provider<List<Todo>>((ref) {
  final filter = ref.watch(todoListFilter);
  final todos = ref.watch(todoListProvider);

  switch (filter) {
    case TodoListFilter.completed:
      return todos.where((todo) => todo.completed).toList();
    case TodoListFilter.active:
      return todos.where((todo) => !todo.completed).toList();
    case TodoListFilter.all:
      return todos;
  }
});

class ToDoPage extends HookConsumerWidget {
  const ToDoPage({Key? key}) : super(key: key);
  static const String route = '/todo';

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final todos = ref.watch(filteredTodos);
    final newTodoController = useTextEditingController();
    final companyNum=ref.watch(updateCompanyProvider);

    return GestureDetector(
      onTap: () => FocusScope.of(context).unfocus(),
      child: CupertinoPageScaffold(
        backgroundColor: Colors.brown.shade50,
      navigationBar: new CupertinoNavigationBar(
        backgroundColor: Colors.brown.shade50,
       middle: const Text('SDGs To Do List'),
       leading: CupertinoButton(
         padding: EdgeInsets.fromLTRB(0, 6, 10, 5),
          onPressed: (){
            Navigator.pop(context);
            ref.read(countProvider.state).state+=1;
          },
            child: Icon(
          CupertinoIcons.back,
          color: Colors.black,
          size:30,
        ),
        ),
      ),
        child: ListView(
          padding: const EdgeInsets.symmetric(horizontal: 15, vertical: 18),
          children: [
            Container(
              foregroundDecoration: BoxDecoration(
               borderRadius: BorderRadius.circular(8.0),
              ),
                padding: EdgeInsets.fromLTRB(10, 0, 5, 0),
                child: RichText(
                  softWrap: true,
                  overflow: TextOverflow.ellipsis,
                  maxLines: 1,
                  text: TextSpan(
                    text: '企業の取り組み：「${company[companyNum]}」',
                    style: TextStyle(
                      fontSize: 18,
                      color: Colors.black,
                      decoration: TextDecoration.underline,
                      decorationThickness: 3,
                    ),
                  ),
                ),
              ),
              Container(
                padding: EdgeInsets.fromLTRB(8, 5, 5, 7),
                child: RichText(
                  softWrap: true,
                  overflow: TextOverflow.ellipsis,
                  maxLines: 3,
                  text: TextSpan(
                    text: companyInformation[companyNum],
                    style: TextStyle(
                      fontSize: 18,
                      color: Colors.black87,
                      decorationThickness: 3,
                    ),
                  ),
                ),
              ),
            new Divider(
                color: Colors.black
            ),
            const Title(),
            CupertinoTextField(
              decoration: BoxDecoration(
               borderRadius: BorderRadius.circular(8.0),
                color: Colors.white,
                ),
              key: addTodoKey,
              placeholder: 'SDGsの取り組みを入力してね',
              controller: newTodoController,
              onSubmitted: (value){
                if(value!='') {
                  ref.read(todoListProvider.notifier).add(value);
                  todoAddDate.add(value);
                  setDate();
                  newTodoController.clear();
                }
              },
            ),
            const SizedBox(height: 20),
            const Toolbar(),
            if (todos.isNotEmpty) const Divider(height: 0),
            for (int i = 0; i < todos.length; i++) ...[
              if (i > 0) const Divider(height: 0),
              Dismissible(
                key: ValueKey(todos[i].id),
                onDismissed: (_) {
                  ref.read(todoListProvider.notifier).remove(todos[i]);
                  todoAddDate.removeAt(i-3);
                  setDate();
                  getDate();
                },
                child: ProviderScope(
                  overrides: [
                    _currentTodo.overrideWithValue(todos[i]),
                  ],
                  child: const TodoItem(),
                ),
              )
            ],
          ],
        ),
      ),
    );
  }
}

class Toolbar extends HookConsumerWidget {
  const Toolbar({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final filter = ref.watch(todoListFilter);

    Color? textColorFor(TodoListFilter value) {
      return filter == value ? Colors.black : Colors.brown.shade200;
    }
    return Material(
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Expanded(
            child: Text(
              '   残り ${ref.watch(uncompletedTodosCount).toString()}個 ',
              overflow: TextOverflow.ellipsis,
            ),
          ),
          Tooltip(
            key: activeFilterKey,
            message: 'Only uncompleted todos',
            child: TextButton(
              onPressed: () => ref.read(todoListFilter.notifier).state =
                  TodoListFilter.active,
              style: ButtonStyle(
                visualDensity: VisualDensity.compact,
                foregroundColor: MaterialStateProperty.all(
                  textColorFor(TodoListFilter.active),
                ),
              ),
            child: const Text('Active'),
            ),
          ),
          Tooltip(
            key: completedFilterKey,
            message: 'Only completed todos',
            child: TextButton(
              onPressed: () => ref.read(todoListFilter.notifier).state =
                  TodoListFilter.completed,
              style: ButtonStyle(
                visualDensity: VisualDensity.compact,
                foregroundColor: MaterialStateProperty.all(
                  textColorFor(TodoListFilter.completed),
                ),
              ),
              child: const Text('Completed'),
            ),
          ),
          Tooltip(
            key: allFilterKey,
            message: 'All todos',
            child: TextButton(
              onPressed: () =>
              ref.read(todoListFilter.notifier).state = TodoListFilter.all,
              style: ButtonStyle(
                visualDensity: VisualDensity.compact,
                foregroundColor:
                MaterialStateProperty.all(textColorFor(TodoListFilter.all)),
              ),
            child: const Text('All'),
            ),
          ),
          Container(//////////////////////////////////
            width: 42,
            padding: EdgeInsets.all(2),
            child:FloatingActionButton(
              backgroundColor: Colors.brown.shade50,
              onPressed: () {
                final company=ref.read(updateCompanyProvider.state).state+=1;
                if(company==6){
                  ref.read(updateCompanyProvider.state).state=1;
                }
              },
              child: const Icon(
                Icons.refresh,
                size: 36,
                color: Colors.black54,
              ),
            ),
          ),
        ],
      ),
    );
  }
}

class Title extends StatelessWidget {
  const Title({Key? key}) : super(key: key);
  @override
  Widget build(BuildContext context) {
    return Container(
      padding:  EdgeInsets.fromLTRB(10, 5, 10, 30),
    child: const Text(
      'Monthly To Do List',
      textAlign: TextAlign.center,
      style: TextStyle(
        color: Colors.black54,
        fontSize: 28,
        fontFamily: 'Helvetica Neue',
      ),
    ),
    );
  }
}

final _currentTodo = Provider<Todo>((ref) => throw UnimplementedError());

class TodoItem extends HookConsumerWidget {
  const TodoItem({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final todo = ref.watch(_currentTodo);
    final itemFocusNode = useFocusNode();

    useListenable(itemFocusNode);
    final isFocused = itemFocusNode.hasFocus;
    final textEditingController = useTextEditingController();
    final textFieldFocusNode = useFocusNode();

    return Material(
      color: Colors.white,
      elevation: 6,
      child: Focus(
        focusNode: itemFocusNode,
        onFocusChange: (focused) {
          if (focused) {
            textEditingController.text = todo.description;
          } else {
            ref
                .read(todoListProvider.notifier)
                .edit(id: todo.id, description: textEditingController.text);
          }
        },
        child: SingleChildScrollView(
        child: Container(
        height: 50,
        child: ListTile(
          horizontalTitleGap:3,
          onTap: () {
            itemFocusNode.requestFocus();
            textFieldFocusNode.requestFocus();
          },
          leading: Checkbox(
            fillColor: MaterialStateProperty.all<Color>(Colors.black),
            value: todo.completed,
            onChanged: (value) =>
                ref.read(todoListProvider.notifier).toggle(todo.id),
          ),
          title: isFocused ? TextField(
            autofocus: true,
            focusNode: textFieldFocusNode,
            controller: textEditingController,
          )
              : Text(todo.description),
          trailing: IconButton(
            icon: Icon(
              Icons.autorenew,
            ),
            iconSize: 20,
            color: Colors.black54,
            onPressed: () {
              ref.read(todoListProvider.notifier).counter(todo.id,ref);
              if(todo.id=='1' || todo.id=='2' ||todo.id =='3'){
              for(int j=0;j<todoAddDate.length;j++) {
                ref.read(todoListProvider.notifier).add(todoAddDate[j]);
              }
              }
            },
          ),
        ),
      ),
        ),
      ),
    );
  }
}
