import 'dart:io';

import 'package:fimber_io/fimber_io.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:intelligent_money_tracker_mobile/core/constants.dart';
import 'package:intelligent_money_tracker_mobile/core/custom_colors.dart';
import 'package:intelligent_money_tracker_mobile/screens/add_expense/add_expense_page.dart';
import 'package:intelligent_money_tracker_mobile/screens/add_income/add_income_page.dart';
import 'package:intelligent_money_tracker_mobile/screens/home/home_page.dart';
import 'package:intelligent_money_tracker_mobile/screens/login/login_page.dart';
import 'package:intelligent_money_tracker_mobile/screens/register/register_page.dart';
import 'package:intelligent_money_tracker_mobile/services/auth_service.dart';
import 'package:intelligent_money_tracker_mobile/wrapper.dart';
import 'package:path_provider/path_provider.dart';
import 'package:provider/provider.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return FutureBuilder(
      future: _configureLogger(),
      builder: (BuildContext context, AsyncSnapshot snapshot) {
        if (snapshot.connectionState != ConnectionState.done) {
          return const Center(child: CircularProgressIndicator());
        } else {
          return MultiProvider(
            providers: [
              Provider<AuthService>(
                create: (_) => AuthService(),
              ),
            ],
            child: MaterialApp(
              title: 'Intelligent Money Tracker',
              theme: ThemeData(
                // This is the theme of your application.
                //
                // Try running your application with "flutter run". You'll see the
                // application has a blue toolbar. Then, without quitting the app, try
                // changing the primarySwatch below to Colors.green and then invoke
                // "hot reload" (press "r" in the console where you ran "flutter run",
                // or simply save your changes to "hot reload" in a Flutter IDE).
                // Notice that the counter didn't reset back to zero; the application
                // is not restarted.
                scaffoldBackgroundColor: CustomColors.scaffoldBackgroundColor,
                colorScheme: ColorScheme.fromSeed(
                    seedColor: CustomColors.blue,
                    primary: CustomColors.blue,
                    secondary: CustomColors.secondaryBlue),
                fontFamily: 'Sansita',
              ),
              initialRoute: '/',
              routes: {
                '/': (context) => Wrapper(),
                '/login': (context) => const LoginPage(),
                '/register': (context) => const RegisterPage(),
                '/addIncome': (context) => const AddIncomePage(),
                '/addExpense': (context) => const AddExpensePage(),
              },
            ),
          );
        }
      },
    );
  }
}

Future _configureLogger() async {
  final directory = await getExternalStorageDirectory();
  if (directory?.path != null) {
    final Directory _appDocDirFolder = Directory('${directory!.path}/Log');
    if (!await _appDocDirFolder.exists()) {
      await _appDocDirFolder.create(recursive: true);
    }
    var logTree = SizeRollingFileTree(
      DataSize.mega(10),
      filenamePrefix: '${_appDocDirFolder.path}/${Constants.logPrefix}',
      filenamePostfix: Constants.logPostfix,
    );
    Fimber.plantTree(logTree);
  }
}
