import 'package:expense_tracker/widgets/user_transactions.dart';
import 'package:flutter/material.dart';
import './widgets/transaction_list.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {

  final amountController = TextEditingController();
  final titleController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
        home: Scaffold(
            appBar: AppBar(
              title: Text("Demo App Bar"),
            ),
            body: UserTransaction()
                ));
  }
}
