import 'package:doingly/controller/todo_provider.dart';
import 'package:doingly/view/add_page.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';


class TodoListPage extends StatelessWidget {
  const TodoListPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Todo List'),
      ),
      body: Consumer<TodoProvider>(
        builder:(context,value,child){
          return    ListView.builder(
          itemCount: value.items.length,
          itemBuilder: (context,index){
            final todoModel=value.items[index];
            return ListTile(
              leading: Text('${index+1}'),
              title: Text(todoModel.title!),
              subtitle: Text(todoModel.description!),
              trailing: PopupMenuButton(
                onSelected: (value){
                  if(value=='edit'){
                    //open edit page
                    Navigator.of(context).push(MaterialPageRoute(builder: (context)=>AddPage(todoModel:todoModel)));
                  }else if(value=='delete'){
                    //delete and remove the item
                    Provider.of<TodoProvider>(context,listen: false).deleteById(todoModel.id!);
                  }
                },
                itemBuilder:(context){
                  return [
                  const PopupMenuItem(
                    value: 'edit',
                    child:Text('Edit'),),
                    const PopupMenuItem(
                      value: 'delete',
                      child:Text('delete'),)
                  ];
                }),
            );
          });
        } ,
      ),
      floatingActionButton: FloatingActionButton.extended(
        onPressed:(){
          Navigator.of(context).push(MaterialPageRoute(builder:(context)=>const AddPage() ));
        },
        label: const Text('ADD TODO'),
        ),
    );
  }
}