import 'package:doingly/model/todo_model.dart';
import 'package:doingly/services/todo_service.dart';
import 'package:flutter/material.dart';


class TodoProvider extends ChangeNotifier {
  
 TodoProvider(){
  fetchTodo();
 }
  TextEditingController titleController = TextEditingController();
  TextEditingController descriptionController = TextEditingController();
  List<TodoModel> items=[];
  bool isEdit =false;
  TodoServices todoServices=TodoServices();
  

  Future<void> addData() async {
    //get the data from form
    final title = titleController.text;
    final description = descriptionController.text;
   final requestModel=TodoModel(
    title: title,
     description: description,
      iscompleted: false);

      await todoServices.SubmitData(requestModel);
      titleController.text='';
      descriptionController.text='';
      fetchTodo();
  }

  Future<void> fetchTodo()async{
     items=await todoServices.fetchTodo();
      notifyListeners();
    } 
  

  Future<void> deleteById(String id)async{
     await todoServices.deleteById(id);
     items.removeWhere((todo) => todo.id==id);
     notifyListeners();
  }


  Future<void> updateData(TodoModel todoModel)async{
    if(todoModel==null){
      print('you can not call updated without todo data');
      return;
    }
    final id=todoModel.id;
    final title=titleController.text;
    final description=descriptionController.text;
     final requestModel=TodoModel(
      id: id,
      title: title,
       description: description,
        iscompleted: false);

    try{
      await todoServices.updateData(requestModel,id);
    fetchTodo();
    }catch(e){
      throw Exception('update :$e');

    }
     
  }

  void isEditValueChange(bool value){
    isEdit=value;
  }


  



}





