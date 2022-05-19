import 'package:flutter/material.dart';
import 'package:intelligent_money_tracker_mobile/screens/add_expense/add_expense_widget.dart';

class AddExpensePage extends StatelessWidget {
  final String _title = 'Intelligent Money Tracker';

  const AddExpensePage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(_title),
        leading: Image.asset('assets/img/logo.png'),
      ),
      body: const AddExpenseWidget(),
    );
  }
}
