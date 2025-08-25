import 'package:bloc_test/state_management.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class Homescreen extends StatefulWidget {
  const Homescreen({super.key});

  @override
  State<Homescreen> createState() => _HomescreenState();
}

class _HomescreenState extends State<Homescreen> {

  final controller = TextEditingController();
  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        body: BlocBuilder<BlocClass, List<TodoObj>>(
          builder:
              (context, state) => ListView.builder(
                itemCount: state.length,
                itemBuilder:
                    (context, int index) => CheckboxListTile(
                      title: Text(state[index].title),
                      controlAffinity: ListTileControlAffinity.leading,
                      secondary: IconButton(
                        onPressed:
                            () => context.read<BlocClass>().add(DelTodo(index)),
                        icon: Icon(Icons.delete),
                      ),
                      value: state[index].isDone,
                      onChanged:
                          (value) =>
                              context.read<BlocClass>().add(TodoToggle(index)),
                    ),
              ),
        ),
        floatingActionButton: FloatingActionButton(
          onPressed:
              () => context.read<BlocClass>().openField(context, controller),
          child: Icon(Icons.add),
        ),
      ),
    );
  }
}
