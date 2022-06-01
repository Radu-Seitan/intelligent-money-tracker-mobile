import 'package:flutter/material.dart';
import 'package:intelligent_money_tracker_mobile/screens/add_income/add_income_page.dart';
import 'package:intelligent_money_tracker_mobile/services/auth_service.dart';
import 'package:provider/provider.dart';

class HomePage extends StatelessWidget {
  final String _title = 'Intelligent Money Tracker';

  const HomePage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final authService = Provider.of<AuthService>(context);

    return Scaffold(
      appBar: AppBar(
        title: Text(_title),
        leading: Image.asset('assets/img/logo.png'),
      ),
      body: Column(
        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
        children: [
          Text(
            'Total sum: ${authService.getUser(authService.userId).then((value) => value.sum)}',
            style: TextStyle(fontSize: 25),
          ),
          ElevatedButton(
            child: const Text(
              'Add income',
              style: TextStyle(fontSize: 16),
            ),
            onPressed: () {
              Navigator.pushNamed(context, '/addIncome');
            },
          ),
          ElevatedButton(
            child: const Text(
              'Add expense',
              style: TextStyle(fontSize: 16),
            ),
            onPressed: () {
              Navigator.pushNamed(context, '/addExpense');
            },
          ),
          Center(
            child: ElevatedButton(
              child: const Text(
                'Logout',
                style: TextStyle(fontSize: 16),
              ),
              onPressed: () async {
                await authService.signOut();
              },
            ),
          ),
        ],
      ),
    );
  }
}
