It’s almost the same but 

**you always need:**

1. **Abstract base class** (defines the event family)
2. **Concrete event classes** that extend the abstract class
3. **Use those concrete classes** as actual events

```dart
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

abstract class TodoEvent {}

class AddTodo extends TodoEvent {
  final String title;
  AddTodo(this.title);
}

class TodoToggle extends TodoEvent {
  final int index;
  TodoToggle(this.index);
}

class DelTodo extends TodoEvent {
  final int index;
  DelTodo(this.index);
}

// Todo model
class TodoObj {
  String title;
  bool isDone;
  TodoObj({required this.isDone, required this.title});
}

class BlocClass extends Bloc<TodoEvent, List<TodoObj>> {
  BlocClass() : super([TodoObj(isDone: false, title: 'New task')]) {
    on<AddTodo>((event, emit) {
      final currentList = List<TodoObj>.from(state);
      currentList.add(TodoObj(isDone: false, title: event.title));
      emit(currentList);
    });
```

**And function that doesn't need to be rebuilt with emit can be just written without any abstract class or anything like openField**

```dart
void openField(BuildContext context, TextEditingController controller){
    showDialog(context: context, builder: (context) => AlertDialog(
      content: TextField(
        controller: controller,
      ),
      actions: [
        TextButton(onPressed: (){
          add(AddTodo(controller.text));
          Navigator.of(context).pop();
        }, child: Text('add'),),
      ],
    ));
  }
```

Also you need to use `.add` when dispatching events 
**`context.read<BlocClass>().add(DelTodo(index)`**

If it’s not an even then no need to use `.add`

**`context.read<BlocClass>().openField(context, controller)`**
