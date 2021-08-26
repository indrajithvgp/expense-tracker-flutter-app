import 'dart:io';
import 'package:expense_tracker/widgets/chart.dart';
import 'package:flutter/material.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/services.dart';
import './models/transaction.dart';
import './widgets/new_transaction.dart';
import './widgets/transactions_list.dart';

void main() {
  // WidgetsFlutterBinding.ensureInitialized();
  // SystemChrome.setPreferredOrientations(
  //     [DeviceOrientation.portraitDown, DeviceOrientation.portraitUp]);
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    // SystemChrome.setPreferredOrientations(
    //   [
    //     DeviceOrientation.portraitUp,
    //     DeviceOrientation.portraitDown,
    //   ],
    // );
    return MaterialApp(
        title: "Expense Tracker",
        theme: ThemeData(
            primarySwatch: Colors.green,
            accentColor: Colors.amber,
            errorColor: Colors.red,
            fontFamily: 'QuickSand',
            textTheme: ThemeData.light().textTheme.copyWith(
                  title: const TextStyle(
                      fontFamily: 'OpenSans',
                      fontWeight: FontWeight.bold,
                      fontSize: 20),
                  button: const TextStyle(color: Colors.white),
                ),
            appBarTheme: AppBarTheme(
                textTheme: ThemeData.light().textTheme.copyWith(
                    title: const TextStyle(
                        fontFamily: 'OpenSans', fontSize: 20)))),
        home: HomePage());
  }
}

class HomePage extends StatefulWidget {
  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  final List<Transaction> _userTransactions = [
    // Transaction(
    //   id: 't1',
    //   title: 'Reebok Tee',
    //   amount: 69.99,
    //   date: DateTime.now(),
    // ),
    // Transaction(
    //   id: 't2',
    //   title: 'Weekly Groceries',
    //   amount: 16.53,
    //   date: DateTime.now(),
    // ),
  ];

  List<Transaction> get _recentTransactions {
    return _userTransactions
        .where((element) =>
            element.date.isAfter(DateTime.now().subtract(Duration(days: 7))))
        .toList();
  }

  void _addNewTransaction(String txTitle, double txAmount, DateTime date) {
    final newTx = Transaction(
      title: txTitle,
      amount: txAmount,
      date: date,
      id: DateTime.now().toString(),
    );

    setState(() {
      _userTransactions.add(newTx);
    });
  }

  void _deleteTransaction(String id) {
    setState(() {
      _userTransactions.removeWhere((tx) => tx.id == id);
    });
  }

  void _startAddNewTransaction(BuildContext ctx) {
    showModalBottomSheet(
        context: ctx,
        builder: (_) {
          return GestureDetector(
              onTap: () {},
              child: NewTransaction(_addNewTransaction),
              behavior: HitTestBehavior.opaque);
        });
  }

  bool _showChart = false;
  void changeVal(val) {
    setState(() {
      _showChart = val;
    });
  }

  List<Widget> _buildLandscapeContent(MediaQueryData mediaQuery, AppBar _appBar,
      bool _showChart, Widget _container) {
    return [
      Row(mainAxisAlignment: MainAxisAlignment.center, children: [
        Text('Show Chart', style: Theme.of(context).textTheme.title),
        Switch.adaptive(
            activeColor: Theme.of(context).accentColor,
            value: _showChart,
            onChanged: (value) {
              changeVal(value);
            })
      ]),
      _showChart
          ? Container(
              height: (mediaQuery.size.height -
                      _appBar.preferredSize.height -
                      mediaQuery.padding.top) *
                  0.6,
              child: Chart(_recentTransactions))
          : _container,
    ];
  }

  List<Widget> _buildPortraitContent(
      MediaQueryData mediaQuery, AppBar appBar, Widget _container) {
    return [
      Container(
          height: (mediaQuery.size.height -
                  appBar.preferredSize.height -
                  mediaQuery.padding.top) *
              0.3,
          child: Chart(_recentTransactions)),
      _container
    ];
  }

  @override
  Widget build(BuildContext context) {
    final mediaQuery = MediaQuery.of(context);
    final _isLandScape = mediaQuery.orientation == Orientation.landscape;

    final PreferredSizeWidget _appBar = Platform.isIOS
        ? CupertinoNavigationBar(
            middle: Text("Expense Tracker"),
            trailing: Row(mainAxisSize: MainAxisSize.min, children: [
              GestureDetector(
                  child: const Icon(CupertinoIcons.add),
                  onTap: () {
                    _startAddNewTransaction(context);
                  })
            ]),
          )
        : AppBar(
            title: const Text("Expense Tracker",
                style: const TextStyle(fontFamily: 'OpenSans')),
            actions: [
              IconButton(
                  onPressed: () => _startAddNewTransaction(context),
                  icon: Icon(Icons.add))
            ],
          );

    final _container = Container(
        height: (mediaQuery.size.height -
                _appBar.preferredSize.height -
                mediaQuery.padding.top) *
            0.7,
        child: TransactionList(_userTransactions, _deleteTransaction));

    final _body = SafeArea(
        child: SingleChildScrollView(
      child: Column(
        // mainAxisAlignment: MainAxisAlignment.start,
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: <Widget>[
          if (_isLandScape)
            ..._buildLandscapeContent(
                mediaQuery, _appBar, _showChart, _container),
          if (!_isLandScape)
            ..._buildPortraitContent(mediaQuery, _appBar, _container),
        ],
      ),
    ));

    return Platform.isIOS
        ? CupertinoPageScaffold(
            child: _body,
            navigationBar: _appBar,
          )
        : Scaffold(
            appBar: _appBar,
            body: _body,
            floatingActionButtonLocation:
                FloatingActionButtonLocation.centerFloat,
            floatingActionButton: Platform.isIOS
                ? Container()
                : FloatingActionButton(
                    onPressed: () => _startAddNewTransaction(context),
                    child: const Icon(Icons.add)),
          );
  }
}
