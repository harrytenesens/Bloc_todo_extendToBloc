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

    on<TodoToggle>((event, emit) {
      final currentList = List<TodoObj>.from(state);
      currentList[event.index].isDone = !currentList[event.index].isDone;
      emit(currentList);
    });

    on<DelTodo>((event, emit) {
      final currentList = List<TodoObj>.from(state);
      currentList.removeAt(event.index);
      emit(currentList);
    });
  }
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
}
