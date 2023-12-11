import 'package:doingly/services/todo_service.dart';
import 'package:doingly/widgets/snackbar_helper.dart';
import 'package:doingly/view/add_page.dart';
import 'package:doingly/widgets/todo_card.dart';
import 'package:flutter/material.dart';

class TodoListPage extends StatefulWidget {
  const TodoListPage({super.key});

  @override
  State<TodoListPage> createState() => _TodoListPageState();
}

class _TodoListPageState extends State<TodoListPage> {
  bool isLoading = true;
  List items = [];

  @override
  void initState() {
    super.initState();
    fetchTodo();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
     
        title: const Center(
          child: Text(
            "Doingly",
          ),
        ),
      ),
      body: Visibility(
        visible: isLoading,
        child: Center(
          child: CircularProgressIndicator(),
        ),
        replacement: RefreshIndicator(
          onRefresh: fetchTodo,
          child: Visibility(
            visible: items.isNotEmpty,
            replacement: Center(
              child: Text(
                'No Todo Item',
                style: Theme.of(context).textTheme.headlineSmall,
              ),
            ),
            child: ListView.builder(
              itemCount: items.length,
              padding: EdgeInsets.all(8),
              itemBuilder: (context, index) {
                final item = items[index] as Map;
                final id = item['_id'] as String; 
                return TodoCard(
                    index: index,
                    item: item,
                    navigateEdit: navigateToeditPage,
                    deleteById: deleteById);
              },
            ),
          ),
        ),
      ),
      floatingActionButton: FloatingActionButton.extended(
        onPressed: navigateToAddPage,
        label: Text('add Todo'),
      ),
    );
  }

  Future<void> navigateToeditPage(Map item) async {
    final route = MaterialPageRoute(builder: (context) => AddPage(todo: item));
    await Navigator.push(context, route);
    setState(() {
      isLoading = true;
    });
    fetchTodo();
  }






  Future<void> navigateToAddPage() async {
    final route = MaterialPageRoute(builder: (context) => AddPage());
    await Navigator.push(context, route);
    setState(() {
      isLoading = true;
    });
    fetchTodo();
  }




// ...

  Future<void> deleteById(String id) async {
    final isSuccess = await TodoService.deleteById(id);
    if (isSuccess) {
      setState(() {
        items = items.where((element) => element['_id'] != id).toList();
      });
    } else {
      showErorrMessage(context, message: ' Deletion Failed');
    }
  }






  Future<void> fetchTodo() async {
    final response = await TodoService.fetchTodo();

    if (response != null) {
      setState(() {
        items = response;
      });
    } else {
      showErorrMessage(context, message: ' Something went wrong');
    }

    setState(() {
      isLoading = false;
    });
  }
}
