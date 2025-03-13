import 'package:flutter/material.dart';
import 'package:marie/functions/todohandler.dart';
import 'package:marie/pages/create_todo_dialog.dart';
import 'package:marie/todo.dart';
import 'package:provider/provider.dart';

class ToDoContextDialog extends StatelessWidget {
  const ToDoContextDialog(this.element, {super.key});
  static show(BuildContext context, element) =>
      showDialog(context: context, builder: (_) => ToDoContextDialog(element));
  final Todo element;
  @override
  Widget build(BuildContext context) {
    return Dialog(
      alignment: Alignment.center,
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          TextButton(
            onPressed: () {
              Provider.of<ToDosModel>(context, listen: false)
                  .removeToDo(element);
              Navigator.pop(context);
            },
            child: Text("Delete this To-Do"),
          ),
          TextButton(
            onPressed: () async {
              var toDosModel = Provider.of<ToDosModel>(context, listen: false);
              Navigator.of(context).pop();
              var succes = await CreateToDoDialog.show(context, element);
              if (succes == true) {
                toDosModel.removeToDo(element);
              }
            },
            child: Text("Edit this To-Do"),
          )
        ],
      ),
    );
  }
}
