import 'package:doingly/controller/todo_provider.dart';
import 'package:doingly/helper/helper.dart';
import 'package:doingly/view/todo_list.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class AddPage extends StatefulWidget {
  final todoModel;
  const AddPage({super.key, this.todoModel});

  @override
  State<AddPage> createState() => _AddPageState();
}

class _AddPageState extends State<AddPage> {
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    final todo=widget.todoModel;
    final todoProvider = Provider.of<TodoProvider>(context, listen: false);
    if (todo != null) {
      todoProvider.isEditValueChange(true);
      final title=todo.title;
      final descriptio=todo.description;
      todoProvider.titleController.text=title;
      todoProvider.descriptionController.text=descriptio;
    } else {
      todoProvider.isEditValueChange(false);
      todoProvider.titleController.text='';
      todoProvider.descriptionController.text='';
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(Provider.of<TodoProvider>(context).isEdit
            ? 'Edit Todo'
            : 'ADD TODO'),
      ),
      body: ListView(
        padding: const EdgeInsets.all(20),
        children: [
          TextField(
            controller: Provider.of<TodoProvider>(context, listen: false)
                .titleController,
            decoration: const InputDecoration(hintText: 'title'),
          ),
          TextField(
            controller: Provider.of<TodoProvider>(context, listen: false)
                .descriptionController,
            decoration: const InputDecoration(
              hintText: 'Description',
            ),
            keyboardType: TextInputType.multiline,
            minLines: 5,
            maxLines: 8,
          ),
          khight20,
          ElevatedButton(
            onPressed: () {
             final todoProvider= Provider.of<TodoProvider>(context, listen: false);
             todoProvider.isEdit? todoProvider.updateData(widget.todoModel):todoProvider.addData();
             Navigator.of(context).pushReplacement(MaterialPageRoute(builder: (context)=>TodoListPage()));            },
            child: Text(
              Provider.of<TodoProvider>(context).isEdit? 'Update'
            : 'Submit',
            ),
          )
        ],
      ),
    );
  }
}