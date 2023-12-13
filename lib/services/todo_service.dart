import 'dart:convert';

import 'package:doingly/model/todo_model.dart';
import 'package:http/http.dart' as http;


class TodoServices{
  Future<List<TodoModel>> fetchTodo()async{
    const url='https://api.nstack.in/v1/todos?page=1&limit=10';
    final uri=Uri.parse(url);
    final response= await http.get(uri);
    if(response.statusCode==200){
      final json=jsonDecode(response.body) as Map;
      final result =json['items'] as List;
      return result.map((json) => TodoModel.fromJson(json)).toList();
      
    } else{
      throw Exception('Filed to fetch todo');
    }
  }


   Future<void> SubmitData(TodoModel requestModel) async {

      final body =requestModel.toJson();

    //submit data for the server
    const url = "https://api.nstack.in/v1/todos";
    final uri = Uri.parse(url);
    final response = await http.post(uri,
        body: jsonEncode(body), headers: {'Content-Type': 'application/json'});
    //show success or not messege based on status
    if (response.statusCode == 201) {
      print('creation success');
    } else {
      print('creation failed');
    }
  }

  Future<void> deleteById(String id)async{
  final url='https://api.nstack.in/v1/todos/$id';
   final uri=Uri.parse(url);
   final response=await http.delete(uri);
   if(response.statusCode==200){
    print('delete success');
   }else{
   //error
   print('error');
   }
  }


    Future<void> updateData(TodoModel requestModel,id)async{
        final body=requestModel.toJson();

       //update data for the server
    final url = "https://api.nstack.in/v1/todos/$id";
    final uri = Uri.parse(url);
    final response = await http.put(uri,
        body: jsonEncode(body),
         headers: {'Content-Type': 'application/json'});
    //show success or not messege based on status
    if (response.statusCode == 200) {
      print('Updation success');
    } else {
      print('Updation failed');
    }
  }

}