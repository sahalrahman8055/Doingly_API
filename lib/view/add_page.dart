import 'package:doingly/controller/todo_provider.dart';
import 'package:doingly/services/todo_service.dart';
import 'package:doingly/widgets/snackbar_helper.dart';
import 'package:doingly/view/todo_list.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class AddPage extends StatefulWidget {
  final Map? todo;
  const AddPage({super.key, this.todo});

  @override
  State<AddPage> createState() => _AddPageState();
}

class _AddPageState extends State<AddPage> {
  @override
  void initState() {
     final todoprovider = Provider.of<TodoProvider>(context, listen: false);
    super.initState();
    final todo = widget.todo;
    if (todo != null) {
      todoprovider.isEdit = true;
      final title = todo["title"];
      final description = todo["description"]; // Remove the square brackets
      todoprovider.titleController.text = title;
      todoprovider.descriptionController.text = description;
    }
  }

  @override
  Widget build(BuildContext context) {
    final todoprovider = Provider.of<TodoProvider>(context, listen: false);
    return Scaffold(
      appBar: AppBar(
        title: Center(child: Text(todoprovider.isEdit ? 'Edit Todo' : 'Add Page')),
      ),
      body: ListView(
        padding: EdgeInsets.all(20),
        children: [
          TextField(
            controller: todoprovider.titleController,
            decoration: InputDecoration(hintText: "Title"),
          ),
          TextField(
            controller: todoprovider.descriptionController,
            decoration: InputDecoration(hintText: "Description"),
            keyboardType: TextInputType.multiline,
            minLines: 5,
            maxLines: 8,
          ),
          SizedBox(
            height: 20,
          ),
          ElevatedButton(
              onPressed: todoprovider.isEdit ? updateData : submitData,
              child: Text(todoprovider.isEdit ? "Update" : "submit")),
        ],
      ),
    );
  }

  Future<void> updateData() async {
    final todo = widget.todo;

    if (todo == null) {
      print('You can not call update without todo data');
      return;
    }
    final id = todo['_id'];

    final isSuccess = await TodoService.updateTodo(id, body);

    if (isSuccess) {
      showSuccessMessage(context, message: 'Update Success');

      Navigator.pushReplacement(
        context,
        MaterialPageRoute(builder: (context) => TodoListPage()),
      );
    } else {
      showErorrMessage(context, message: "Update  Failed");
    }
  }

  Future<void> submitData() async {
      final todoprovider = Provider.of<TodoProvider>(context, listen: false);
    final isSuccess = await TodoService.addTodo(body);

    if (isSuccess) {
     todoprovider.titleController.text = "";
     todoprovider.descriptionController.text = "";
      showSuccessMessage(context, message: 'Creation Success');
      Navigator.pushReplacement(
        context,
        MaterialPageRoute(builder: (context) => TodoListPage()),
      );
    } else {
      showErorrMessage(context, message: "Creation Failed");
    }
  }

  Map get body {
      final todoprovider = Provider.of<TodoProvider>(context, listen: false);
    final title = todoprovider.titleController.text;
    final description =todoprovider.descriptionController.text;
    return {
      "title": title,
      "description": description,
      "is_completed": false,
    };
  }
}
