import 'package:doingly/model/todo_model.dart';
import 'package:doingly/services/todo_service.dart';
import 'package:flutter/material.dart';

class TodoProvider extends ChangeNotifier{
   bool isLoading = true;

  TextEditingController titleController = TextEditingController();
  TextEditingController descriptionController = TextEditingController();
  bool isEdit = false;
 List<TodoModel> items=[];
 TodoService todoServise = TodoService();

  void addData(){
  

  }
}







