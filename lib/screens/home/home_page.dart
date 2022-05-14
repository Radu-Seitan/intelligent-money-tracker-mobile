import 'package:flutter/material.dart';
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
      body:Column(
        mainAxisAlignment: MainAxisAlignment.spaceAround,
        children: [
          Text('Home Screen'),
          Center(
            child: ElevatedButton(
              child: Text('Logout'),
              onPressed: () async{
                await authService.signOut();
              },
            ),
          ),
        ],
      ),
    );
  }
}
