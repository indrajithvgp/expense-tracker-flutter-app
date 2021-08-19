import 'package:flutter/material.dart';
import './transaction.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  final List<Transaction> transactions = [
    Transaction(
        id: 't1', title: 'new shoes', date: DateTime.now(), amount: 99.99),
    Transaction(
        id: 't2', title: 'new jacket', date: DateTime.now(), amount: 100.99)
  ];

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
        home: Scaffold(
            appBar: AppBar(
              title: Text("Demo App Bar"),
            ),
            body: Column(
                mainAxisAlignment: MainAxisAlignment.spaceAround,
                crossAxisAlignment: CrossAxisAlignment.stretch,
                children: <Widget>[
                  Container(
                      width: double.infinity,
                      child: Card(child: Text("First Child"), elevation: 5)),
                  Column(
                    children: transactions.map((tx) {
                      return Card(
                        child: Row(children: [
                          Container(
                            margin:EdgeInsets.symmetric(
                              vertical: 10,
                              horizontal: 15,
                            ),
                            decoration: BoxDecoration(border: Border.all(color: Colors.purple, width:2)),
                            padding:EdgeInsets.all(10),
                            child: Text(tx.amount.toString(), 
                              style: TextStyle(fontWeight: FontWeight.bold, 
                            fontSize: 20, color: Colors.purple),),),
                          Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                            Text(tx.title, style: TextStyle(fontWeight: FontWeight.bold, fontSize: 16, color:Colors.black)),
                            Text(tx.date.toString(), style: TextStyle(fontWeight: FontWeight.normal, fontSize: 16, color:Colors.grey))
                          ],)
                        ],),
                      );
                    }).toList(),
                  )
                ])));
  }
}
