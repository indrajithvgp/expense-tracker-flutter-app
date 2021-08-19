import 'package:flutter/material.dart';

class NewTransaction extends StatelessWidget {
  final amountController = TextEditingController();
  final titleController = TextEditingController();

  final Function addNewTransaction;
  NewTransaction(this.addNewTransaction);
  @override
  Widget build(BuildContext context) {
    return Card(
        child: Container(
      padding: EdgeInsets.all(10),
      child: Column(crossAxisAlignment: CrossAxisAlignment.end, children: [
        TextField(
          decoration: InputDecoration(labelText: 'Title'),
          controller: titleController,
        ),
        TextField(
            decoration: InputDecoration(labelText: 'Price'),
            controller: amountController),
        FlatButton(
            onPressed: () {
              addNewTransaction(titleController.text, double.parse(amountController.text));
            },
            child: Text('Add Transaction'),
            textColor: Colors.purple)
      ]),
    ));
  }
}
