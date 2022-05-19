import 'package:flutter/material.dart';
import 'package:intelligent_money_tracker_mobile/services/auth_service.dart';
import 'package:provider/provider.dart';

class RegisterPage extends StatelessWidget {
  final String _title = 'Intelligent Money Tracker';

  const RegisterPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final TextEditingController emailController = TextEditingController();
    final TextEditingController passwordController = TextEditingController();

    final authService = Provider.of<AuthService>(context);
    return Scaffold(
      appBar: AppBar(
        title: Text(_title),
        leading: Image.asset('assets/img/logo.png'),
      ),
      body: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: TextField(
              controller: emailController,
              decoration: const InputDecoration(
                labelText: 'Email',
              ),
            ),
          ),
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: TextField(
              controller: passwordController,
              obscureText: true,
              decoration: const InputDecoration(
                labelText: 'Password',
              ),
            ),
          ),
          ElevatedButton(
            child: const Text(
              'Register',
              style: TextStyle(fontSize: 16),
            ),
            onPressed: () async {
              await authService.createUserWithEmailAndPassword(
                emailController.text,
                passwordController.text,
              );
              Navigator.pop(context);
            },
          ),
        ],
      ),
    );
  }
}
