import 'package:flutter/material.dart';

class TodoCard extends StatelessWidget {
  final int index;
  final Map item;

  final Function(Map) navigateEdit;
  final Function(String) deleteById;

  const TodoCard(
      {super.key,
      required this.index,
      required this.item,
      required this.navigateEdit,
      required this.deleteById});

  @override
  Widget build(BuildContext context) {
    final id = item['_id']as String;
    return Card(
      child: ListTile(
        leading: CircleAvatar(child: Text('${index + 1}')),
        title: Text(item["title"]),
        subtitle: Text(item["description"]),
        trailing: PopupMenuButton(itemBuilder: (context) {
          return [
            PopupMenuItem(
              child: Text('Edit'),
              onTap: () {
                navigateEdit(item);
              },
            ),
            PopupMenuItem(
                child: Text('Delete'),
                onTap: () {
                  deleteById(id);
                }),
          ];
        }),
      ),
    );
    
  }
}
