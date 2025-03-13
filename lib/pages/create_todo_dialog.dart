import 'package:flutter/material.dart';
import 'package:marie/functions/todohandler.dart';
import 'package:marie/todo.dart';
import 'package:provider/provider.dart';

class CreateToDoDialog extends StatefulWidget {
  final Todo toEditToDo;
  const CreateToDoDialog(this.toEditToDo, {super.key});
  static Future<T?> show<T>(BuildContext context, toEditToDo) async =>
      await showDialog(
          context: context,
          builder: (_) => CreateToDoDialog(
                toEditToDo,
              ));
  @override
  State<CreateToDoDialog> createState() => _CreateToDoDialogState();
}

class _CreateToDoDialogState extends State<CreateToDoDialog> {
  String? error;

  @override
  Widget build(BuildContext context) {
    var titleController = TextEditingController(text: widget.toEditToDo.name);

    var descController =
        TextEditingController(text: widget.toEditToDo.description);
    Todo oldToDo = widget.toEditToDo;
    bool state = widget.toEditToDo.state;
    return AlertDialog(
      alignment: Alignment.center,
      content: SizedBox(
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            TextField(
              onSubmitted: (value) {
                popOnSubmit(
                    Todo(titleController.text, descController.text, state),
                    oldToDo,
                    context);
              },
              controller: titleController,
              decoration: InputDecoration(
                hintText: "Title",
                border: OutlineInputBorder(),
                errorText: error,
              ),
            ),
            TextField(
              onSubmitted: (value) {
                popOnSubmit(
                    Todo(titleController.text, descController.text, state),
                    oldToDo,
                    context);
              },
              controller: descController,
              decoration: InputDecoration(
                hintText: "Description",
                border: OutlineInputBorder(),
              ),
            ),
            TextButton(
                onPressed: () {
                  popOnSubmit(
                    Todo(titleController.text, descController.text, state),
                    oldToDo,
                    context,
                  );
                },
                child: Text("Save"))
          ],
        ),
      ),
    );
  }

  void popOnSubmit(Todo toDo, oldToDo, BuildContext context) {
    if (toDo.name.trim() != "") {
      var toDosModel = Provider.of<ToDosModel>(context, listen: false);
      toDosModel.editToDo(oldToDo, toDo);
      Navigator.of(context).pop(true);
    } else {
      setState(() {
        error = "enter a title";
      });
    }
  }
}
