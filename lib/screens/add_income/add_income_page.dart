import 'package:flutter/material.dart';
import 'package:intelligent_money_tracker_mobile/screens/add_income/add_income_widget.dart';

class AddIncomePage extends StatelessWidget {
  final String _title = 'Intelligent Money Tracker';

  const AddIncomePage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(_title),
        leading: Image.asset('assets/img/logo.png'),
      ),
      body: const AddIncomeWidget(),
    );
  }
}
