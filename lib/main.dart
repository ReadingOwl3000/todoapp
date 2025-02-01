import 'package:flutter/material.dart';
import 'package:marie/functions/dark_light_mode_changer.dart';
import 'package:marie/pages/create_todo_dialog.dart';
import 'package:marie/functions/todohandler.dart';
import 'package:marie/pages/modify_todo.dart';
import 'package:marie/todo.dart';
import 'package:provider/provider.dart';

void main() {
  runApp(ChangeNotifierProvider(
    create: (_) => DarkLightModeChanger()..getModePrefs(),
    child: ChangeNotifierProvider(
      create: (_) => ToDosModel()..getPrefs(),
      child: const MyApp(),
    ),
  ));
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return Consumer<DarkLightModeChanger>(
      builder: (context, darkLightModeChanger, _) => MaterialApp(
        title: 'Flutter To-Do App',
        theme: ThemeData(
          colorScheme: ColorScheme.fromSeed(seedColor: Colors.lightBlue),
          useMaterial3: true,
        ),
        darkTheme: ThemeData(
            colorScheme: ColorScheme.fromSeed(
              seedColor: const Color.fromARGB(255, 9, 25, 202),
              brightness: Brightness.dark,
            ),
            useMaterial3: true),
        themeMode: darkLightModeChanger.mode,
        debugShowCheckedModeBanner: false,
        home: const MyHomePage(title: 'Flutter To-Do App'),
      ),
    );
  }
}

class MyHomePage extends StatefulWidget {
  const MyHomePage({super.key, required this.title});
  final String title;

  @override
  State<MyHomePage> createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  @override
  Widget build(BuildContext context) {
    return Consumer2<ToDosModel, DarkLightModeChanger>(
      builder: (context, toDosModel, darkLightModeChanger, _) => Scaffold(
        appBar: AppBar(
          backgroundColor: Theme.of(context).colorScheme.inversePrimary,
          title: Text(widget.title),
          actions: [
            IconButton(
              onPressed: () {
                darkLightModeChanger.toggleModePrefs();
              },
              tooltip: "Toggle Dark/Light Mode",
              icon: Icon(darkLightModeChanger.getCurentIcon()),
            ),
          ],
        ),
        body: ListView(children: <Widget>[
          for (var element in toDosModel.toDos)
            Container(
                alignment: Alignment.center,
                padding: const EdgeInsets.all(8),
                child: GestureDetector(
                  onLongPress: () {
                    ToDoContextDialog.show(
                      context,
                      element,
                    );
                  },
                  child: CheckboxListTile(
                    value: element.state,
                    onChanged: (bool? value) {
                      toDosModel.toggleToDo(element, value!);
                    },
                    title: Text(element.name),
                    subtitle: Text(element.description),
                  ),
                )),
        ]),
        floatingActionButton: FloatingActionButton(
          onPressed: () {
            CreateToDoDialog.show(
              context,
              Todo("", "", false),
            );
          },
          tooltip: 'Add ToDo',
          child: const Icon(Icons.add),
        ),
      ),
    );
  }
}
