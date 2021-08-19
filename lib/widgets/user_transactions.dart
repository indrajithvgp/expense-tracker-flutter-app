import 'package:expense_tracker/models/transaction.dart';
import 'package:flutter/material.dart';
import './transaction_list.dart';
import './new_transaction.dart';

class UserTransaction extends StatefulWidget {
  _UserTransactionState createState() => _UserTransactionState();
}

class _UserTransactionState extends State<UserTransaction> {
  final List<Transaction> _userTransactions = [
    new Transaction(
        id: "T1", title: "Reebok Tee", amount: 19.99, date: DateTime.now()),
    new Transaction(
        id: "T1", title: "Puma Tee", amount: 29.99, date: DateTime.now()),
  ];

  void _addNewTransaction(String txTitle, double txAmount){
    final newTx = Transaction(
      title: txTitle, amount: txAmount, date: DateTime.now(), id: DateTime.now().toString(),
    );

    setState(() {
      _userTransactions.add(newTx);
    });
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [NewTransaction(_addNewTransaction), TransactionList(_userTransactions)],
    );
  }
}
