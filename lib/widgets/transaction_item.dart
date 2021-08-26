import 'package:flutter/material.dart';
import "package:intl/intl.dart";
import '../models/transaction.dart';

class TransactionItem extends StatelessWidget {
  const TransactionItem({
    @required this.transaction,
    @required this.mediaQuery,
    @required this.deleteTransaction,
  });

  final Transaction transaction;
  final MediaQueryData mediaQuery;
  final Function deleteTransaction;

  @override
  Widget build(BuildContext context) {
    return Card(
      margin: const EdgeInsets.symmetric(vertical: 6, horizontal: 8),
      elevation: 5,
      child: ListTile(
        leading: CircleAvatar(
            radius: 30,
            child: Padding(
              padding: const EdgeInsets.all(6),
              child: FittedBox(
                child: Text('\$${transaction.amount}'),
              ),
            )),
        title: Text(transaction.title,
            style: Theme.of(context).textTheme.title),
        subtitle: Text(DateFormat.yMMMd().format(transaction.date),
            style: Theme.of(context).textTheme.title),
        trailing: mediaQuery.size.width > 470
            ? FlatButton.icon(
                icon: const Icon(Icons.delete),
                label: const Text('Delete'),
                textColor: Theme.of(context).errorColor,
                onPressed: () {
                  deleteTransaction(transaction.id);
                })
            : IconButton(
                icon: Icon(Icons.delete, color: Theme.of(context).errorColor),
                onPressed: () => deleteTransaction(transaction.id),
              ),
      ),
    );
  }
}
